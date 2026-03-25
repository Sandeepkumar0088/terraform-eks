variable "env" {
  default = "dev"
}

variable "ami" {
  default =  "ami-0220d79f3f480ecf5" #
}

variable "vpc_security_group_ids" {
  default = [ "sg-080ee07db03cf22ab" ]
}

variable "zone_id" {
  default = "Z09354891N46GVLJSDZH0"
}
variable "components" {
  default = {
    mongodb   = "t3.small"
    mysql     = "m7i-flex.large"
    rabbitmq  = "t3.small"
    redis     = "t3.small"
  }
}
