namespace Belin.Html.Cmdlets.Elements;

/// <summary>
/// Creates a new <c>li</c> element.
/// </summary>
[Cmdlet(VerbsCommon.New, "HtmlLiElement"), Alias("li"), OutputType(typeof(string))]
public class NewLiElementCommand(): NewElementCommand("li", isVoid: false) {

	/// <summary>
	/// Value indicating the current ordinal value of the list item as defined by the <c>ol</c> element.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true), ValidateRange(ValidateRangeKind.NonNegative)]
	public int Value { get; set; } = -1;

	/// <summary>
	/// Populates the specified attribute collection with the element attributes.
	/// </summary>
	/// <param name="attributes">The attribute collection to populate.</param>
	protected override void RenderAttributes(Dictionary<string, object?> attributes) {
		base.RenderAttributes(attributes);
		if (Value >= 0) attributes["value"] = Value;
	}
}
