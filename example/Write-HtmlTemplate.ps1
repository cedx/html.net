<#
.SYNOPSIS
	Renders a HTML document from the given template.
#>
Import-Module "$PSScriptRoot/../Html.psd1" # TODO Import-Module Html

$html = & "$PSScriptRoot/../res/Document.ps1"
Write-Host $html
