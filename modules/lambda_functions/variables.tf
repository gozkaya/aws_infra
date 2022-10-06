variable "package_type" {
  type        = string
  description = "Package type of the lambda function"
  default     = "Zip"
}
variable "lambda_role_arn" {
  type        = string
  description = "Lambda role arn"

}

variable "architectures" {
  type        = list(string)
  description = "Architecture of the lambda function"
}
variable "runtime" {
  type        = string
  description = "Runtime of the lambda function"
}
variable "function_name" {
  type        = string
  description = "Name of the lambda function"
}
variable "handler" {
  type        = string
  description = "Handler of the lambda function"
}
variable "s3_bucket" {
  type        = string
  description = "S3 bucket where we keep the lambda function artifacts"
}
variable "s3_key" {
  type        = string
  description = "S3 key where we keep the lambda function artifacts"
}
variable "timeout" {
  type        = number
  description = "Timeout of the lambda function"
  default     = 3
}

variable "pipeline" {
  type    = string
  default = "default"
}

