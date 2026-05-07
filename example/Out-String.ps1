<#
.SYNOPSIS
	Renders an HTML document from the given PowerShell script.
#>
using module Belin.Html

$title = "My Application"
$content = & "$PSScriptRoot/../res/Content.ps1" @{ Heading = $title } | Out-String
& "$PSScriptRoot/../res/Layout.ps1" $content @{ Title = $title } | Out-String
