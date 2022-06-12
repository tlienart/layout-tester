base = "https://github.com/jameslittle230/stork/releases/download/"
addr = Sys.islinux() ?
	       "$(base)v1.5.0/stork-ubuntu-20-04" :
		   "$(base)v1.5.0/stork-macos-10-15"
success(`curl -L $addr -o stork`)
success(`chmod +x stork`)
run(`./stork --version`)
