#import "chapter-numbering.typ": chapter-numbering

#let page-number(
  page-label: "Page",
) = locate(loc => {
  let page-number-format = loc.page-numbering()
  // show page-label and page-number if page-numbering is enabled
  if page-number-format != none {
    let page-number = counter(page).display(page-number-format)
    [#page-label #page-number]
  }
})

#let update-page-chapter() = {
  // state saves the current chapter of the page
  let page-chapter = state("page-chapter")
  locate(loc => {
    // find last heading on current page
    let last-heading = query(
      heading.where(level: 1), loc)
      .rev()
      .find(h => h.location().page() == loc.page())
    // update state if heading was found on this page
    if last-heading != none {
      page-chapter.update(last-heading)
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

#let page-heading(
  format-chapter: format-chapter-default
) = {
  // updates chapter state to the current page
  update-page-chapter()
  // state.display returns content from its format function
  state("page-chapter").display(page-chapter => {
    let chapter-number = if page-chapter.numbering != none {
      chapter-numbering(location: page-chapter.location(), numbering-pattern: page-chapter.numbering)
    } else {
      []
    }
    // apply default or specified format function
    format-chapter(chapter-number, page-chapter.body)
  })
}

#let chapter-header(
  page-label: "Page",
  line-stroke: 0.3pt,
  line-spacing: 0.5em,
) = {
  // vertical distance between text and line
  set block(spacing: line-spacing)

  [
    #page-heading()
    #h(1fr)
    #page-number(page-label: page-label)
  ]
  
  line(
    length: 100%,
    stroke: line-stroke,
  )
}