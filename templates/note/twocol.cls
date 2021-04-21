\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{twocol}[27/12/20 My Singlepage Class ]
\LoadClass[twocolumn]{article}

% {{{ Packages
\RequirePackage{anyfontsize}
\RequirePackage{t1enc}
\RequirePackage{geometry}
\RequirePackage{titlesec}
% }}}
% {{{ Colors
\usepackage{xcolor}

\definecolor{grayertext}{cmyk}{0, 0, 0 , 0.80}
\definecolor{commenttext}{cmyk}{0.9, 0.3, 0.3, 0}
% }}}
% {{{ Geometry
\newgeometry{
    margin=1in,
    top=0.5in,
    headheight=\headheight,
    headsep=\headsep
}
\savegeometry{singlepage}
% }}}
% {{{ Font
% {{{ General
\renewcommand*\familydefault{\sfdefault}
\AtBeginDocument{\fontsize{14pt}{16pt}\selectfont}
\color{grayertext}
% }}}
% {{{ Math font
\everymath{\color{black}}
% }}}
% }}}
% {{{ Headers
% {{{ Section
\titleformat{\section}
    [hang]% Shape
    {\color{black}\LARGE\bfseries}% Style
    {\thesection}% Label
    {1em}% Label spacing
    {}% Before code
    [{\vspace{10pt}\titlerule[0.5pt]}]% After code

\titlespacing{\section}
    {0pt}% left sep
    {0pt}% before sep
    {20pt}% after sep
% }}}
% }}}
