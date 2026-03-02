<#
.SYNOPSIS
	Renders a HTML document from the given PowerShell template file.
#>
Import-Module "$PSScriptRoot/../Html.psd1" # TODO Import-Module Html
$html = Write-HtmlTemplate "$PSScriptRoot/../res/Document.ps1"
Write-Output $html
