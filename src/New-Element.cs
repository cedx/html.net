namespace Belin.Html;

using System.Collections;
using System.Globalization;
using System.Net;
using System.Text;
using System.Text.Json;

/// <summary>
/// Provides the abstract base class for a cmdlet rendering an HTML element.
/// </summary>
/// <param name="tagName">The tag name of the element to create.</param>
/// <param name="isVoid">Value indicating whether the element to create is a void element.</param>
public abstract class NewElementCommand(string tagName, bool isVoid = false): PSCmdlet {

	/// <summary>
	/// The HTML-encoded string corresponding to a double quote.
	/// </summary>
	private static readonly string encodedDoubleQuote = WebUtility.HtmlEncode("\"");

	/// <summary>
	/// The custom attributes to render.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public Hashtable Attributes { get; set; } = [];

	/// <summary>
	/// Value indicating whether inputted text is automatically capitalized.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true), ValidateSet("characters", "none", "off", "on", "sentences", "words")]
	public string? AutoCapitalize { get; set; }

	/// <summary>
	/// Value indicating whether the element should have input focus when the page loads.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public SwitchParameter AutoFocus { get; set; }

	/// <summary>
	/// The CSS class names applied to the element.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string[] Class { get; set; } = [];

	/// <summary>
	/// The inner HTML of the element.
	/// </summary>
	[Parameter(Position = 0, ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
	public virtual object? Content { get; set; }

	/// <summary>
	/// Value indicating whether the element is editable by the user.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true), ValidateSet("false", "plaintext-only", "true")]
	public string? ContentEditable { get; set; }

	/// <summary>
	/// The data attributes to render.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public Hashtable DataSet { get; set; } = [];

	/// <summary>
	/// The directionality of the element's text.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true), ValidateSet("auto", "ltr", "rtl")]
	public string? Dir { get; set; }

	/// <summary>
	/// Value indicating whether the element can be dragged.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true), ValidateSet("false", "true")]
	public string? Draggable { get; set; }

	/// <summary>
	/// Value indicating whether the browser should not render the contents of the element.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public SwitchParameter Hidden { get; set; }

	/// <summary>
	/// The element identifier.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string? Id { get; set; }

	/// <summary>
	/// A hint at the type of data that might be entered by the user while editing the element or its contents.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true), ValidateSet("decimal", "email", "none", "numeric", "search", "tel", "text", "url")]
	public string? InputMode { get; set; }

	/// <summary>
	/// The element's language.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public CultureInfo? Lang { get; set; }

	/// <summary>
	/// Value indicating whether the element is a popover element.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true), ValidateSet("auto", "hint", "manual")]
	public string? Popover { get; set; }

	/// <summary>
	/// The event handler attributes to render.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public Hashtable On { get; set; } = [];

	/// <summary>
	/// Value indicating whether the element is subject to spell-checking by the underlying browser/OS.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true), ValidateSet("false", "true")]
	public string? SpellCheck { get; set; }

	/// <summary>
	/// The CSS styling declarations applied to the element.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public OrderedHashtable Style { get; set; } = [];

	/// <summary>
	/// Determines the relative ordering of the element for sequential focus navigation.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public int? TabIndex { get; set; }

	/// <summary>
	/// A text representing advisory information related to the element.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string? Title { get; set; }

	/// <summary>
	/// Value indicating whether the element's text should be translated when the page is localized.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true), ValidateSet("no", "yes")]
	public string? Translate { get; set; }

	/// <summary>
	/// Value indicating whether the element to create is a void element.
	/// </summary>
	protected bool IsVoid { get; set; } = isVoid;

	/// <summary>
	/// The tag name of the element to create.
	/// </summary>
	protected string TagName { get; set; } = tagName;

	/// <summary>
	/// Performs execution of this command.
	/// </summary>
	protected override void ProcessRecord() {
		var attributes = Attributes.Cast<DictionaryEntry>().ToDictionary(entry => entry.Key.ToString() ?? "", entry => entry.Value, StringComparer.OrdinalIgnoreCase);
		RenderAttributes(attributes);

		var builder = new StringBuilder($"<{TagName}");
		foreach (var (key, value) in attributes) if (value is not null) {
			if (value is bool booleanValue) {
				if (booleanValue) builder.Append($" {key}");
			}
			else {
				var stringValue = Convert.ToString(value, CultureInfo.InvariantCulture)?.Replace("\"", encodedDoubleQuote);
				builder.Append($" {key}=\"{stringValue}\"");
			}
		}

		if (IsVoid) builder.Append('>');
		else {
			var output = Content is ScriptBlock scriptBlock ? scriptBlock.Invoke().Select(psObject => psObject.BaseObject) : (Content is not null ? [Content] : []);
			builder.Append('>');
			foreach (var value in output) builder.Append(value);
			builder.Append($"</{TagName}>");
		}

		WriteObject(builder.ToString());
	}

	/// <summary>
	/// Populates the specified attribute collection with the element attributes.
	/// </summary>
	/// <param name="attributes">The attribute collection to populate.</param>
	protected virtual void RenderAttributes(IDictionary<string, object?> attributes) {
		var kebabCase = JsonNamingPolicy.KebabCaseLower.ConvertName;

		if (!string.IsNullOrWhiteSpace(Id)) attributes["id"] = Id;
		if (AutoCapitalize is not null) attributes["autocapitalize"] = AutoCapitalize;
		if (AutoFocus) attributes["autofocus"] = true;
		if (Class.Length > 0) attributes["class"] = string.Join(' ', Class).Trim();
		if (ContentEditable is not null) attributes["contenteditable"] = ContentEditable;
		foreach (DictionaryEntry entry in DataSet) attributes[$"data-{kebabCase(entry.Key.ToString() ?? "")}"] = entry.Value;
		if (Dir is not null) attributes["dir"] = Dir;
		if (Draggable is not null) attributes["draggable"] = Draggable;
		if (Hidden) attributes["hidden"] = true;
		if (InputMode is not null) attributes["inputmode"] = InputMode;
		if (Lang is not null) attributes["lang"] = Lang.Name;
		foreach (DictionaryEntry entry in On) attributes[$"on{entry.Key.ToString()?.ToLowerInvariant()}"] = entry.Value;
		if (Popover is not null) attributes["popover"] = Popover;
		if (SpellCheck is not null) attributes["spellcheck"] = SpellCheck;
		if (TabIndex is not null) attributes["tabindex"] = TabIndex.Value.ToString(CultureInfo.InvariantCulture);
		if (!string.IsNullOrWhiteSpace(Title)) attributes["title"] = Title;
		if (Translate is not null) attributes["translate"] = Translate;

		if (Style.Count > 0) attributes["style"] = string.Join("; ", Style.Cast<DictionaryEntry>()
			.Select(entry => $"{kebabCase(entry.Key.ToString() ?? "")}: {Convert.ToString(entry.Value, CultureInfo.InvariantCulture)?.Replace("\"", encodedDoubleQuote)}"));
	}
}
