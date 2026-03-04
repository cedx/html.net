namespace Belin.Html.Cmdlets.Elements;

/// <summary>
/// Creates a new <c>select</c> element.
/// </summary>
[Cmdlet(VerbsCommon.New, "HtmlSelectElement"), Alias("selectTag"), OutputType(typeof(string))]
public class NewSelectElementCommand(): NewElementCommand("select", isVoid: false) {

	/// <summary>
	/// Value indicating whether the element should have input focus when the page loads.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public SwitchParameter AutoFocus { get; set; }

	/// <summary>
	/// Value indicating whether to prevent the user from interacting with the element.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public SwitchParameter Disabled { get; set; }

	/// <summary>
	/// The identifier of a <c>form</c> element to associate with the element.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string Form { get; set; } = "";

	/// <summary>
	/// The name of the control.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string Name { get; set; } = "";

	/// <summary>
	/// Populates the specified attribute collection with the element attributes.
	/// </summary>
	/// <param name="attributes">The attribute collection to populate.</param>
	protected override void RenderAttributes(IDictionary<string, object?> attributes) {
		base.RenderAttributes(attributes);
		if (AutoFocus) attributes["autofocus"] = true;
		if (Disabled) attributes["disabled"] = true;
		if (!string.IsNullOrWhiteSpace(Form)) attributes["form"] = Form;
		if (!string.IsNullOrWhiteSpace(Name)) attributes["name"] = Name;
	}
}
