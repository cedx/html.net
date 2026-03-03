<#
.SYNOPSIS
	Tests the features of the `New-MapElement` cmdlet.
#>
Describe "New-MapElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "name" attribute' {
		map -name MyMap | Should -BeExactly '<map name="MyMap"></map>'
	}
}
