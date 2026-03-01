<#
.SYNOPSIS
	Tests the features of the `New-CustomElement` cmdlet.
#>
Describe "New-CustomElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../Html.psd1"
	}

	It "should create a custom HTML element from the specified tag name" {
		tag my-element | Should -BeExactly "<my-element></my-element>"
	}

	It "should handle void elements" {
		tag my-element -Void | Should -BeExactly "<my-element />"
	}

	It 'should handle the "id" attribute' {
		tag my-element -Id foo | Should -BeExactly '<my-element id="foo"></my-element>'
	}

	It 'should handle the "class" attribute' {
		tag my-element -Class btn, btn-danger | Should -BeExactly '<my-element class="btn btn-danger"></my-element>'
	}

	It 'should handle the "style" attribute' {
		$expected = '<my-element style="font-family: &quot;Segoe UI&quot;; font-size: 1rem"></my-element>', '<my-element style="font-size: 1rem; font-family: &quot;Segoe UI&quot;"></my-element>'
		tag my-element -Style @{ "font-family" = '"Segoe UI"'; "font-size" = "1rem" } | Should -BeIn $expected
	}

	It "should handle custom attributes" {
		$expected = '<my-element data-foo="&quot;bar&quot;" required />', '<my-element required data-foo="&quot;bar&quot;" />'
		tag my-element -Attributes @{ "data-foo" = '"bar"'; disabled = $false; required = $true } -Void | Should -BeIn $expected
	}

	It "should handle data attributes" {
		$expected = '<my-element data-bs-toggle="tooltip" data-push-url></my-element>', '<my-element data-push-url data-bs-toggle="tooltip"></my-element>'
		tag my-element -Data @{ bsToggle = "tooltip"; pushUrl = $true } | Should -BeIn $expected
	}

	It "should handle the inner content" {
		$expected = "<outer-element><inner-element>Foo &gt; Bar <span>Baz &lt; Qux</span></inner-element></outer-element>"
		tag outer-element { tag inner-element { "Foo &gt; Bar"; " "; span "Baz &lt; Qux" } } | Should -BeExactly $expected
	}
}
