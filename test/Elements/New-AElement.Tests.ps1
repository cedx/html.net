<#
.SYNOPSIS
	Tests the features of the `New-AElement` cmdlet.
#>
Describe "New-AElement" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../../Html.psd1"
	}

	It 'should support the "download" attribute' {
		$expected = '<a href="Index.html" download="Evil.js">Click me</a>', '<a download="Evil.js" href="Index.html">Click me</a>'
		a "Click me" -href Index.html -download Evil.js | Should -BeIn $expected
	}

	It 'should support the "href" attribute' -ForEach "./Index.html", "mailto:dummy@example.com", "tel:+33123456789" {
		a "Click me" -href $_ | Should -BeExactly "<a href=""$_"">Click me</a>"
	}

	It 'should support the "ping" attribute' {
		$expected = '<a href="Index.html" ping="https://example.com/ Tracking.php"></a>', '<a ping="https://example.com/ Tracking.php" href="Index.html">Click me</a>'
		a -href Index.html -ping "https://example.com/", Tracking.php | Should -BeIn $expected
	}

	It 'should support the "rel" attribute' {
		$expected = '<a href="Index.html" rel="external nofollow"></a>', '<a rel="external nofollow" href="Index.html">Click me</a>'
		a -href Index.html -rel external, nofollow | Should -BeIn $expected
	}

	It 'should support the "target" attribute' -ForEach "_blank", "my-iframe" {
		a "Click me" -href Index.html -target $_ | Should -BeExactly "<a href=""Index.html"" target=""$_"">Click me</a>"
	}
}
