locals {
  firstnames_from_splat = var.objects_list[*].firstname
  roles_from_splat      = [for username, user_props in local.user_list : user_props.role]
}

output "firstnames_from_splat" {
  value = local.firstnames_from_splat
}

output "roles_from_splat" {
  value = local.roles_from_splat
}