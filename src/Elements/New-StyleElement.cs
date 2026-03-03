namespace Belin.Html.Cmdlets.Elements;

/// <summary>
/// Creates a new <c>style</c> element.
/// </summary>
[Cmdlet(VerbsCommon.New, "StyleElement"), Alias("style"), OutputType(typeof(string))]
public class NewStyleElementCommand(): NewElementCommand("style", isVoid: false) {

	/// <summary>
	/// Defines which media the style should be applied to.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string Media { get; set; } = "";

	/// <summary>
	/// Populates the specified attribute collection with the element attributes.
	/// </summary>
	/// <param name="attributes">The attribute collection to populate.</param>
	protected override void RenderAttributes(Dictionary<string, object?> attributes) {
		base.RenderAttributes(attributes);
		if (!string.IsNullOrWhiteSpace(Media)) attributes["media"] = Media;
	}
}
