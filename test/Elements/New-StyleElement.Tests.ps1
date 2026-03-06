<#
.SYNOPSIS
	Tests the features of the `New-StyleElement` cmdlet.
#>
Describe "New-StyleElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "media" attribute' -ForEach "all", "(width <= 500px)" {
		style -media $_ | Should -BeExactly "<style media=""$_""></style>"
	}

	It "should allow inner content" {
		$content = "p { color: blue; background-color: yellow; }"
		style $content | Should -BeExactly "<style>$content</style>"
	}
}
