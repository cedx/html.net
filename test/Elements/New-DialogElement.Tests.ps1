<#
.SYNOPSIS
	Tests the features of the `New-DialogElement` cmdlet.
#>
Describe "New-DialogElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "closedby" attribute' -ForEach any, closerequest, none {
		dialog -closedby $_ | Should -BeExactly "<dialog closedby=""$_""></dialog>"
	}

	It 'should support the "open" attribute' {
		dialog -open | Should -BeExactly '<dialog open></dialog>'
	}
}
