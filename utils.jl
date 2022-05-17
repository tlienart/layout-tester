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
                        <a href="/$base/$(e.first)/" class="pure-menu-link">
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