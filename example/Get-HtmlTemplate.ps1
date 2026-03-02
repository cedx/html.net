<#
.SYNOPSIS
	Renders a HTML document from the given PowerShell script.
#>
Import-Module "$PSScriptRoot/../Html.psd1" # TODO Import-Module Html
$html = & "$PSScriptRoot/../res/Document.ps1"
Write-Output ($html -join [Environment]::NewLine)
