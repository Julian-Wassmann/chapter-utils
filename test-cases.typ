#import "lib.typ": chapter-header, chapter-numbering, page-number, page-chapter

#set page(
  header: chapter-header(
    format-page: p => [Seite #p],
    mirror-even: true,
  ),
  footer: [],
  numbering: "1",
  paper: "a6",
)

#set math.equation(numbering: eqCounter => {
  let eqNumbering = numbering("1", eqCounter)
  [(#chapter-numbering().#eqNumbering)]
})

#pagebreak()

= Chapter 0

#pagebreak()
#pagebreak()

#set heading(numbering: "1.")

= Chapter 1
$ a^2 + b^2 = c^2 $

= Chapter 2

#pagebreak()

#set page(
  header: [],
  footer: {
    page-chapter(format-chapter: (number, body) => text(fill: blue)[Custom: *#body*])
    h(1fr)
    [Author, #datetime.today().display()]
    h(1fr)
    page-number(format-page: p => [p. #p])
  }
)