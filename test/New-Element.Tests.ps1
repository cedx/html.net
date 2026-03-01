<#
.SYNOPSIS
	Tests the features of the `New-Element` cmdlets.
#>
Describe "New-Element" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../Html.psd1"
	}

	It "should create an HTML element from the specified tag name" -ForEach @(
		@{ Tag = "b"; Expected = "<b></b>" }
		@{ Tag = "html"; Expected = "<html></html>" }
		@{ Tag = "strong"; Expected = "<strong></strong>" }
	) {
		& $tag | Should -BeExactly $expected
	}

	It "should handle void elements" -ForEach @(
		@{ Tag = "br"; Expected = "<br />" }
		@{ Tag = "embed"; Expected = "<embed />" }
		@{ Tag = "input"; Expected = "<input />" }
	) {
		& $tag | Should -BeExactly $expected
	}

	It 'should handle the "class" attribute' {
		body -class btn, btn-danger | Should -BeExactly '<body class="btn btn-danger"></body>'
	}

	It 'should handle the "id" attribute' {
		article -id foo | Should -BeExactly '<article id="foo"></article>'
	}

	It 'should handle the "style" attribute' {
		$expected = '<code style="font-family: &quot;Segoe UI&quot;; font-size: 1rem"></code>', '<code style="font-size: 1rem; font-family: &quot;Segoe UI&quot;"></code>'
		code -style @{ "font-family" = '"Segoe UI"'; "font-size" = "1rem" } | Should -BeIn $expected
	}

	It 'should handle the "title" attribute' -ForEach "", 'A "custom" label.' {
		div -title $_ | Should -BeExactly ($_ ? '<div title="A &quot;custom&quot; label."></div>' : "<div></div>")
	}

	It "should handle custom attributes" {
		$expected = '<input data-foo="&quot;bar&quot;" required />', '<input required data-foo="&quot;bar&quot;" />'
		input -attributes @{ "data-foo" = '"bar"'; disabled = $false; required = $true } | Should -BeIn $expected
	}

	It "should handle data attributes" {
		$expected = '<button data-bs-toggle="tooltip" data-push-url></button>', '<button data-push-url data-bs-toggle="tooltip"></button>'
		button -data @{ bsToggle = "tooltip"; pushUrl = $true } | Should -BeIn $expected
	}

	It "should handle the inner content" {
		$expected = "<main><div>Foo &gt; Bar <span>Baz &lt; Qux</span></div></main>"
		main { div { "Foo &gt; Bar"; " "; span "Baz &lt; Qux" } } | Should -BeExactly $expected
	}
}
