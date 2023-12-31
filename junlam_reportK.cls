% -*- TeX:UTF-8 -*-
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{junlam_reportK}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 경기과학고 R&E 보고서 양식 수정 내역 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%[2018/07/29 v.1.30]
% [2014/09/02 v0.1 Standard GSHS report document class, ko.TeX version] 
% initiated by 정민석(2014년도 경기과학고 수학과 전문교원)
% [2015/11/22 v0.11 Standard GSHS report document class, ko.TeX version] 
% modified by 박승원(32nd, 14041, seungwonpark) 
% 변경사항 : Figure를 Fig. 로 변경, References 를 '참고문헌'으로 변경, figure/table numbering 의 chapter 넘어갈때마다 문제생기는점 해결, SI 단위계 사용 가능하게 함
% [2015/11/25 v0.12 Standard GSHS report document class, ko.TeX version] 
% modified by 이상헌(32nd, 14080, evenharder) 
% 변경사항 : 심화 R&E 보고서에 지도교수의 이름을 표지에 추가해주는 \professor 구문 추가 및 fifthe 관련 오타 수정
% [2016/02/07 v0.13 Standard GSHS report document class, ko.TeX version] 
% modified by 박승원(32nd, 14041, seungwonpark)
% 변경사항 : 

% 인코딩 관련 주의사항 : 이 클래스에서 기본적으로 kotex을 포함하고 있기에 따로 포함할 필요는 없으나, inputenc 등의 추가적인 class 사용이나 TeXstudio의 'Insert encoding as TeX comment'는 삼가시기 바랍니다.

%% 그림과 표의 번호가 chapter를 넘어가도 초기화되지 않도록 설정. sample report 파일에 \counterwithout{figure}{chapter}가 포함됨
%\usepackage{chngcntr} % figure numbering across chapters continously

%[2016/06/02 v1.2 Standard GSHS report document class] 
% modified by 서울(경기과학고 물리교사), 박승원(32nd, 14041, seungwonpark)
% 변경사항(서울) : 표지의 폰트 및 vskip 간격 일부 수정, 지도교사/교수 이메일란 추가.
% 변경사항(박승원) : reporttype 를 통해 중간/결과 를 선택 가능하게 함, section formatting 수정 (section 계층 번호부여를 arabic 대신 roman 으로 수정)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 과학전람회 보고서 양식 수정 내역 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%[2020/06/27 v1.0 Standard GSHS report document class]
% modified by 한수민(37th, 19119, polaris041437)
% 변경사항 : preamble과 class 파일을 수정해 표지를 경기과학고 R&E 보고서에서 과학전람회 보고서 형식으로 변경함. HWP 파일 대신 LaTeX을 사용해 과학전람회 서류 제출이 가능하도록 함

\usepackage{ifxetex} % 부득이하게 pdflatex을 사용해도 문제가 없도록 함

\ifxetex
\LoadClass[11pt]{article}
\else
\usepackage[nonfrench]{kotex}
\LoadClass[pdftex, 11pt]{article}
\fi 

%\usepackage{geometry}
\usepackage{amssymb}
\usepackage{amsmath}
\usepackage{graphicx}
\usepackage[margin=3pt,font=small,labelfont=bf]{caption}
\usepackage{subcaption}
\usepackage{fancyhdr}
\usepackage[nottoc]{tocbibind}
\usepackage{titlesec}
\usepackage{tocloft}
\usepackage[toc,page]{appendix}

\ifxetex
\else
\usepackage[T1]{fontenc}   % To use Times New Roman
\usepackage[utf8]{inputenc}% To use Times New Roman
\fi

\usepackage{mathptmx}      % To use Times New Roman
\usepackage{array}
\usepackage{setspace}


\usepackage{enumitem} % itemize, enumerate 환경 여백 조절
\setitemize{noitemsep} % 여백이 너무 넓어서 기본 여백으로 만듦
\setenumerate{noitemsep} % 여백이 너무 넓어서 기본 여백으로 만듦

\renewcommand{\thesection}{\Roman{section}}
\renewcommand{\thefootnote}{\fnsymbol{footnote}} 
% 주석 번호와 참고문헌 번호의 혼동을 막기 위해 arabic 대신 fnsymbol 사용(asterisk, dagger, double dagger, ...)


\usepackage{indentfirst}
\setlength\parindent{2.0em}

\RequirePackage{ifthen}       % 추가 패키지 설정
\RequirePackage{tabu}

\usepackage[nottoc]{tocbibind}
\usepackage{titlesec}
\usepackage{cite}   % citation [1,2,3] --> [1-3]

