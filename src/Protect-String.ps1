using namespace System.Text.Encodings.Web

<#
.SYNOPSIS
	Encodes a string using the specified character encoding.
.INPUTS
	The string to encode.
.OUTPUTS
	The encoded string.
#>
function Protect-HtmlString {
	[Alias("esc")]
	[CmdletBinding(DefaultParameterSetName = "Html")]
	[OutputType([string])]
	param (
		# The string to escape.
		[Parameter(Mandatory, Position = 0, ValueFromPipeline)]
		[AllowEmptyString()]
		[AllowNull()]
		[string] $Value,

		# Value indicating whether to use the HTML character encoding.
		[Parameter(ParameterSetName = "Html")]
		[switch] $Html,

		# Value indicating whether to use the URL character encoding.
		[Parameter(ParameterSetName = "Url")]
		[switch] $Url
	)

	begin {
		$encoder = $Url ? [UrlEncoder]::Default : [HtmlEncoder]::Default
	}

	process {
		$encoder.Encode($Value ?? "")
	}
}
