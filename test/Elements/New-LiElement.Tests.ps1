<#
.SYNOPSIS
	Tests the features of the `New-LiElement` cmdlet.
#>
Describe "New-LiElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "value" attribute' {
		li -value 123 | Should -BeExactly '<li value="123"></li>'
	}
}
