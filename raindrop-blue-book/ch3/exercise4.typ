#let matrix-fmt(matrix) = table(
  columns: matrix.first().len(),
  ..matrix.flatten().map((cell)=>[#cell])
)

#matrix-fmt((
  (1, 2, 3),
  (4, 5, 6),
  (7, 8, 9),
))