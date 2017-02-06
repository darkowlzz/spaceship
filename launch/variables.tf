variable "region" {
  default = "us-east-1"
}

variable "image_id" {}
variable "instance_type" {
  default = "t2.large"
}
variable "enable_public_ip" {
  default = true
}
variable "key_pair" {}
variable "sg_id" {}
variable "private_key_path" {}
