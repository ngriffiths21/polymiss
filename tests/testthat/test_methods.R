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


test_that("`recode` works properly", {
  testp <- polymiss(1:4, c(1L, 1L, 2L, NA))
  expected <- polymiss(c(10, 2, 3, 4), c(1L, 1L, 2L, NA))

  res <- dplyr::recode(testp, `1` = 10L)
  expect_equal(res, expected)
})

test_that("`reduce` works properly", {
  testp <- polymiss(1:4, c(1L, 1L, NA, NA))

  expect_equal(reduce(testp, `+`), 3)
})
