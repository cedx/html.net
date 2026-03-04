using namespace System.Collections.Generic

"Deploying the assets..."
$cmdletTemplate = Get-Content share/Cmdlet.Template.cs -Raw
$cmdletsToExport = [List[string]]::new([string[]] @(
	"New-HtmlCustomElement"
	"New-HtmlDocumentType"
))

New-Item src/Generated -Force -ItemType Directory | Out-Null
(Import-PowerShellDataFile share/HtmlElements.psd1).Elements | ForEach-Object {
	$parameters = @{
		Alias = (Get-Alias $_.Tag -ErrorAction Ignore) ? "$($_.Tag)Tag" : $_.Tag
		CapitalizedTag = [char]::ToUpperInvariant($_.Tag[0]) + $_.Tag.Substring(1)
		IsVoid = $_.IsVoid.ToString().ToLowerInvariant()
		Tag = $_.Tag
	}

	$cmdletsToExport.Add("New-Html$($parameters.CapitalizedTag)Element")
	$fileName = "New-$($parameters.CapitalizedTag)Element"
	if (Test-Path "src/Elements/$fileName.cs") { return }

	$content = $cmdletTemplate
	$parameters.Keys | ForEach-Object { $content = $content -replace "{$_}", $parameters.$_ }
	Set-Content "src/Generated/$fileName.g.cs" $content -NoNewline
}

$cmdlets = ($cmdletsToExport | ForEach-Object { "`t`t`"$_`"" }) -join [Environment]::NewLine
$content = (Get-Content Html.psd1 -Raw) -replace "CmdletsToExport = @\([^)]+\)", "CmdletsToExport = @(`n$cmdlets`n`t)"
Set-Content Html.psd1 $content -NoNewline
