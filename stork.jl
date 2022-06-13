base = "https://github.com/jameslittle230/stork/releases/download/"
addr = Sys.islinux() ?
	       "$(base)v1.5.0/stork-ubuntu-20-04" :
		   "$(base)v1.5.0/stork-macos-10-15"
success(`curl -L $addr -o stork`)
success(`chmod +x stork`)
run(`./stork --version`)

error("NO NEED TO GO FURTHER")

# stork config
# wd = pwd()
# try
# 	cd("__site")
# 	for (root, dirs, files) in walkdir(".")
# 		if any(x -> startswith(root, x), ["libs", "css", "assets"])
# 			continue
# 		end
# 		f = filter(endswith(".html"), files)
# 		isempty(f) && continue
#
# 		for file in f
# 			s = read(joinpath(root, file), String)
#
# 		end
# finally
# 	cd(wd)
# end

# wd = pwd()
# try
# 	cd("__site/")
# finally
# 	cd(wd)
# end
