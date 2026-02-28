using namespace System.Collections.Generic

"Deploying the assets..."
$cmdletTemplate = Get-Content res/CmdletTemplate.cs -Raw
$cmdletsToExport = [List[string]]::new()
$cmdletsToExport.Add("New-CustomElement")
$cmdletsToExport.Add("New-Doctype")

(Import-PowerShellDataFile res/HtmlElements.psd1).HtmlElements | ForEach-Object {
	$replacements = @{
		Alias = $_.IsConflict ? "$($_.Tag)Tag" : $_.Tag
		CapitalizedTag = [char]::ToUpperInvariant($_.Tag[0]) + $_.Tag.Substring(1)
		IsVoid = $_.IsVoid.ToString().ToLowerInvariant()
		Tag = $_.Tag
	}

	$cmdlet = "New-$($replacements.CapitalizedTag)Element"
	$cmdletsToExport.Add($cmdlet)

	$content = $cmdletTemplate
	$replacements.Keys | ForEach-Object { $content = $content -replace "{$_}", $replacements.$_ }
	Set-Content "src/Elements/$cmdlet.g.cs" $content -NoNewline
}

$cmdlets = ($cmdletsToExport | ForEach-Object { "`t`t`"$_`"" }) -join [Environment]::NewLine
$content = (Get-Content Html.psd1 -Raw) -replace "CmdletsToExport = @\([^)]+\)", "CmdletsToExport = @(`n$cmdlets`n`t)"
Set-Content Html.psd1 $content -NoNewline
