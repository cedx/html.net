using namespace System.Collections.Generic

"Building the solution..."
$cmdletTemplate = Get-Content res/CmdletTemplate.cs -Raw
$cmdletsToExport = [List[string]]::new()
$invariantCulture = Get-Culture ""

(Import-PowerShellDataFile res/HtmlElements.psd1).HtmlElements | ForEach-Object {
	$replacements = @{
		CapitalizedTag = [char]::ToUpper($_.Tag[0], $invariantCulture) + $_.Tag.Substring(1)
		IsVoid = $_.IsVoid.ToString().ToLowerInvariant()
		Tag = $_.Tag
	}

	$cmdlet = "New-$($replacements.CapitalizedTag)Element"
	$cmdletsToExport.Add($cmdlet)

	$content = $cmdletTemplate
	$replacements.Keys | ForEach-Object { $content = $content -replace "{$_}", $replacements.$_ }
	Set-Content "src/Elements/$cmdlet.g.cs" $content -NoNewline
}

$cmdletsToExport.Add("New-Doctype");
$cmdlets = ($cmdletsToExport | ForEach-Object { "`t`t`"$_`"" }) -join [Environment]::NewLine
$content = Get-Content Html.psd1 -Raw
Set-Content Html.psd1 ($content -replace "CmdletsToExport = @\([^)]+\)", "CmdletsToExport = @(`n$cmdlets`n`t)") -NoNewline

dotnet build --configuration ($Release ? "Release" : "Debug")
