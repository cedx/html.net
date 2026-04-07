namespace Belin.Html.Elements;

using System.Globalization;

/// <summary>
/// Creates a new <c>embed</c> element.
/// </summary>
[Cmdlet(VerbsCommon.New, "HtmlEmbedElement"), Alias("embed"), OutputType(typeof(string))]
public class NewEmbedElementCommand(): NewElementCommand("embed", isVoid: true) {

	/// <summary>
	/// The displayed height of the resource, in CSS pixels.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true), ValidateRange(ValidateRangeKind.NonNegative)]
	public int Height { get; set; } = -1;

	/// <summary>
	/// The URL of the resource being embedded.
	/// </summary>
	[Parameter(Mandatory = true, ValueFromPipelineByPropertyName = true)]
	public required Uri Src { get; set; }

	/// <summary>
	/// The media type to use, optionally including a <c>codecs</c> parameter.
	/// </summary>
	[Parameter(Mandatory = true, ValueFromPipelineByPropertyName = true)]
	public required string Type { get; set; }

	/// <summary>
	/// The displayed height of the resource, in CSS pixels.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true), ValidateRange(ValidateRangeKind.NonNegative)]
	public int Width { get; set; } = -1;

	/// <summary>
	/// Populates the specified attribute collection with the element attributes.
	/// </summary>
	/// <param name="attributes">The attribute collection to populate.</param>
	protected override void RenderAttributes(IDictionary<string, object?> attributes) {
		base.RenderAttributes(attributes);
		attributes["src"] = Src.ToString();
		attributes["type"] = Type;
		if (Height >= 0) attributes["height"] = Height.ToString(CultureInfo.InvariantCulture);
		if (Width >= 0) attributes["width"] = Width.ToString(CultureInfo.InvariantCulture);
	}
}
