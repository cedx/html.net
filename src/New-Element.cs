namespace Belin.Html.Cmdlets;

using System.Collections;
using System.Globalization;
using System.Net;
using System.Text;
using System.Text.Json;

/// <summary>
/// Provides the abstract base class for a cmdlet generating an HTML element.
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
	/// The CSS class names applied to this element.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string[] Class { get; set; } = [];

	/// <summary>
	/// The inner HTML of this element.
	/// </summary>
	[Parameter(Position = 0, ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
	public virtual object? Content { get; set; }

	/// <summary>
	/// The data attributes to render.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public Hashtable Data { get; set; } = [];

	/// <summary>
	/// The element identifier.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string Id { get; set; } = "";

	/// <summary>
	/// Value indicating whether the element to create is a void element.
	/// </summary>
	public bool IsVoid { get; protected set; } = isVoid;

	/// <summary>
	/// The CSS styling declarations applied to this element.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public Hashtable Style { get; set; } = [];

	/// <summary>
	/// The tag name of the element to create.
	/// </summary>
	public string TagName { get; protected set; } = tagName;

	/// <summary>
	/// Performs execution of this command.
	/// </summary>
	protected override void ProcessRecord() {
		var attributes = Attributes.Cast<DictionaryEntry>().ToDictionary(entry => entry.Key.ToString() ?? "", entry => entry.Value);
		RenderAttributes(attributes);

		var builder = new StringBuilder($"<{TagName}");
		foreach (var (key, value) in attributes) if (value is not null) {
			if (value is bool rendered) {
				if (rendered) builder.Append($" {key}");
			}
			else {
				var stringValue = Convert.ToString(value, CultureInfo.InvariantCulture)?.Replace("\"", encodedDoubleQuote);
				if (!string.IsNullOrWhiteSpace(stringValue)) builder.Append($" {key}=\"{stringValue}\"");
			}
		}

		if (IsVoid) builder.Append(" />");
		else {
			var values = Content is ScriptBlock scriptBlock ? scriptBlock.Invoke().Select(psObject => psObject.BaseObject) : (Content is null ? [] : [Content]);
			builder.Append('>');
			foreach (var value in values) builder.Append(value);
			builder.Append($"</{TagName}>");
		}

		WriteObject(builder.ToString());
	}

	/// <summary>
	/// Populates the specified attribute collection with the attributes of this element.
	/// </summary>
	/// <param name="attributes">The attribute collection to populate.</param>
	protected virtual void RenderAttributes(Dictionary<string, object?> attributes) {
		if (!string.IsNullOrWhiteSpace(Id)) attributes["id"] = Id;
		if (Class.Length > 0) attributes["class"] = string.Join(' ', Class);

		if (Data.Count > 0) foreach (DictionaryEntry entry in Data) {
			var attribute = $"data-{JsonNamingPolicy.KebabCaseLower.ConvertName(entry.Key.ToString() ?? "")}";
			attributes[attribute] = entry.Value;
		}

		if (Style.Count > 0) {
			var rules = Style.Cast<DictionaryEntry>().Select(entry => $"{entry.Key}: {Convert.ToString(entry.Value, CultureInfo.InvariantCulture)?.Replace("\"", encodedDoubleQuote)}");
			attributes["style"] = string.Join("; ", rules);
		}
	}
}
