<#
.SYNOPSIS
	Tests the features of the `New-VideoElement` cmdlet.
#>
Describe "New-VideoElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "autoplay", "controls", "loop" and "muted" attributes' {
		video -autoplay | Should -BeExactly "<video autoplay></video>"
		video -controls | Should -BeExactly "<video controls></video>"
		video -loop | Should -BeExactly "<video loop></video>"
		video -muted | Should -BeExactly "<video muted></video>"
	}

	It 'should support the "poster" attribute' {
		video -poster Picture.webp | Should -BeExactly '<video poster="Picture.webp"></video>'
	}

	It 'should support the "preload" attribute' -ForEach auto, none, metadata {
		video -preload $_ | Should -BeExactly "<video preload=""$_""></video>"
	}

	It 'should support the "height" and "width" attributes' {
		video -width 460 -height 200 | Should -BeIn '<video width="460" height="200"></video>', '<video height="200" width="460"></video>'
	}
}
