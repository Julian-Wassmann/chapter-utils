#import "./chapter-numbering.typ": chapter-numbering

#let get-page-chapter(headerLoc) = {
  let chapters = query(heading.where(level: 1), headerLoc)
  // try to find a chapter heading on current page
  let page-chapter = chapters
    .find(h => h.location().page() == headerLoc.page())
  // if current page contains no chapter heading, find last chapter heading before current page
  if page-chapter == none {
    page-chapter = chapters.rev()
      .find(h => h.location().page() < headerLoc.page())
  }
  page-chapter
}

#let format-chapter-default(number, body) = {
  if number == [] {
    [#body]
  } else {
    [#number #body]
  }
}

#let print-chapter(
  page-chapter,
  format-chapter,
) = {
  if page-chapter == none {
    return []
  }
  let chapter-number = if page-chapter.numbering != none {
    chapter-numbering(location: page-chapter.location(), numbering-pattern: page-chapter.numbering)
  } else {
    []
  }
  // apply default or specified format function
  format-chapter(chapter-number, page-chapter.body)
}

#let page-chapter(
  format-chapter: format-chapter-default
) = {
  locate(loc => {
    let page-chapter = get-page-chapter(loc)
    print-chapter(page-chapter, format-chapter)
  })
}