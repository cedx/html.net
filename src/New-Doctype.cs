namespace Belin.Html.Cmdlets;

/// <summary>
/// Creates a new document type.
/// </summary>
public class NewDoctypeCommand: Cmdlet {

	/// <summary>
	/// The value of the document type.
	/// </summary>
	[Parameter(Position = 0, ValueFromPipeline = true)]
	public string Value { get; set; } = "html";

	/// <summary>
	/// Performs execution of this command.
	/// </summary>
	protected override void ProcessRecord() {
		WriteObject($"<!doctype {Value}>");
	}
}
