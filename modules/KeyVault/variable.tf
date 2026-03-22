variable "prefix" {}
variable "location" {}
variable "resource_group_name" {}
variable "tags" {
  description = "Tags to apply to all resources in this module"
  type        = map(string)
  default     = {}
}
