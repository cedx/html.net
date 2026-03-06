<#
.SYNOPSIS
	Tests the features of the `New-ColGroupElement` cmdlet.
#>
Describe "New-ColGroupElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "span" attribute' -ForEach 1, 25 {
		colgroup -span $_ | Should -BeExactly "<colgroup span=""$_""></colgroup>"
	}
}
