namespace Belin.Html.Cmdlets.Elements;

/// <summary>
/// Creates a new <c>{Tag}</c> element.
/// </summary>
[Cmdlet(VerbsCommon.New, "{CapitalizedTag}Element"), Alias("{Tag}"), OutputType(typeof(string))]
public class New{CapitalizedTag}ElementCommand(): NewElementCommand("{Tag}", isVoid: {IsVoid}) {}
