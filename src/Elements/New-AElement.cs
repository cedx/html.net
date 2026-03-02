namespace Belin.Html.Cmdlets.Elements;

/// <summary>
/// Creates a new <c>a</c> element.
/// </summary>
[Cmdlet(VerbsCommon.New, "AElement"), Alias("a"), OutputType(typeof(string))]
public class NewAElementCommand(): NewElementCommandBase("a", isVoid: false) {

	/// <summary>
	/// The suggested filename when the browser treats the linked URL as a download.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string Download { get; set; } = "";

	/// <summary>
	/// The URL that the hyperlink points to.
	/// </summary>
	[Parameter(Mandatory = true, ValueFromPipelineByPropertyName = true)]
	public required Uri Href { get; set; }

	/// <summary>
	/// A list of URLs. When the link is followed, the browser will send <c>POST</c> requests with the body <c>PING</c> to the URLs.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public Uri[] Ping { get; set; } = [];

	/// <summary>
	/// The relationship of the linked URL.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string[] Rel { get; set; } = [];

	/// <summary>
	/// The browsing context to show the results of navigation.
	/// </summary>
	[Parameter(ValueFromPipelineByPropertyName = true)]
	public string Target { get; set; } = "";

	/// <summary>
	/// Populates the specified attribute collection with the attributes of this element.
	/// </summary>
	/// <param name="attributes">The attribute collection to populate.</param>
	protected override void RenderAttributes(Dictionary<string, object?> attributes) {
		base.RenderAttributes(attributes);
		attributes["href"] = Href.ToString();
		if (!string.IsNullOrWhiteSpace(Download)) attributes["download"] = Download;
		if (Ping.Length > 0) attributes["ping"] = string.Join(' ', Ping.Select(url => url.ToString()));
		if (Rel.Length > 0) attributes["rel"] = string.Join(' ', Rel);
		if (!string.IsNullOrWhiteSpace(Target)) attributes["target"] = Target;
	}
}
