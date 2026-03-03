namespace Belin.Html.Cmdlets.Elements;

/// <summary>
/// Creates a new custom element.
/// </summary>
[Cmdlet(VerbsCommon.New, "CustomElement"), Alias("tag"), OutputType(typeof(string))]
public class NewCustomElementCommand(): NewElementCommand("", isVoid: false) {

	/// <summary>
	/// The inner HTML of the element.
	/// </summary>
	[Parameter(Position = 1, ValueFromPipeline = true, ValueFromPipelineByPropertyName = true)]
	public override object? Content { get => base.Content; set => base.Content = value; }

	/// <summary>
	/// The tag name of the element to create.
	/// </summary>
	[Parameter(Mandatory = true, Position = 0, ValueFromPipelineByPropertyName = true)]
	public required string Name { get => TagName; set => TagName = value; }

	/// <summary>
	/// Value indicating whether the element to create is a void element.
	/// </summary>
	[Parameter]
	public SwitchParameter Void { get => IsVoid; set => IsVoid = value; }
}
