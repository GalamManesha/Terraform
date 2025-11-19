variable "instance_type" {
  type    = string
  default = "t3.small"
}

variable "key_name" {
  type    = string
  default = "connect"
}

variable "ami" {
  type    = string
  default = "ami-02b8269d5e85954ef"
}

variable "tags" {
  type    = string
  default = "variables-hello"
}

variable "region" {
  type    = string
  default = "ap-south-1"
}
