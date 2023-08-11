############################################
## Provider variables
############################################
variable "pm_api_url" {
  type = string
  sensitive = true
}

variable "pm_api_token_id" {
  type      = string
  sensitive = true
}

variable "pm_api_token_secret" {
  type      = string
  sensitive = true
}

############################################
## Resource variables
############################################
variable "root_password" {
  type      = string
  sensitive = true
}