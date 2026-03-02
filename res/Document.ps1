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
		& "$PSScriptRoot/BodyHeader.ps1"

		main {
			noscript {
				"This application requires "; b JavaScript; " to be enabled in your browser."
			}

			article -class container-xl {
				h1 "My Title"
				div -class alert, alert-success "Welcome to my website!"
			}
		}

		& "$PSScriptRoot/BodyFooter.ps1"
	}
}
