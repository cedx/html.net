<#
.SYNOPSIS
	Renders a HTML document from the given template.
#>
Import-Module "$PSScriptRoot/../Html.psd1" # TODO Import-Module Html

$template = {
	doctype
	html -dir ltr -lang $PSCulture {
		head {
			meta -charset utf-8
			base -href /Base/

			title "My Title"

			meta -name color-scheme -content light
			meta -name viewport -content "initial-scale=1, width=device-width"

			link -rel icon -href Favicon.ico
			link -rel preload -href Assets/Font.woff2 -as font -crossorigin anonymous -type font/woff2
			link -rel stylesheet -href Assets/Styles.css
		}

		body {
			header {
				"TODO"
			}

			main {
				"TODO"
			}

			footer {
				"TODO"
			}
		}
	}
}

$html = $template.Invoke() -join [Environment]::NewLine
Write-Output $html
