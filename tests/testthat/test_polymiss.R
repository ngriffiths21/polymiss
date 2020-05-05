test_that("it can make a polymiss", {
  expect_is(polymiss(), "polymiss")
})

test_that("it doesn't take an incorrect value for `miss`", {
  expect_error(polymiss(c(1, 2), miss = c(1L, 3L)))
})

testp <- polymiss(1:4, miss = c(1L, 1L, 2L, NA))

test_that("it formats correctly", {
  verify_output(test_path("test-print-polymiss.txt"), {
    testp
  })
})  

test_that("types are correct", {
  expect_is(vec_ptype2(polymiss(), polymiss()), "polymiss")
  expect_is(vec_ptype2(polymiss(), double()), "numeric")
  expect_is(vec_ptype2(double(), polymiss()), "numeric")
})

test_that("casts double to polymiss", {
  expect_is(as_polymiss(c(3, NA)), "polymiss")
})


test_that("casts polymiss to double", {
  expect_equal(as.double(testp), c(1, 2, NA, NA))
})

test_that("it can do arithmetic", {
  res <- testp + polymiss(1:4, rep(1L, 4))
  expect_equal(res, c(2, 4, NA, NA))
})

test_that("it can't add different types", {
  expect_error(testp + 1:4)
})

test_that("it can subset", {
  expect_equal(testp[1:2], polymiss(1:2, c(1L, 1L)))
})

test_that("it can do base math", {
  expect_equal(sum(testp[1:2]), 3)
})
  
