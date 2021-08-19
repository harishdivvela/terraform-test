variable "region" {
  type = string
  default = "us-east-2"
}
variable "ami" {
 type = string
 default = "ami-035287fe01e89ce94"
}

variable "int_type" {
  type = string
  default = "t2.xlarge"
}

#variable "subnet" {
#  type = string
#  default = "subnet-08bc8bc52fdf01323"
  
#}
  
variable "bucket" {
   type = string
   default = "my-bucket-03-08-2022"
}

variable "key" {
 #  type = list
   type = string
   default = "test"
}
variable "instance-count" {
   description = "The list of S3 folders to create"
   default     = ""
}
