header {
	nav -class navbar, navbar-expand-xl {
		div -class container-fluid {
			button -class navbar-toggler -dataset @{ BsTarget = "#menu"; BsToggle = "offcanvas" } {
				span -class navbar-toggler-icon
			}

			div -class navbar-brand, d-flex, align-items-center {
				a -href Index.html { img -alt "" -src Favicon.ico -width 30 -height 30 }
				div -class ms-2 $Title
			}
		}
	}
}
