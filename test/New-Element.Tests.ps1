<#
.SYNOPSIS
	Tests the features of the `New-Element` cmdlets.
#>
Describe "New-Element" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../Html.psd1"
	}

	It "should create an HTML element from the specified tag name" -ForEach @(
		@{ Tag = "a"; Expected = "<a></a>" }
		@{ Tag = "html"; Expected = "<html></html>" }
		@{ Tag = "strong"; Expected = "<strong></strong>" }
	) {
		$capitalizedTag = [char]::ToUpperInvariant($tag[0]) + $tag.Substring(1)
		& "New-${capitalizedTag}Element" | Should -BeExactly $expected
		& $tag | Should -BeExactly $expected
	}

	It "should handle void elements" -ForEach @(
		@{ Tag = "br"; Expected = "<br />" }
		@{ Tag = "embed"; Expected = "<embed />" }
		@{ Tag = "input"; Expected = "<input />" }
	) {
		$capitalizedTag = [char]::ToUpperInvariant($tag[0]) + $tag.Substring(1)
		& "New-${capitalizedTag}Element" | Should -BeExactly $expected
		& $tag | Should -BeExactly $expected
	}

	It 'should handle the "id" attribute' {
		$id = "my-id"
		$expected = '<article id="my-id"></article>'
		New-ArticleElement -Id $id | Should -BeExactly $expected
		article -Id $id  | Should -BeExactly $expected
	}

	It 'should handle the "class" attribute' {
		$class = "btn", "btn-danger"
		$expected = '<body class="btn btn-danger"></body>'
		New-BodyElement -Class $class | Should -BeExactly $expected
		body -Class $class | Should -BeExactly $expected
	}

	It 'should handle the "style" attribute' {
		$style = @{ "font-size" = "1rem"; "text-decoration" = "underline" }
		$expected = '<code style="font-size: 1rem; text-decoration: underline"></code>', '<code style="text-decoration: underline; font-size: 1rem"></code>'
		New-CodeElement -Style $style | Should -BeIn $expected
		code -Style $style | Should -BeIn $expected
	}

	It "should handle custom attributes" {
		$attributes = @{ "data-foo" = '"bar"'; disabled = $false; required = $true }
		$expected = '<input data-foo="&quot;bar&quot;" required />', '<input required data-foo="&quot;bar&quot;" />'
		New-InputElement -Attributes $attributes | Should -BeIn $expected
		input -Attributes $attributes | Should -BeIn $expected
	}

	It "should handle the inner content" {
		$content = New-DivElement "Foo > Bar"
		$expected = "<main><div>Foo &gt; Bar</div></main>"
		New-MainElement $content | Should -BeExactly $expected
		main $content | Should -BeExactly $expected
	}
}
