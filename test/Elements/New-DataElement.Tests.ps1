<#
.SYNOPSIS
	Tests the features of the `New-DataElement` cmdlet.
#>
Describe "New-DataElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "value" attribute' -ForEach 123, "MY_KEY" {
		dataTag -value $_ | Should -BeExactly "<data value=""$_""></data>"
	}
}
