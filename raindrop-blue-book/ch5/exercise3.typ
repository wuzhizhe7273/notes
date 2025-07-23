#let plain-text(it) = {
  if it.has("children") {
    ("", ..it.children.map(plain-text)).join()
  } else if it.has("child") {
    plain-text(it.child)
  } else if it.has("body") {
    plain-text(it.body)
  } else if it.has("text") {
    it.text
  } else if it.func() == smartquote {
    if it.double { "\"" } else { "'" }
  } else {
    " "
  }
}

#let word-count(it) = {
  plain-text(it).replace(regex("\p{hani}"), "\1 ").split().len()
}

#let show-me-the(it) = {
  repr(plain-text(it))
  [ 的字数统计为 ]
  repr(word-count(it))
}
#show-me-the([])\
#show-me-the([一段文本]) \
#show-me-the([A bc]) \
#show-me-the([
  - 列表项1
  - 列表项2
])