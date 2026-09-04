locals {
  project_upper = upper(var.project_name)

  project_lower = lower(var.project_name)

  project_length = length(var.project_name)

  project_parts = split("-", var.project_name)
}