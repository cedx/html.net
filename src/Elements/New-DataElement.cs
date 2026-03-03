namespace Belin.Html.Cmdlets.Elements;

/// <summary>
/// Creates a new <c>data</c> element.
/// </summary>
[Cmdlet(VerbsCommon.New, "DataElement"), Alias("dataTag"), OutputType(typeof(string))]
public class NewDataElementCommand(): NewElementCommand("data", isVoid: false) {

	/// <summary>
	/// The machine-readable translation of the content of the element.
	/// </summary>
	[Parameter(Mandatory = true, ValueFromPipelineByPropertyName = true)]
	public required string Value { get; set; }

	/// <summary>
	/// Populates the specified attribute collection with the element attributes.
	/// </summary>
	/// <param name="attributes">The attribute collection to populate.</param>
	protected override void RenderAttributes(Dictionary<string, object?> attributes) {
		base.RenderAttributes(attributes);
		attributes["value"] = Value;
	}
}
