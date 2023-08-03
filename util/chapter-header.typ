#import "page-heading.typ": page-heading

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