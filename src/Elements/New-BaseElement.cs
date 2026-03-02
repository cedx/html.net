namespace Belin.Html.Cmdlets.Elements;

/// <summary>
/// Creates a new <c>base</c> element.
/// </summary>
[Cmdlet(VerbsCommon.New, "BaseElement"), Alias("base"), OutputType(typeof(string))]
public class NewBaseElementCommand(): NewElementCommandBase("base", isVoid: true) {

	/// <summary>
	/// The base URL to be used throughout the document for relative URLs.
	/// </summary>
	[Parameter(Mandatory = true, ValueFromPipelineByPropertyName = true)]
	public required Uri Href { get; set; }

	/// <summary>
	/// The default browsing context to show the results of navigation from elements without explicit <c>target</c> attribute.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string Target { get; set; } = "";

	/// <summary>
	/// Populates the specified attribute collection with the attributes of this element.
	/// </summary>
	/// <param name="attributes">The attribute collection to populate.</param>
	protected override void RenderAttributes(Dictionary<string, object?> attributes) {
		base.RenderAttributes(attributes);
		attributes["href"] = Href.ToString();
		if (!string.IsNullOrWhiteSpace(Target)) attributes["target"] = Target;
	}
}
