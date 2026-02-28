using namespace System.Collections.Generic

"Deploying the assets..."
$cmdletTemplate = Get-Content res/Cmdlet.tpl -Raw
$cmdletsToExport = [List[string]]::new()
$cmdletsToExport.Add("New-CustomElement")
$cmdletsToExport.Add("New-Doctype")

(Import-PowerShellDataFile res/Elements.psd1).Elements | ForEach-Object {
	$parameters = @{
		Alias = (Get-Alias $_.Tag -ErrorAction Ignore) ? "$($_.Tag)Tag" : $_.Tag
		CapitalizedTag = [char]::ToUpperInvariant($_.Tag[0]) + $_.Tag.Substring(1)
		IsVoid = $_.IsVoid.ToString().ToLowerInvariant()
		Tag = $_.Tag
	}

	$cmdlet = "New-$($parameters.CapitalizedTag)Element"
	$cmdletsToExport.Add($cmdlet)
	if (Test-Path "src/Elements/$cmdlet.cs") { return }

	$content = $cmdletTemplate
	$parameters.Keys | ForEach-Object { $content = $content -replace "{$_}", $parameters.$_ }
	Set-Content "src/Elements/$cmdlet.g.cs" $content -NoNewline
}

$cmdlets = ($cmdletsToExport | ForEach-Object { "`t`t`"$_`"" }) -join [Environment]::NewLine
$content = (Get-Content Html.psd1 -Raw) -replace "CmdletsToExport = @\([^)]+\)", "CmdletsToExport = @(`n$cmdlets`n`t)"
Set-Content Html.psd1 $content -NoNewline
