#' @keywords internal
#' @import vctrs
#' @name polymiss
NULL

new_polymiss <- function(x = double(), miss = integer()) {
  vec_assert(miss, ptype = integer(), size=length(x))
  if(!all(miss %in% 1L:2L | is.na(miss))) stop("The `miss` field must contain integers between 1 and 2.")

  new_rcrd(list(x = x, miss = miss), class = "polymiss")
}

#' @export
polymiss <- function(x = double(), miss = integer()) {
  new_polymiss(x, miss)
}

#' @export
format.polymiss <- function(x, ...) {
  x2 <- field(x, "x")
  miss <- field(x, "miss")

  dplyr::case_when(
    miss == 1 ~ as.character(x2),
    miss == 2 ~ "<UNK>",
    is.na(miss) ~ "<NONE>"
  )
}

#' @export
vec_ptype2.polymiss.polymiss <- function(x, y, ...) polymiss()
#' @export
vec_ptype2.polymiss.double <- function(x, y, ...) double()
#' @export
vec_ptype2.double.polymiss <- function(x, y, ...) double()

#' @export
vec_cast.polymiss.polymiss <- function(x, to, ...) x
#' @export
vec_cast.polymiss.double <- function(x, to, ...) {
  miss <- ifelse(is.na(x), 2L, 1L)
  polymiss(x, miss)
}

#' @export
as_polymiss <- function(x) {
  vec_cast(x, polymiss())
}

#' @export
vec_cast.double.polymiss <- function(x, to, ...) {
  as.double(rawdata(x))
}

rawdata <- function (x) {
  x2 <- field(x, "x")
  miss <- field(x, "miss")

  ifelse(miss == 1L, x2, NA)
}

# todo: turn into polymiss
#' @export
vec_math.polymiss <- function (fn, x, ...) {
  vec_math_base(fn, rawdata(x), ...)
}

# Standard boilerplate

#' @export
#' @method vec_arith polymiss
vec_arith.polymiss <- function(op, x, y, ...) {
  UseMethod("vec_arith.polymiss", y)
}

#' @export
vec_arith.polymiss.default <- function(op, x, y, ...) {
  stop_incompatible_op(op, x, y)
}

# todo: turn into polymiss w/ correct miss
#' @export
#' @method vec_arith.polymiss polymiss
vec_arith.polymiss.polymiss <- function (op, x, y, ...) {
  vec_arith_base(op, rawdata(x), rawdata(y))
}
