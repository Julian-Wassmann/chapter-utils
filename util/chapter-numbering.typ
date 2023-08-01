#let chapter-numbering(
  depth: 1,
  seperator: ".",
  numbering-pattern: "1",
) = {
  counter(heading).display((..heading-numbers) => {
    heading-numbers
      .pos()
      .enumerate()
      .filter(((level, ..)) => depth == none or level < depth)
      .map(((.., heading-number)) => {
        numbering(numbering-pattern, heading-number)
      })
      .join(seperator)
  })
}