import Literate
import HTTP
import UnicodePlots

# used in syntax/vars+funs #e-strings demonstrating that e-strings are
# evaluated in the Utils module
bar(x) = "hello from foo <$x>"

struct Foo
    x::Int
end
html_show(f::Foo) = "<strong>Foo: $(f.x)</strong>"

struct Baz
    z::Int
end
newbaz(z) = Baz(z)

####################################
# Layout
####################################

function hfun_navmenu()
    io = IOBuffer()
    for m in getgvar(:menu)
        name = m.first
        subs = m.second

        # Submenu title + start of subs
        write(io, """
            <div class="submenu-title">
                $(uppercasefirst(name))
            </div>
            <ul class="pure-menu-list">
            """)

        # subs items
        for s in subs
            loc   = "$name/$s"
            rloc  = loc * ".md"
            if rloc in keys(cur_gc().children_contexts)
                title = getvarfrom(:menu_title, loc * ".md")
                write(io, """
                    <li class="pure-menu-item">
                        <a href="/$loc/" class="pure-menu-link">
                            $title
                        </a>
                    </li>
                    """)
            end
        end

        # end of list
        write(io, "</ul>")
    end
    return String(take!(io))
end


####################################
# TTFX
####################################

function hfun_ttfx(p)
    p  = first(p)
    r  = ""
    r2 = ""

    # XXX PERF XXX
    return ""

    try
        r = HTTP.request(
            "GET",
            "https://raw.githubusercontent.com/tlienart/Xranklin.jl/gh-ttfx/ttfx/$(p)/timer"
        )
        r2 = HTTP.request(
            "GET",
            "https://raw.githubusercontent.com/tlienart/Xranklin.jl/gh-ttfx/ttfx/$(p)/timer2"
        )
    catch e
        return ""
    end
    t  = first(reinterpret(Float64, r.body))
    t2 = first(reinterpret(Float64, r2.body))
    return "$(t)min / $(t2)s"
end


####################################
# UnicodePlots
####################################

function html_show(p::UnicodePlots.Plot)
    td = tempdir()
    tf = tempname(td)
    io = IOBuffer()
    UnicodePlots.savefig(p, tf; color=true)
    # assume ansi2html is available
    if success(pipeline(`cat $tf`, `ansi2html -i -l`, io))
        return "<pre>" * String(take!(io)) * "</pre>"
    end
    return ""
end


####################################
# Utils examples lxfun/envfun/hfun
####################################
function lx_exlx(p::Vector{String})
    # {hello}{foo}
    return "<i>$(uppercase(p[1]))</i> <b>$(uppercasefirst(p[2]))</b>"
end
function lx_exlx2()
    return "<s>hello</s>"
end
function lx_exlx3()
    return "<span style='color:blue'>{{a_global_variable}}</span>"
end

# function env_exenv(p::Vector{String})
#
# end

#############################################################
# Actual Utils
#############################################################

function hfun_rm_headings(ps::Vector{String})
    c = cur_lc()
    c === nothing && return ""
    for h in ps
        if h in keys(c.headings)
            delete!(c.headings, h)
        end
    end

    return ""
end

function hfun_generate_menu()
   menu = getgvar(:menu)
   io = IOBuffer()
   write(io, """
        <ul class="pure-menu-list">
        """)
   for m in menu
        base = m.first.first
        name = m.first.second
        write(io, """
            <li class="pure-menu-item">
            """)
        
        if !isempty(m.second)
            write(io, """
                <a href="/$base/$(first(m.second).first)/" class="pure-menu-link">
                    $name
                </a>
                <ul class="pure-menu-list">
                """)
            for e in m.second
                write(io, """
                    <li class="pure-menu-item">
                        <a href="/$base/$(e.first)/" class="pure-menu-link {{ispage /$base/$(e.first)/}}selected{{end}}">
                            $(e.second)
                        </a>
                    </li>
                    """)
            end
            write(io, """
                </ul>
                """)
        
        else
            write(io, """
                <a href="/$base/" class="pure-menu-link">
                    $name
                </a>
                """)
        end
        
        write(io, """
            </li>
            """)
   end
   write(io, """
        </ul>
        """)
    return html2(String(take!(io)), cur_lc())
end