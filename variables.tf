variable "env" {
  default = "dev"
}

variable "ami" {
  default =  "ami-0220d79f3f480ecf5" # "ami-09c813fb71547fc4f"
}

variable "instance_type" {
  default = "t3.small"
}

variable "vpc_security_group_ids" {
  default = [ "sg-080ee07db03cf22ab" ]
}

variable "zone_id" {
  default = "Z057881017RC0RRKVUX8E"
}

variable "components" {
  default = {
    mongodb = ""
    mysql = ""
    rabbitmq = ""
    redis = ""
  }
}