using module ./String.psm1

"Building the solution..."
$cmdletTemplate = Get-Content res/CmdletTemplate.cs -Raw
$htmlElements = (Import-PowerShellDataFile res/HtmlElements.psd1).HtmlElements

$invariantCulture = Get-Culture ""
$htmlElements | ForEach-Object {
	$replacements = @{
		CapitalizedTag = Capitalize-String $_.Tag -Culture $invariantCulture
		IsVoid = $_.IsVoid.ToString().ToLowerInvariant()
		Tag = $_.Tag
	}

	$content = $cmdletTemplate
	$replacements.Keys | ForEach-Object {
		$content = $content -replace "{$_}", $replacements.$_
	}

	Set-Content "src/Elements/New-$($replacements.CapitalizedTag)Element.g.cs" $content
}

# TODO dotnet build --configuration ($Release ? "Release" : "Debug")