\bibliographystyle{junlam_report}
%\usepackage[numbers,sort&compress]{natbib}
%\setlength{\bibsep}{0em}
%\bibliographystyle{gshs_thesisnat}

\usepackage{etoolbox}
\apptocmd{\thebibliography}{\setlength{\itemsep}{0pt}}{}{}
%\setstretch{1.5}


%% SI Unit 을 사용하기 위한 설정. \SI{1}{\meter\per\sec}는 m/s 와 같이 나옴.
\usepackage[per-mode=symbol]{siunitx}
\sisetup{inter-unit-product = \cdot}
%http://tex.stackexchange.com/questions/59032/how-to-format-si-units

%% 옵션 설정을 위한 boolean 변수선언
\newif\if@isDoctor
\newif\if@isKorean
\newif\if@isFinal
\newif\if@PDFdoc\@PDFdocfalse
\newif\if@dvips\@dvipsfalse

%% 새 옵션 모음 - korean|english, final|draft
\DeclareOption{korean} {\@isKoreantrue}
\DeclareOption{english}{\@isKoreanfalse}
%\DeclareOption{basic}  {\@isBasictrue}
%\DeclareOption{intensice}  {\@isFinalfalse}

%% leqno,fleqn,openbib 옵션은 그대로 report 클래스에 전달
\DeclareOption{leqno}  {\PassOptionsToClass{leqno}  {article}}
\DeclareOption{fleqn}  {\PassOptionsToClass{fleqn}  {article}}
\DeclareOption{openbib}{\PassOptionsToClass{openbib}{article}}


\ExecuteOptions{english,final}         % doctor,korean,final이 기본값
\ProcessOptions


%%들여쓰기

%%%% Hangul-ucs preamble.......
\RequirePackage[nonfrench]{kotex}
%\RequirePackage[default]{dhucs-interword}

%수학 패키지
\RequirePackage{amsmath}
\RequirePackage{graphicx,xcolor}
\usepackage{amssymb}
\usepackage{amsthm}

%% for compatability to HLaTeX
\let\gt\sffamily
\DeclareTextFontCommand{\textgt}{\gt}
%%%% end of Hangul-ucs preamble

%% 편집용지 설정
\usepackage[left=20mm,right=20mm,top=25mm,bottom=25mm]{geometry}

\usepackage{setspace}

%% 줄간격 설정
%\renewcommand{\baselinestretch}{1.3}
\linespread{1.6}

%% 본문이 영어로 되어있는지 한글로 되어있는지 설정
\newcommand{\@korean}{korean}
\newcommand{\@english}{english}
\newcommand{\@textlang}{}                    % 텍스트 기본언어 변수선언
\if@isKorean                                 % korean 옵션이 지정되어 있으면
\let\@textlang\@korean                  % 텍스트 기본언어는 한글
\else                                        % english 옵션이 지정되어 있으면
\let\@textlang\@english                 % 텍스트 기본언어는 영문
\fi

%% pagestyle 
\def\ps@gshs{\let\@mkboth\@gobbletwo
	\let\@oddhead\@empty
	\def\@oddfoot{\reset@font\hfil--\ \thepage\ --
		\hfil}%
	\let\@evenhead\@empty\let\@evenfoot\@oddfoot
}

\pagestyle{gshs}

%%
%% 문서 정보 변수 정의
%%


