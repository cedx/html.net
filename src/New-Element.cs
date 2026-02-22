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
	[Parameter]
	public Hashtable? Attributes { get; set; }

	/// <summary>
	/// TODO
	/// </summary>
	[Parameter]
	public string Class { get; set; } = "";

	/// <summary>
	/// TODO
	/// </summary>
	[Parameter(Position = 0)]
	public object? Content { get; set; }

	/// <summary>
	/// TODO
	/// </summary>
	[Parameter]
	public string Id { get; set; } = "";

	/// <summary>
	/// TODO
	/// </summary>
	[Parameter]
	public string Style { get; set; } = "";

	/// <summary>
	/// Performs execution of this command.
	/// </summary>
	protected override void ProcessRecord() {
		var builder = new StringBuilder($"<{tag}");
		if (!string.IsNullOrWhiteSpace(Id)) builder.Append($" id=\"{Id}\"");
		if (!string.IsNullOrWhiteSpace(Class)) builder.Append($" class=\"{Class}\"");
		if (!string.IsNullOrWhiteSpace(Style)) builder.Append($" style=\"{Style.Replace("\"", "&quot;")}\"");

		if (Attributes is not null) foreach (DictionaryEntry attribute in Attributes)
			builder.Append($" {attribute.Key}=\"{Convert.ToString(attribute.Value)?.Replace("\"", "&quot;")}\"");

		if (isVoid) builder.Append(" />");
		else {
			builder.Append('>');
			builder.Append(Content is ScriptBlock scriptBlock ? scriptBlock.Invoke() : (Content is string content ? WebUtility.HtmlEncode(content) : Content));
			builder.Append($"</{tag}");
		}

		WriteObject(builder.ToString());
	}
}
