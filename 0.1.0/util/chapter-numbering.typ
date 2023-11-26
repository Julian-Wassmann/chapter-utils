#let chapter-numbering(
  depth: 1,
  seperator: ".",
  numbering-pattern: "1",
  location: none,
) = {
  locate(loc => {
    if type(location) == "location" {
      loc = location
    }    
    counter(heading).at(loc)
      .enumerate()
      .filter(((level, ..)) => depth == none or level < depth)
      .map(((.., heading-number)) => {
        numbering(numbering-pattern, heading-number)
      })
      .join(seperator)
  })
}