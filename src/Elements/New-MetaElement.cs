namespace Belin.Html.Cmdlets.Elements;

/// <summary>
/// Creates a new <c>meta</c> element.
/// </summary>
[Cmdlet(VerbsCommon.New, "MetaElement"), Alias("meta"), OutputType(typeof(string))]
public class NewMetaElementCommand(): NewElementCommand("meta", isVoid: true) {

	/// <summary>
	/// The character encoding in which the document is encoded.
	/// </summary>
	[Parameter]
	public string Charset { get; set; } = "";

	/// <summary>
	/// Populates the specified attribute collection with the attributes of this element.
	/// </summary>
	/// <param name="attributes">The attribute collection to populate.</param>
	protected override void RenderAttributes(Dictionary<string, object?> attributes) {
		base.RenderAttributes(attributes);
		if (!string.IsNullOrWhiteSpace(Charset)) attributes["charset"] = Charset.Trim();
	}
}
