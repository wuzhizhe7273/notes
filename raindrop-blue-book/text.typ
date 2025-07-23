#import "@preview/curryst:0.5.0": rule, prooftree
#let tree-dict = rule(
  name: $R$,
  $C_1 or C_2 or C_3$,
  rule(
    name: $A$,
    $C_1 or C_2 or L$,
    rule(
      $C_1 or L$,
      $Pi_1$,
    ),
  ),
  rule(
    $C_2 or overline(L)$,
    $Pi_2$,
  ),
)
`tree-dict`的类型：#type(tree-dict) \
`tree-dict`代表的树：#prooftree(tree-dict)














