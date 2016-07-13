\usepackage{fontspec}
\usepackage{xunicode}
\usepackage{xltxtra}
\defaultfontfeatures{Scale=MatchLowercase,Mapping=tex-text}
\IfFileExists{iffont.sty}{
  \usepackage{iffont}
  \settofirstfound{\mainfont}{LTProjekt, DejaVu Sans, Liberation Sans}
  \settofirstfound{\boldfont}{LTProjekt Heavy, DejaVu Sans Bold, Liberation Sans Bold}
  \setmainfont[BoldFont=\boldfont]{\mainfont}
  \setsansfont[BoldFont=\boldfont]{\mainfont}
  \settofirstfound{\monofont}{Inconsolata, DejaVu Sans Mono, Liberation Sans Mono}
  \setmonofont[Scale=MatchLowercase, LetterSpace=-4]{\monofont}
}{
  \setmainfont{DejaVu Sans}
  \setsansfont{DejaVu Sans}
  \setmonofont[Scale=MatchLowercase, LetterSpace=-4]{DejaVu Sans Mono}
}

\usepackage{graphicx}
\usepackage[absolute]{textpos}
\setlength{\TPHorizModule}{1mm}
\setlength{\TPVertModule}{\TPHorizModule}

% counting for chapter, section, subsection, subsubsection
\setcounter{secnumdepth}{3}
% put into toc up to this subsection level
\setcounter{tocdepth}{2}

% head- and footlines
% -------------------
\newcommand*{\PtxFootLogo}{\raisebox{-0.4em}{\includegraphics[scale=.11]{new_logo_2006_ptx.pdf}}}
\makeatletter
\fancypagestyle{normal}{
  \fancyhf{}
  \fancyfoot[R]{{\py@HeaderFamily\thepage}}
  \fancyfoot[L]{{\PtxFootLogo}}
  \fancyhead[C]{{\py@HeaderFamily \leftmark}}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0.4pt}
}
\fancypagestyle{plain}{
  \fancyhf{}
  \fancyfoot[R]{{\py@HeaderFamily\thepage}}
  \fancyfoot[L]{{\PtxFootLogo}}
  \renewcommand{\headrulewidth}{0.0pt}
  \renewcommand{\footrulewidth}{0.4pt}
}

\renewenvironment{notice}[2]{
  \def\py@noticetype{#1}
  \csname py@noticestart@#1\endcsname
  \begin{minipage}[c]{\textwidth}

  \begin{center}

  \vspace{1ex}

  \begin{minipage}[c]{0.1 \textwidth}
    \includegraphics[scale=.075]{warning.pdf}
  \end{minipage}
  \begin{minipage}[c]{0.85 \textwidth}
    \begingroup\sf
}{
    \endgroup
  \end{minipage}

  \vspace{1ex}

  \end{center}
  \end{minipage}
\csname py@noticeend@\py@noticetype\endcsname }

\definecolor{VerbatimColor}{gray}{0.95}
\definecolor{VerbatimBorderColor}{gray}{0.75}

\makeatother

% vim:syntax=tex
