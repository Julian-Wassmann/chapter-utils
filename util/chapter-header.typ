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

// state saves the current chapter label of the page header
#let chapter-label = state("chapter-label", [])
#let page-heading() = locate(
  loc => {
    // find first heading on current page
    let first-heading = query(
      heading.where(level: 1), loc)
      .find(h => h.location().page() == loc.page())
    // if headings were found on this page
    if first-heading != none {
      if first-heading.numbering == none { // chapter without numbering
        chapter-label.update([#first-heading.body])
      } else { // chapter with numbering
        let heading-counter = counter(heading).at(first-heading.location()).first()
        chapter-label.update([#heading-counter. #first-heading.body])
      }
    }
    chapter-label.display()
  }
)

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