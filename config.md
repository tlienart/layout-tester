+++

author = "Thibaut Lienart"

# Base URL prefix when live
meta_description = "Franklin"
github = "https://github.com/tlienart/Franklin.jl"

content_tag = ""
skiplatex = true
showtoc = true



menu = [
    ("workflow" => "Workflow") => [
        "getting-started" => "Getting Started",
        "folder-structure" => "Folder Structure",
        "adapting-layout" => "Adapting a Layout",
        "deployment" => "Deployment"
    ],
    ("syntax" => "Syntax") => [
        "basics" => "Basics",
        "extensions" => "Extensions",
        "code" => "Code Blocks",
        "code-2" => "Code Blocks (2)",
        "page-variables" => "Page Variables",
        "utils" => "Utils" 
    ],
]

+++




<!-- GLOBAL REFERENCES -->

[juliaweb]: https://julialang.org
[Pure.css]: https://purecss.io/
[hljs]: https://highlightjs.org/
[katex]: https://katex.org/
[mathjax]: https://www.mathjax.org/
[pycall]: https://github.com/JuliaPy/PyCall.jl
[rcall]: https://github.com/JuliaInterop/RCall.jl
[dataframes]: https://github.com/JuliaData/DataFrames.jl
[bootstrap]: https://getbootstrap.com/
[franklin-repo]: https://github.com/tlienart/Franklin.jl
[liveserver]: https://github.com/tlienart/LiveServer.jl

[page vars]: /syntax/vars+funs/
[code eval]: /syntax/code/
[hfuns]: /syntax/vars+funs/
[hfun]: /syntax/vars+funs/

[GA]: https://docs.github.com/en/actions

<!-- GLOBAL COMMANDS -->

\newcommand{\emdash}{&#8212;}

\newcommand{\lskip}{
  ~~~
  <div style="height:1em;"></div>
  ~~~
}

\newcommand{\fieldset}[3]{
  ~~~
  <fieldset class="#1"><legend class="#1-legend">#2</legend>
  ~~~
  #3
  ~~~
  </fieldset>
  ~~~
}

<!--
  Show markdown + what it looks like in a box
-->
\newcommand{\showmd}[1]{
  ~~~
  <div class="trim">
  ~~~
  \fieldset{md-input}{markdown}{
    `````plaintext
    #1
    `````
  }
  ~~~
  </div>
  ~~~
  <!--
  XXX keep extra line skip otherwise the blockquote and the
  showmd environment blend and it's ugly!
   -->
  ~~~
  <div class="trim">
  ~~~
    \fieldset{md-result}{result}{
    ~~~~~~

    #1

    ~~~~~~
    }
  ~~~
  </div>
  ~~~
}

<!--
  Note about difference with CommonMark
-->
\newcommand{\cmdiff}[1]{
  \fieldset{cm-diff}{&ne; CommonMark}{
    #1
  }
}

<!--
  Tip
-->
\newcommand{\tip}[1]{
  \fieldset{tip}{🚀 Tip}{
    #1
  }
}

<!--
 Todo
-->
\newcommand{\todo}[1]{
  \fieldset{todo}{🚧 To Do}{
    #1
  }
}

<!--
 Note
-->
\newcommand{\note}[1]{
  \fieldset{note}{⚠️ Note}{
    #1
  }
}


\newcommand{\kbd}[1]{ ~~~<kbd>#1</kbd>~~~ }
