namespace Belin.Html.Cmdlets.Elements;

/// <summary>
/// Creates a new <c>{Tag}</c> element.
/// </summary>
[Cmdlet(VerbsCommon.New, "{CapitalizedTag}Element"), Alias("{Alias}"), OutputType(typeof(string))]
public class New{CapitalizedTag}ElementCommand(): WriteHtmlElementCommand("{Tag}", isVoid: {IsVoid}) {}
