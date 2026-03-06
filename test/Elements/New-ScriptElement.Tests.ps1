<#
.SYNOPSIS
	Tests the features of the `New-ScriptElement` cmdlet.
#>
Describe "New-ScriptElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "src" and "type" attributes' -ForEach @(
		@{ Src = "Scripts.js"; Type = "module" }
		@{ Src = "Scripts._hs"; Type = "text/hyperscript" }
	) {
		script -src $src -type $type | Should -BeExactly "<script src=""$src"" type=""$type""></script>"
	}

	It 'should support the "async" and "defer" attributes' -ForEach @(
		@{ Async = $true; Defer = $false }
		@{ Async = $false; Defer = $true }
	) {
		script -src Scripts.js -async:$async -defer:$defer | Should -BeExactly ($async ? '<script src="Scripts.js" async></script>' : '<script src="Scripts.js" defer></script>')
	}

	It "should allow inner content" -ForEach @(
		@{ Content = "alert('Hello World!');"; Type = "" }
		@{ Content = "on click call alert('Hello World!')"; Type = "text/hyperscript" }
	) {
		script $content -type $type | Should -BeExactly ($type ? "<script type=""$type"">$content</script>" : "<script>$content</script>")
	}
}
