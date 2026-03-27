variable "env" {
  default = "dev"
}

variable "ami" {
  default =  "ami-0220d79f3f480ecf5" #
}

variable "vpc_security_group_ids" {
  default = [ "sg-03dfc56f63b6d06c5" ]
}

variable "zone_id" {
  default = "Z03369982K8R0OHQ4XJJV"
}
variable "components" {
  default = {
    mongodb   = "t3.small"
    mysql     = "m7i-flex.large"
    rabbitmq  = "t3.small"
    redis     = "t3.small"
  }
}
