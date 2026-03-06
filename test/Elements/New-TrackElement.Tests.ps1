<#
.SYNOPSIS
	Tests the features of the `New-TrackElement` cmdlet.
#>
Describe "New-TrackElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "default" attribute' {
		track -src Subtitles.vtt -default | Should -BeIn '<track src="Subtitles.vtt" default />', '<track default src="Subtitles.vtt" />'
	}

	It 'should support the "kind" attribute' -ForEach captions, chapters, descriptions, metadata, subtitles {
		track -src Subtitles.vtt -kind $_ | Should -BeIn "<track src=""Subtitles.vtt"" kind=""$_"" />", "<track kind=""$_"" src=""Subtitles.vtt"" />"
	}
}
