<#
.SYNOPSIS
	Tests the features of the `New-SelectElement` cmdlet.
#>
Describe "New-SelectElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "autocomplete" attribute' -ForEach "off", "on", @("shipping", "street-address") {
		selectTag -autocomplete $_ | Should -BeExactly "<select autocomplete=""$($_ -join " ")""></select>"
	}

	It 'should support the "disabled" attribute' {
		selectTag -disabled | Should -BeExactly '<select disabled></select>'
	}

	It 'should support the "multiple" attribute' {
		selectTag -multiple | Should -BeExactly '<select multiple></select>'
	}

	It 'should support the "required" attribute' {
		selectTag -required | Should -BeExactly '<select required></select>'
	}

	It 'should support the "size" attribute' -ForEach 0, 2, 5 {
		selectTag -size $_ | Should -BeExactly "<select size=""$_""></select>"
	}
}
