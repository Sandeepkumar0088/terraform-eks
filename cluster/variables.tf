variable "env" {
  default = "dev"
}

variable "ami" {
  default =  "ami-0220d79f3f480ecf5" # "ami-09c813fb71547fc4f"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "vpc_security_group_ids" {
  default = [ "sg-080ee07db03cf22ab" ]
}

variable "zone_id" {
  default = "Z09354891N46GVLJSDZH0"
}
variable "components" {
  default = {
    mongodb = ""
    mysql = ""
    rabbitmq = ""
    redis = ""
  }
}
