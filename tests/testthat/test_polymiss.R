test_that("it can make a polymiss", {
  expect_is(polymiss(), "polymiss")
})

testdf <- data.frame(
  a = 1:4,
  b = polymiss(1:4, c(1L, 1L, 2L, NA))
)

testdf2 <- data.frame(
  a = 1:4,
  c = polymiss(5:8, c(1L, 1L, 2L, NA))
)

test_that("rows can be bound", {
  expect_is(vec_rbind(testdf, testdf2), "data.frame")
})

testcom <- vec_rbind(testdf, testdf2)

test_that("`vec_rbind` uses <NONE> as default", {
  expect_true(is.na(field(testcom$c[1], "miss")))
})
