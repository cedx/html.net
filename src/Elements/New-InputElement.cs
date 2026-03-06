namespace Belin.Html.Cmdlets.Elements;

/// <summary>
/// Creates a new <c>input</c> element.
/// </summary>
[Cmdlet(VerbsCommon.New, "HtmlInputElement"), Alias("input"), OutputType(typeof(string))]
public class NewInputElementCommand(): NewElementCommand("input", isVoid: true) {

	/// <summary>
	/// Defines which file types are selectable in a file upload control.
	/// Valid for the <c>file</c> input type only.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string Accept { get; set; } = "";

	/// <summary>
	/// A text to display on browsers that do not display images.
	/// Valid for the <c>image</c> input type only.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string? Alt { get; set; }

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
	/// The type of control to render.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true), ValidateSet(
		"button", "checkbox", "color", "date", "datetime-local",
		"email", "file", "hidden", "image", "month",
		"number", "password", "radio", "range", "reset",
		"search", "submit", "tel", "text", "time",
		"url", "week"
	)]
	public string? Type { get; set; }

	/// <summary>
	/// The value of the control.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public object? Value { get; set; }

	/// <summary>
	/// Populates the specified attribute collection with the element attributes.
	/// </summary>
	/// <param name="attributes">The attribute collection to populate.</param>
	protected override void RenderAttributes(IDictionary<string, object?> attributes) {
		base.RenderAttributes(attributes);
		if (!string.IsNullOrWhiteSpace(Accept)) attributes["accept"] = Accept;
		if (Alt is not null) attributes["alt"] = Alt;
		if (Disabled) attributes["disabled"] = true;
		if (!string.IsNullOrWhiteSpace(Form)) attributes["form"] = Form;
		if (!string.IsNullOrWhiteSpace(Name)) attributes["name"] = Name;
		if (Type is not null) attributes["type"] = Type;
		if (Value is not null) attributes["value"] = Value;
	}
}
