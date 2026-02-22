<#
.SYNOPSIS
	Converts the first character of the specified string to uppercase.
.OUTPUTS
	The processed string.
#>
function Capitalize-String {
	param (
		# The string to capitalize.
		[Parameter(Mandatory, Position = 0, ValueFromPipeline)]
		[string] $Value,

		# An object that supplies culture-specific formatting information. TODO
		[Parameter(Position = 1)]
		[cultureinfo] $Culture = $PSCulture
	)

	($Value ? [char]::ToUpper($Value[0], $Culture) + $Value.Substring(1) : "")
}