% 출품 학생
\newcommand{\studentnames}[1]{
	\newcommand{\@studentnames}{#1}
        }
\@onlypreamble{\studentnames} 


% 출품 번호
\newcommand{\summitnumber}[1]{
	\newcommand{\@summitnumber}{#1}
 }
\@onlypreamble{\summitnumber}

%% 출품 분야 (학생, 교원)
\newcommand{\entryfield}[1]{
	\newcommand{\@entryfield}{#1}
 }
\@onlypreamble{\entryfield}

%% 출품 부문 (물리, 화학, 생물, 산업 및 에너지, 지구 및 환경)
\newcommand{\entrysection}[1]{
	\newcommand{\@entrysection}{#1}
 }
\@onlypreamble{\entrysection}

%% 과학전람회 회수 (연도 - 1954)
\newcommand{\junlam}[1]{
	\newcommand{\@junlam}{#1}}
\@onlypreamble{\junlam}


% @command advisor 지도교사 이름
\newcommand{\advisor}[1]{
	\newcommand{\@advisor}{#1}
}
\@onlypreamble{\advisor}

% @param year,month,day 연,월,일 순으로 입력
\newcommand{\summitdate}[3]{
	\newcommand{\@summitYear}{#1}
	\newcommand{\@summitMonth}{#2}
	\newcommand{\@summitDate}{#3}		
}
\@onlypreamble{\summitdate}


%%
%% 앞표지 생성
%%
\newcommand{\makecover}{%
	\renewcommand{\baselinestretch}{1.3}%
	\thispagestyle{empty} \noindent%
	%\@summitYear \newline
	% \@summitYear 학년도\newline
	% {\sf \textbf{경기과학고등학교 \@type R\&E \@reporttype 보고서}}
	\vskip 3cm
	\noindent\begin{minipage}[t]{\textwidth}
	\begin{tikzpicture}
		\centering;
		\draw (0mm, 0mm) -- (25mm, 0mm) -- (25mm, 20mm) -- (0mm, 20mm) -- cycle;
		\draw (0mm, 15mm) -- (25mm, 15mm);
		\node(number) at (12.5mm, 17.5mm) {\fontsize{12pt}{12pt}\selectfont 출품번호};
       % \node(number1) at (12.5mm, 8mm) {\fontsize{16pt}{16pt}\selectfont 지-6};
        \node(number1) at (12.5mm, 8mm) {\fontsize{16pt}{16pt}\selectfont \@summitnumber};
	\end{tikzpicture}
	\end{minipage}
	
	\vskip 1cm
	\noindent\begin{minipage}[t]{\textwidth}
		\begin{center}
			\fontsize{24pt}{24pt}\selectfont  제\@junlam회 전국과학전람회 \\[24pt]
		\end{center}
	\end{minipage}
 
	\vskip 2.0cm
	\noindent\begin{minipage}[t]{\textwidth}
	\begin{center}
		\begin{tikzpicture}
			\centering;
			\draw[thick] (0mm, 0mm) -- (160mm, 0mm) -- (160mm, 17mm) -- (0mm, 17mm) -- cycle;
			\node(title) at (80mm, 8mm) {\fontsize{18pt}\selectfont \@title};
		\end{tikzpicture}
	\end{center}
	\end{minipage}
	\vskip 1.5cm
	
	% \noindent\begin{minipage}[t]{\textwidth}
	% \begin{center}
	% 	\begin{tikzpicture}
	% 		\centering;
	% 		\draw[thick] (0mm, 0mm) -- (125mm, 0mm) -- (125mm, 15mm) -- (0mm, 15mm) -- cycle;
	% 		\draw[thick] (62.5mm, 0mm) -- (62.5mm, 15mm);
	% 		\draw[dotted] (30mm, 0mm) -- (30mm, 15mm);
	% 		\draw[dotted] (92.5mm, 0mm) -- (92.5mm, 15mm);
	% 		\node(field1) at (15mm, 7mm) {\fontsize{15pt}{15pt}\selectfont 출품분야};
	% 		\node(stu) at (46.2mm, 7mm) {\fontsize{15pt}{15pt}\selectfont \@entryfield};
	% 		\node(field2) at (77.5mm, 7mm) {\fontsize{15pt}{15pt}\selectfont 출품부문};
	% 		\node(ess) at (108.5mm, 7mm) {\fontsize{15pt}{15pt}\selectfont \@entrysection};
	% 	\end{tikzpicture}
	% \end{center}
	% \end{minipage}
	
	\vskip 2.5cm
	%\vskip 3.6604cm %3cm + 12pt*1.3*1.2
	\noindent\begin{minipage}[c]{\textwidth}
		\begin{center}
			\fontsize{20pt}{20pt}\selectfont \@summitYear. \@summitMonth. \@summitDate
		\end{center}
	\end{minipage}

	\vskip 3.5cm
	\noindent\begin{minipage}[c]{\textwidth}
		\begin{center}
			\begin{tikzpicture}
				\centering;
				% \draw (0mm, 0mm) -- (108mm, 0mm) -- (108mm, 40mm) -- (0mm, 40mm) -- cycle;
                    \draw (0mm, 0mm) -- (108mm, 0mm);
                    \draw (0mm, 10mm) -- (108mm, 10mm);
                    \draw (0mm, 20mm) -- (108mm, 20mm);
                    \draw (0mm, 30mm) -- (108mm, 30mm);
                    \draw (0mm, 40mm) -- (108mm, 40mm);
                    \draw (42mm, 0mm) -- (42mm, 40mm);
                    \draw (0mm, 0mm) -- (0mm, 40mm);
                    \draw (108mm, 0mm) -- (108mm, 40mm);
				\node(field3) at (21mm, 35mm) {\fontsize{13pt}{13pt}\selectfont 출품학생};
				\node(name) at (75mm, 35mm) {\fontsize{13pt}{13pt}\selectfont \@studentnames };
				\node(student) at (21mm, 25mm) {\fontsize{13pt}{13pt}\selectfont 지도교원};
                    \node(name) at (75mm, 25mm) {\fontsize{13pt}{13pt}\selectfont \@advisor };
				\node(teacher) at (21mm, 15mm) {\fontsize{13pt}{13pt}\selectfont 구    분};
                \node(name) at (75mm, 15mm) {\fontsize{13pt}{13pt}\selectfont \@entryfield };
                \node(teacher) at (21mm, 5mm) {\fontsize{13pt}{13pt}\selectfont 출품부분};
                \node(name) at (75mm, 5mm) {\fontsize{13pt}{13pt}\selectfont \@entrysection };
			\end{tikzpicture}
		\end{center}
	\end{minipage}
	\newpage
}

%% %한글초록
%% \newenvironment{abstractkor}{%
%% 	\pagenumbering{roman}                        % 로마자 페이지 시작
%% 	\thispagestyle{plain}%
%% 	\vspace*{5cm}
%% 	\begin{center} \Large \textbf{초~~~~~록} \end{center}  % 초록명 -> Abstract
%% 	\hspace*{5mm}
%% 	\if@PDFdoc\phantomsection\fi\addcontentsline{toc}{content}{초록}% 초록을 목차(TOC)에 삽입



%%%%%%%%%%%%%%%%%%%%%%%
%%% Abstract layout %%%
%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{alwayssingle}{%
	\@restonecolfalse\if@twocolumn\@restonecoltrue\onecolumn
	\else\newpage\fi}
{\if@restonecol\twocolumn\else\newpage\fi}

\newenvironment{abstracts}{\begin{alwayssingle} \thispagestyle{plain}
  \vspace*{20mm}
  \begin{center}
  \begin{minipage}[h][35mm][c]{\textwidth}
    \begin{center}
    {\begin{spacing}{1.0}\LARGE\bfseries\textbf{Abstract}\end{spacing}}
	%{\begin{spacing}{1.0}\LARGE\bfseries\@engtitle\end{spacing}}
    \end{center}
  \end{minipage}
  %\par\vspace{35mm}
  \par\vspace{30mm}
  %{\LARGE \bfseries  Abstract}
  \end{center}
  \par\vspace{0.5cm}
}{\end{alwayssingle}}

\newenvironment{abstractskor} {\begin{alwayssingle} \thispagestyle{plain}
  \begin{center}
  \vspace*{20mm}
  \begin{minipage}[h][35mm][c]{\textwidth}
    \begin{center}
	{\begin{spacing}{1.5}\LARGE\bfseries\textbf{초~~~~~록}\end{spacing}}
    %{\begin{spacing}{1.5}\LARGE\bfseries\@title\end{spacing}}
    \end{center}
  \end{minipage}
  \par\vspace{35mm}
  %{\LARGE \bfseries{\@korabstract}}
  \end{center}
  \par\vspace{0.5cm}}{\end{alwayssingle}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Table of Contents layout %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\renewcommand{\contentsname}{\begin{center}Contents\end{center}}
%\renewcommand{\listfigurename}{\begin{center}List of Figures\end{center}}
%\renewcommand{\listtablename}{\begin{center}List of Tables\end{center}}
\renewcommand{\cftsecleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cfttoctitlefont}{\hspace*{\fill}\huge\bfseries}
\renewcommand{\cftaftertoctitle}{\hspace*{\fill}}
\renewcommand{\cftlottitlefont}{\hspace*{\fill}\huge\bfseries}
\renewcommand{\cftafterlottitle}{\hspace*{\fill}}
\renewcommand{\cftloftitlefont}{\hspace*{\fill}\huge\bfseries}
\renewcommand{\cftafterloftitle}{\hspace*{\fill}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% List of Figures/Table layout %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newlength{\mylenfig}
\newlength{\mylentab}

\renewcommand{\cftfigpresnum}{\textbf{\figurename}\enspace}
\renewcommand{\cfttabpresnum}{\textbf{\tablename}\enspace}
\renewcommand{\cftfigfont}{\bfseries}
\renewcommand{\cfttabfont}{\bfseries}
\renewcommand{\cftfigaftersnum}{.}
\renewcommand{\cfttabaftersnum}{.}
\renewcommand{\cftfigaftersnumb}{\normalfont}
\renewcommand{\cfttabaftersnumb}{\normalfont}
\settowidth{\mylenfig}{\cftfigpresnum}
\settowidth{\mylentab}{\cfttabpresnum}
\addtolength{\cftfignumwidth}{\mylenfig}
\addtolength{\cfttabnumwidth}{\mylentab}
%% \setlength{\cftfigindent}{0pt}  % remove indentation from figures in lof
%% \setlength{\cfttabindent}{0pt}  % remove indentation from tables in lot

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% toc, lot, lof layout %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\cfttoctitlefont}{\hspace*{\fill}\huge\bfseries}
\renewcommand{\cftaftertoctitle}{\hspace*{\fill}}
\renewcommand{\cftlottitlefont}{\hspace*{\fill}\huge\bfseries}
\renewcommand{\cftafterlottitle}{\hspace*{\fill}}
\renewcommand{\cftloftitlefont}{\hspace*{\fill}\huge\bfseries}
\renewcommand{\cftafterloftitle}{\hspace*{\fill}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%헤딩 재설정
\renewcommand{\contentsname}{%
\if@isKorean 목 차       \else  목 차       \fi}
\renewcommand{\listfigurename}{%
\if@isKorean 그 림 목 차 \else 그 림 목 차 \fi}
\renewcommand{\listtablename}{%
\if@isKorean 표 목 차    \else 표 목 차  \fi}
\renewcommand{\bibname}{%
\if@isKorean 참 고 문 헌 \else 참 고 문 현 \fi}
 
 \renewcommand \thefigure {\@arabic\c@figure}
 \renewcommand \thetable {\@arabic\c@table}
 \def\fnum@table{\thetable}
 \def\fnum@figure{\thefigure}

 \renewcommand\figurename{그림}%{\sf Fig.}
 \renewcommand\tablename{표}%{\sf Tab.}
 \def\fnum@figure{\figurename\nobreakspace\thefigure}
 \def\fnum@table{\tablename\nobreakspace\thetable}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Chapter/section title format %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\usepackage{titlesec}

%\titleformat{command}[shape]{format}{label}{sep}{before-code}{after-code}

\titleformat{\section}[hang]
{\LARGE\bfseries}{\Roman{section}.}{1em}{}{}
\titleformat{\subsection}[hang]
{\Large\bfseries}{\arabic{section}.\arabic{subsection}}{1em}{}{}
\titleformat{\subsubsection}[hang]
{\large}{\arabic{section}.\arabic{subsection}.\arabic{subsubsection}}{1em}{}{}
\titleformat{\paragraph}[hang]
{\normalfont\fontsize{12}{12}\selectfont\it}{}{1em}{}{}

%% section 명령어 수정 - section 넘어갈 때마다 clearpage.. 드디어 해결..!
\let\stdsection\section
\renewcommand\section{\newpage\stdsection}

%%
%% 목차에 나오는 형식 - report 클래스로부터 복사하여 일부 수정
%%

\newcommand{\l@content}{\large\bf\@dottedtocline{1}{0em}{0em}}


\if@isKorean % 한글이면 각종 치수를 변경
\renewcommand*\l@section{\@dottedtocline{1}{2.7em}{2.3em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{5.0em}{3.2em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{8.2em}{4.1em}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{11.2em}{5em}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{13.2em}{6em}}
\else \fi     % 영문이면 가만히 내버려둠


%%
%% 한국식 날짜 표기 -> 영문식 날짜 표기
%%
\newcommand{\@dateUSenglish}[3]{%  % 미국식 날짜 표기
	\newcommand{\@year}{#1}%
	\newcommand{\@month}{#2}%
	\newcommand{\@day}{#3}%
	\ifcase\@month \or
	January \or February \or March \or April \or May \or June \or
	July \or August \or September \or October \or November \or December \fi
	\@day, \@year
}
\newcommand{\@dateBRenglish}[3]{%  % 영국식 날짜 표기
	\newcommand{\@year}{#1}%
	\newcommand{\@month}{#2}%
	\newcommand{\@day}{#3}%
	\@day\ifcase\@day \or
	st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
	st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or
	st\or nd\or rd\or th\or th\or th\or th\or th\or th\or th\or th\fi
	\space\ifcase\@month \or
	January\or February\or March\or April\or May\or June\or
	July\or August\or September\or October\or November\or December\fi,
	\@year
}


\long\def\@makecaption#1#2{%
	\vskip\abovecaptionskip
	\sbox\@tempboxa{#1. #2}%
	\ifdim \wd\@tempboxa >\hsize
	#1. #2\par
	\else
	\global \@minipagefalse
	\hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
	\fi
	\vskip\belowcaptionskip}