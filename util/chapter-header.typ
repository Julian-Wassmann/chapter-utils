#import "chapter-numbering.typ": chapter-numbering

#let page-number(
  format-page: (page-number) => [Page #page-number]
) = locate(loc => {
  let page-number-format = loc.page-numbering()
  // show styled page-number if page-numbering is enabled
  if page-number-format != none {
    let page-number = counter(page).display(page-number-format)
    format-page(page-number)
  }
})

#let update-page-chapter() = {
  locate(loc => {
    let chapters = query(heading.where(level: 1), loc)
    // find last chapter heading on current page
    let last-chapter = chapters.rev()
      .find(h => h.location().page() == loc.page())
    // find first chapter heading on current page
    let first-chapter = chapters
      .find(h => h.location().page() == loc.page())
    // update states if chapters were found on this page
    if first-chapter != none {
      state("last-chapter").update(last-chapter)
      state("first-chapter").update(first-chapter)
      state("chapter-found").update(true)
    } else {
      state("chapter-found").update(false)
    }
  }
)}

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
  let chapter-number = if page-chapter.numbering != none {
    chapter-numbering(location: page-chapter.location(), numbering-pattern: page-chapter.numbering)
  } else {
    []
  }
  // apply default or specified format function
  format-chapter(chapter-number, page-chapter.body)
}

#let page-heading(
  format-chapter: format-chapter-default
) = {
  // updates chapter state to the current page
  update-page-chapter()
  // state.display returns content from its format function
  state("chapter-found").display(chapter-found => {
    if chapter-found {
      state("first-chapter").display(chapter => print-chapter(chapter, format-chapter))
    } else {
      state("last-chapter").display(chapter => print-chapter(chapter, format-chapter))
    }
  })
}

#let chapter-header(
  format-page: (page-number) => [Page #page-number],
  line-stroke: 0.3pt,
  line-spacing: 0.5em,
) = {
  // vertical distance between text and line
  set block(spacing: line-spacing)

  [
    #page-heading()
    #h(1fr)
    #page-number(format-page: format-page)
  ]
  
  line(
    length: 100%,
    stroke: line-stroke,
  )
}