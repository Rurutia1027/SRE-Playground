locals {
  math       = 2 * 2 - 2 * 1 + 1 / 5
  equality   = 2 == 3                # equality operators: == ; !=
  comparison = 2 <= 3                # >=, <= , <, >
  logical    = false || true && true # true, false
}

output "operator_rets" {
  value = {
    ret_math       = local.math
    ret_equality   = local.equality
    ret_comparison = local.comparison
    ret_logical    = local.logical
  }
}