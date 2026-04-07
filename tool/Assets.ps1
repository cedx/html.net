using namespace System.Collections.Generic

"Deploying the assets..."
$cmdletTemplate = Get-Content share/Cmdlet.Template.cs -Raw
$cmdletsToExport = [List[string]]::new([string[]] @(
	"New-HtmlCustomElement"
	"New-HtmlDocumentType"
))

New-Item src/Generated -Force -ItemType Directory | Out-Null
foreach ($element in (Import-PowerShellDataFile share/HtmlElements.psd1).Elements) {
	$parameters = @{
		Alias = (Get-Alias $element.Tag -ErrorAction Ignore) ? "$($element.Tag)Tag" : $element.Tag
		CapitalizedTag = [char]::ToUpperInvariant($element.Tag[0]) + $element.Tag.Substring(1)
		IsVoid = $element.IsVoid.ToString().ToLowerInvariant()
		Tag = $element.Tag
	}

	$cmdletsToExport.Add("New-Html$($parameters.CapitalizedTag)Element")
	$fileName = "New-$($parameters.CapitalizedTag)Element"
	if (Test-Path "src/Elements/$fileName.cs") { continue }

	$content = $cmdletTemplate
	foreach ($key in $parameters.Keys) { $content = $content -replace "{$key}", $parameters.$key }
	Set-Content "src/Generated/$fileName.g.cs" $content -NoNewline
}

$cmdletsToExport.Sort()
$cmdlets = $cmdletsToExport.PSForEach{ "`t`t""$_""" } -join [Environment]::NewLine
$content = (Get-Content Html.psd1 -Raw) -replace "CmdletsToExport = @\([^)]+\)", "CmdletsToExport = @(`n$cmdlets`n`t)"
Set-Content Html.psd1 $content -NoNewline
