namespace Belin.Html.Cmdlets;

using System.Collections;
using System.Net;
using System.Text;

/// <summary>
/// Provides the abstract base class for a cmdlet generating an HTML element.
/// </summary>
/// <param name="tag">The tag name of the element to create.</param>
/// <param name="isVoid">Value indicating whether the element to create is a void element.</param>
public abstract class NewElementCommand(string tag, bool isVoid = false): Cmdlet {

	/// <summary>
	/// TODO
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public Hashtable? Attributes { get; set; }

	/// <summary>
	/// TODO
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string Class { get; set; } = "";

	/// <summary>
	/// TODO
	/// </summary>
	[Parameter(Position = 0, ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
	public object? Content { get; set; }

	/// <summary>
	/// TODO
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string Id { get; set; } = "";

	/// <summary>
	/// TODO
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string Style { get; set; } = "";

	/// <summary>
	/// Performs execution of this command.
	/// </summary>
	protected override void ProcessRecord() {
		Attributes ??= [];
		if (!string.IsNullOrWhiteSpace(Id)) Attributes["id"] = Id;
		if (!string.IsNullOrWhiteSpace(Class)) Attributes["class"] = Class;
		if (!string.IsNullOrWhiteSpace(Style)) Attributes["style"] = Style;

		var builder = new StringBuilder($"<{tag}");
		foreach (DictionaryEntry attribute in Attributes) {
			if (attribute.Value is bool booleanValue)
				if (booleanValue) builder.Append($" {attribute.Key}");
			else {
				var value = Convert.ToString(attribute.Value)?.Replace("\"", "&quot;");
				if (!string.IsNullOrWhiteSpace(value)) builder.Append($" {attribute.Key}=\"{value}\"");
			}
		}

		if (isVoid) builder.Append(" />");
		else {
			var value = Content is ScriptBlock scriptBlock
				? scriptBlock.Invoke().Select(psObject => psObject.BaseObject)
				: (Content is string content ? WebUtility.HtmlEncode(content) : Content);

			builder.Append('>');
			builder.Append(value);
			builder.Append($"</{tag}>");
		}

		WriteObject(builder.ToString());
	}
}
