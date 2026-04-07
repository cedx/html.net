<#
.SYNOPSIS
	Tests the features of the `New-MetaElement` cmdlet.
#>
Describe "New-MetaElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "charset" attribute' -ForEach "iso-8859-1", "utf-8" {
		meta -charset $_ | Should -BeExactly "<meta charset=""$_"">"
	}

	It 'should support the "http-equiv" and "content" attributes' -ForEach @(
		@{ HttpEquiv = "content-type"; Content = "text/html; charset=utf-8" }
		@{ HttpEquiv = "refresh"; Content = 300 }
	) {
		meta -httpEquiv $httpEquiv -content $content | Should -BeExactly "<meta http-equiv=""$httpEquiv"" content=""$content"">"
	}

	It 'should support the "name" and "content" attributes' -ForEach @(
		@{ Name = "application-name"; Content = "Belin.Html" }
		@{ Name = "color-scheme"; Content = "light dark" }
	) {
		meta -name $name -content $content | Should -BeExactly "<meta name=""$name"" content=""$content"">"
	}
}
