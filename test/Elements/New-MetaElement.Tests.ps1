<#
.SYNOPSIS
	Tests the features of the `New-MetaElement` cmdlet.
#>
Describe "New-MetaElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "charset" attribute' -ForEach "iso-8859-1", "utf-8" {
		meta -charset $_ | Should -BeExactly "<meta charset=`"$_`" />"
	}
}
