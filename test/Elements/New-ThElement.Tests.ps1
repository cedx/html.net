<#
.SYNOPSIS
	Tests the features of the `New-ThElement` cmdlet.
#>
Describe "New-ThElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "colspan" and "rowspan" attributes' {
		th -colspan 1 -rowspan 3 | Should -BeIn '<th colspan="1" rowspan="3"></th>', '<th rowspan="3" colspan="1"></th>'
	}

	It 'should support the "headers" attribute' {
		th -headers tid1, tid2 | Should -BeExactly '<th headers="tid1 tid2"></th>'
	}

	It 'should support the "scope" attribute' -ForEach col, colgroup, row, rowgroup {
		th -scope $_ | Should -BeExactly "<th scope=""$_""></th>"
	}
}
