<#
.SYNOPSIS
	Tests the features of the `New-Doctype` cmdlet.
#>
Describe "New-Doctype" {
	BeforeAll {
		Import-Module "$PSScriptRoot/../Html.psd1"
	}

	It "should return a document type declaration" -ForEach @(
		@{ Value = ""; Expected = "<!doctype html>" }
		@{ Value = 'html public "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"'; Expected = '<!doctype html public "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">' }
		@{ Value = 'html public "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"'; Expected = '<!doctype html public "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">'}
	) {
		New-Doctype $value | Should -BeExactly $expected
		doctype $value | Should -BeExactly $expected
	}
}
