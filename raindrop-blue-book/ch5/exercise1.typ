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

#let main-typ() = {
  heading("生活在Content树上")
  {
    [现代社会以海德格尔的一句]
    [“一切实践传统都已经瓦解完了”]
    [为嚆矢。]
  } + parbreak()
  [...] + parbreak()
  [在孜孜矻矻以求生活意义的道路上，对自己的期望本就是在与家庭与社会对接中塑型的动态过程。]
  [而我们的底料便是对不同生活方式、不同角色的觉感与体认。]
  [...]
}

#plain-text(main-typ())
