variable "region" {
    default = "us-east-2"
}

variable "aws_ubuntu_amis" {
    default = {
        "us-east-2" = "ami-0283a57753b18025b"
    }
}
variable "aws_centos_amis" {
    default = {
        "us-east-2" = "ami-05a36e1502605b4aa"
    }
}
variable "environment"{
    type = string
    default = "dev"
}

variable "application" {
    type = string
    default = "gitlab"
}

variable "key_name" {
    type = string
    default = "anael_premier"
}

variable "mgmt_ips" {
    default = ["0.0.0.0/0"]
}
