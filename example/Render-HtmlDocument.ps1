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

			link -rel stylesheet -href "https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.css" -integrity "sha256-2FMn2Zx6PuH5tdBQDRNwrOo60ts5wWPC9R8jK67b3t4"
			link -rel stylesheet -href Assets/Styles.css

			script -src "https://cdn.jsdelivr.net/npm/bootstrap@5/dist/js/bootstrap.js" -integrity "sha256-ew8UiV1pJH/YjpOEBInP1HxVvT/SfrCmwSoUzF9JIgc="
			script -src Assets/Scripts.js -type module
		}

		body {
			header {
				nav -class navbar, navbar-expand-xl {
					div -class container-fluid {
						button -class navbar-toggler -data @{ bsTarget = "#menu"; bsToggle = "offcanvas" } {
							span -class navbar-toggler-icon
						}

						div -class navbar-brand, d-flex, align-items-center {
							a -href Index.html { img -alt "" -src Favicon.ico -width 30 -height 30 }
							div -class ms-2 "My Application"
						}
					}
				}
			}

			main {
				noscript {
					"This application requires "; b JavaScript; " to be enabled in your browser."
				}

				article -class container-xl {
					h1 "My Title"
					div -class alert, alert-success "Welcome to my website!"
				}
			}

			footer "Copyright &copy; $([datetime]::Now.Year) - All rights reserved."
		}
	}
}

$html = $template.Invoke() -join [Environment]::NewLine
Write-Output $html
