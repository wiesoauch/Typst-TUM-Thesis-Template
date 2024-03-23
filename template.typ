#import "cover.typ": *
#import "titlepage.typ": *
#import "disclaimer.typ": *
#import "acknowledgement.typ": *
#import "abstract.typ": *

#import "@preview/glossarium:0.2.3": make-glossary, print-glossary, gls, glspl
#import "@preview/tablex:0.0.6": tablex, rowspanx, colspanx

#let draft = true
#let mydraft = true

// Standard Formats
#let todo(it) = [
  #if mydraft [
    #text(size: 0.8em)[#emoji.pencil]  #text(it, fill: red, weight: 600)
  ]
]

#let silentheading(level, body) = [
  #heading(outlined: false, level: level, numbering: none, bookmarked: true)[#body]
]

#let tablemyx(..args) = {
  set par(justify: false)
  tablex.with(stroke: 0.5pt + black, inset: 6.5pt)(..args)
}

#let project(
  glossary: (),
  degree: "The degree",
  program: "The Program",
  supervisor: "Your Supervisor",
  advisors: ("The first advisor", "The second advisor"),
  author: "The Author",
  startDate: "The Startdate",
  titleEnglish: "English Title",
  titleGerman: "German Title",
  abstract_en: [English Abstract],
  abstract_de: [German Abstract],
  acknowledgements: [The acknowledgements],
  submissionDate: "(Handover Date)",
  bibfile: "",
  body,
) = {
show: make-glossary
let draft_string = ""
if draft{
  draft_string = "DRAFT – "
}

set text(ligatures: false)

set document(author: author, title: draft_string + titleEnglish)
set page(
    numbering: "1",
    number-align: center,
    margin: (left: 25mm, right: 25mm, top: 30mm, bottom: 30mm),
    header: [
    #set text(8pt)
    //#author – #titleEnglish
    #h(1fr)
    #if draft [
      DRAFT
    ]
  ],
)
set text(lang: "en", size: 12pt)



set page(numbering: none)
set text(font: "New Computer Modern Sans")

cover(
  title: draft_string + titleEnglish,
  degree: degree,
  program: program,
  author: author,
)

titlepage(
  title: draft_string + titleEnglish,
  titleGerman: titleGerman,
  degree: degree,
  program: program,
  supervisor: supervisor,
  advisors: advisors,
  author: author,
  startDate: startDate,
  submissionDate: draft_string + submissionDate
)

disclaimer(
  title: titleEnglish,
  degree: degree,
  author: author,
  submissionDate: submissionDate
)

acknowledgement(acknowledgements)

abstract(lang: "en")[#abstract_en]

abstract(lang: "de")[#abstract_de]

  

set heading(numbering: "1.1")

show heading.where(level: 1): it => [
  #pagebreak(weak: true)
  #it
]

show heading.where(level: 3): set text(size: 1.05em)
show heading.where(level: 4): set text(size: 1.0em)

show ref: it => {
  let el = it.element
  if el != none and el.func() == heading {

    [#it (#el.body)]
  } else [#it]
}

show ref: set text(fill: color.olive)
show link: set text(fill: blue)

set heading(supplement: it => {
  if (it.has("level")) {
  if it.level == 1 [Part]
  else if it.level == 2 [Chapter]
  else [Section]
} else {
  [ERRORREF]
}
})

show outline.entry.where(
  level: 1
): it => {
  v(1em, weak: true)
  strong(it)
}


// Table of contents.
outline(
  title: {
    text(1.3em, weight: 700, "Contents")
    v(10mm)
  },
  indent: 2em,
  depth: 3
)
pagebreak(weak: false)



// Main body.
show cite: set text(fill: blue) if mydraft
show footnote: set text(fill: purple) if mydraft
set cite(style: "alphanumeric")
set cite(style: "chicago-author-date") if mydraft


show figure: set text(size: 0.9em)
show figure: it => [#v(1em) #it #v(1em)]
set table(stroke: 0.5pt + black, inset: 6.5pt)
show table: set par(justify: false)

set page(numbering: "1")
counter(page).update(1)
set par(leading: 0.9em, first-line-indent: 1.8em, justify: true)
show par: set block(spacing: 1em)
set text(font: "New Computer Modern")
show raw: set text(font: "New Computer Modern Mono")
show heading.where(level: 1): set block(above: 1.95em, below: 1em)
show heading.where(level: 2): set block(above: 1.85em, below: 1em)
show heading.where(level: 3): set block(above: 1.75em, below: 1em)
show heading.where(level: 4): set block(above: 1.55em, below: 1em)
set math.equation(numbering: "(1)")

body

set page(numbering: "i")
counter(page).update(1)


// List of Acronyms.
heading(numbering: none)[List of Acronyms]
print-glossary(glossary)

/*
// List of figures.
heading(numbering: none)[List of Figures]
outline(
  title: none,
  target: figure.where(kind: image),
)

// List of tables.
heading(numbering: none)[List of Tables]
outline(
  title: none,
  target: figure.where(kind: table)
)
*/

// Appendix.
heading(numbering: none)[Appendix A: Supplementary Material]
include("Chapter_Appendix.typ")


set par(leading: 0.7em, first-line-indent: 0em, justify: true)
bibliography(bibfile, style: "apa")

}