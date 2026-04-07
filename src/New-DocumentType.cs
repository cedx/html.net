namespace Belin.Html;

/// <summary>
/// Creates a new document type declaration.
/// </summary>
[Cmdlet(VerbsCommon.New, "HtmlDocumentType"), Alias("doctype"), OutputType(typeof(string))]
public class NewDocumentTypeCommand: Cmdlet {

	/// <summary>
	/// The value of the document type.
	/// </summary>
	[Parameter(Position = 0, ValueFromPipeline = true)]
	public string Value { get; set; } = "html";

	/// <summary>
	/// Performs execution of this command.
	/// </summary>
	protected override void ProcessRecord() => WriteObject($"<!doctype {(string.IsNullOrWhiteSpace(Value) ? "html" : Value)}>");
}
