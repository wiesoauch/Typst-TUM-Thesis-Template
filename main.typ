#import "template.typ": *


// !!! in template.typ in the top lines you can disable drafting

#show: project.with(
  degree: "Master",
  program: "Informatics",
  supervisor: "Prof. Dr. Albert Einstein",
  advisors: ("Dr. Werner Braun", "Hans Günther M.Sc.",),
  author: "Max Mustermann",
  startDate: "15.01.1799",
  titleEnglish: "How to solve all problems at once with Algorithms",
  titleGerman: "Wie man glücklich wird durch Algorithmik",
  bibfile: "items.bib",
  submissionDate: datetime.today().display("[day].[month].[year]"),
  abstract_de: [#todo[Hier kommt die deutsche Übersetzung des englischen Abstracts hin]],
  abstract_en: [
    #lorem(60)
  ],
  acknowledgements: [
    I would like to express my gratitude to Fabian
  ]
)

// All abreviations which should not be hyphenated
#show "BMBWF": text.with(hyphenate: false)
#show "TUM.AI": text.with(hyphenate: false)

= Introduction <chapter_introduction>
#include "Chapter_Introduction.typ"

/*
= Background <chapter_background>
#include "Chapter_Background.typ"

= Related Work <chapter_relatedwork>
#include "Chapter_RelatedWork.typ"

= Methodology <chapter_methodology>
#include "Chapter_Methodology.typ"

= Experiments <chapter_experiments>
#include "Chapter_Experiments.typ"

= Discussion <chapter_discussion>
#include "Chapter_Discussion.typ"

= Future Research <chapter_futureresearch>
#include "Chapter_FutureResearch.typ"
*/