// TODO: Page number in header lacks default page number behind, after page counter gets updated: Only for "empty" pages. Possible workaround: hide()

#import "./lib.typ": chapter-header, chapter-numbering, page-number, page-chapter

#set page(
  paper: "a6"
)

#align(center)[#text(size: 20pt)[Title Page]]

#set heading(numbering: "1.")
#counter(page).update(0)
#set page(
  numbering: "I",
  header: chapter-header(),
  //footer: [],
)
#outline()

#counter(page).update(0)
#set page(numbering: "1")
= Chapter A
#lorem(200)

#pagebreak()
= Chapter B
#lorem(30)
= Chapter C
#lorem(30)

#set page(
  header: [#page-chapter()#h(1fr)#page-number()],
)
= Chapter D
#lorem(30)

#set page(
  header: [
    #page-chapter(format-chapter: (number, body) => [#number - #body])
    #h(1fr)
    #page-number(format-page: page => [p. #page])
  ],
)
= Chapter E
#lorem(30)

#pagebreak()

#counter(page).update(0)
#set page(
  header: chapter-header(format-page: page => [A #page])
)
#set heading(numbering: none)
= Appendix
#lorem(30)