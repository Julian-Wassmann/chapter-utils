#import "./page-chapter.typ": page-chapter

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
  mirror-even: false,
  mirror-odd: false,
) = {
  locate(loc => {
    let even = calc.even(loc.page())
    let mirror = if even and mirror-even or not even and mirror-odd {
      true
    } else {
      false
    }

    // vertical distance between text and line
    set block(spacing: line-spacing)

    if mirror [
      #page-number(format-page: format-page)
      #h(1fr)
      #page-chapter()
    ] else [
      #page-chapter()
      #h(1fr)
      #page-number(format-page: format-page)
    ]
    
    line(
      length: 100%,
      stroke: line-stroke,
    )
  })
}