<#
.SYNOPSIS
	Tests the features of the `New-SourceElement` cmdlet.
#>
Describe "New-SourceElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "src" and "type" attributes' {
		source -src Video.webm -type video/webm | Should -BeIn '<source src="Video.webm" type="video/webm" />', '<source type="video/webm" src="Video.webm" />'
	}

	It 'should support the "srcset" and "media" attributes' {
		source -srcset Image.webp -media "(width > 600px)" | Should -BeIn '<source media="(width > 600px)" srcset="Image.webp" />', '<source srcset="Image.webp" media="(width > 600px)" />'
	}
}
