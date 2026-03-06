<#
.SYNOPSIS
	Tests the features of the `New-ImgElement` cmdlet.
#>
Describe "New-ImgElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "alt" and "src" attributes' -ForEach @(
		@{ Src = "Image.webp"; Alt = $null }
		@{ Src = "Assets/Icon.gif"; Alt = "" }
		@{ Src = "Assets/Picture.jpg"; Alt = "A label describing the image." }
	) {
		$img = img -src $src -alt $alt
		if ($null -eq $alt) { $img | Should -BeExactly "<img src=""$src"" />" }
		else { $img | Should -BeIn "<img alt=""$alt"" src=""$src"" />", "<img src=""$src"" alt=""$alt"" />" }
	}

	It 'should support the "ismap" and "usemap" attributes' {
		img -src Image.webp -ismap | Should -BeIn '<img ismap src="Image.webp" />', '<img src="Image.webp" ismap />'
		img -src Image.webp -usemap my-map | Should -BeIn '<img usemap="#my-map" src="Image.webp" />', '<img src="Image.webp" usemap="#my-map" />'
	}

	It 'should support the "height" and "width" attributes' {
		img -src Image.webp -height 200 | Should -BeIn '<img height="200" src="Image.webp" />', '<img src="Image.webp" height="200" />'
		img -src Image.webp -width 460 | Should -BeIn '<img width="460" src="Image.webp" />', '<img src="Image.webp" width="460" />'
	}
}
