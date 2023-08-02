#import "lib.typ": chapter-header, chapter-numbering, page-number, page-heading

#set page(
  header: chapter-header(format-page: p => [Seite #p]),
  footer: [],
  numbering: "1",
)

#set math.equation(numbering: eqCounter => {
  let eqNumbering = numbering("1", eqCounter)
  [(#chapter-numbering().#eqNumbering)]
})

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
    page-heading(format-chapter: (number, body) => text(fill: blue)[Custom: *#body*])
    h(1fr)
    [Author, #datetime.today().display()]
    h(1fr)
    page-number(format-page: p => [p. #p])
  }
)