<#
.SYNOPSIS
	Tests the features of the `New-CanvasElement` cmdlet.
#>
Describe "New-CanvasElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "height" and "width" attributes' {
		canvas -height 200 | Should -BeExactly '<canvas height="200"></canvas>'
		canvas -width 460 | Should -BeExactly '<canvas width="460"></canvas>'
	}
}
