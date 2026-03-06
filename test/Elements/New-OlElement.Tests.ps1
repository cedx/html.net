<#
.SYNOPSIS
	Tests the features of the `New-OlElement` cmdlet.
#>
Describe "New-OlElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "reversed" attribute' {
		ol -reversed | Should -BeExactly "<ol reversed></ol>"
	}

	It 'should support the "type" attribute' -ForEach 1, A, a, I, i {
		ol -type $_ | Should -BeExactly "<ol type=""$_""></ol>"
	}
}
