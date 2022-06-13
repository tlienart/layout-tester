# this script is expected to be located and run from website_folder/thescript.jl

import Xranklin

# XXX this script should also work locally, so there should be a test
# to see if the command already succeeds and not re-install.

base = "https://github.com/jameslittle230/stork/releases/download/"
addr = Sys.islinux() ?
	       "$(base)v1.5.0/stork-ubuntu-20-04" :
		   "$(base)v1.5.0/stork-macos-10-15"
try
	success(`./stork --version`)
catch
	success(`curl -L $addr -o stork`)
	success(`chmod +x stork`)
end

run(`./stork --version`)

# stork config

gc = Xranklin.DefaultGlobalContext()
Xranklin.set_paths!(gc, pwd())
@assert isfile(Xranklin.gc_cache_path()) "Couldn't find GC cache, did you build the website?"
Xranklin.deserialize_gc(gc)

# https://stork-search.net/docs/config-ref

io = IOBuffer()
write(io, """
	[input]
	base_directory = "__site"
	url_prefix = ""
	html_selector = ".content"

	""")

for ((k, _), v) in Xranklin.getvar(gc, nothing, :menu, nothing)
	for (kk, vv) in v
		rpath = "$k/$kk"
		if rpath * ".md" ∉ keys(gc.children_contexts)
			continue
		end
		title = vv
		write(io, """
			[[input.files]]
			path = "$rpath/index.html"
			url = "/$rpath/"
			title = "$title"

			""")
	end
end

open("stork-config.toml", "w") do outf
	write(outf, take!(io))
end

run(`./stork build --input stork-config.toml --output stork-search.st`)
cp("stork-search.st", "__site/assets/stork-search.st", force=true)
