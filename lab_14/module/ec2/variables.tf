variable "staging_type" {
  type    = string
  default = "dev"

  validation {
    condition     = contains(["dev", "uat", "prod"], var.staging_type)
    error_message = "Allowed values for input_parameter are \"dev\", \"uat\", or \"prod\"."
  }
}

variable "isntance_types" {
  type    = map(string)
  default = {
    "dev" = "t2.nano",
    "uat" = "t2.small",
    "prod" = "t2.large"
  }
}
