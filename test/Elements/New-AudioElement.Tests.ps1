<#
.SYNOPSIS
	Tests the features of the `New-AudioElement` cmdlet.
#>
Describe "New-AudioElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "autoplay", "controls", "loop" and "muted" attributes' {
		audio -autoplay | Should -BeExactly "<audio autoplay></audio>"
		audio -controls | Should -BeExactly "<audio controls></audio>"
		audio -loop | Should -BeExactly "<audio loop></audio>"
		audio -muted | Should -BeExactly "<audio muted></audio>"
	}

	It 'should support the "preload" attribute' -ForEach auto, none, metadata {
		audio -preload $_ | Should -BeExactly "<audio preload=""$_""></audio>"
	}
}
