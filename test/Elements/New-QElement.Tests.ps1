<#
.SYNOPSIS
	Tests the features of the `New-QElement` cmdlet.
#>
Describe "New-QElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "cite" attribute' {
		q "Lorem Ipsum" -cite "https://example.com/" | Should -BeExactly '<q cite="https://example.com/">Lorem Ipsum</q>'
	}
}
