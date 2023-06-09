variable "ami_id" {
    type = string
}
variable "instance_type" {
    type = string
}

variable "instance_name_prefix" {
    type = string
}

variable "instance_key_name" {
    type = string
}

variable "sg_id" {
    type = string
}

variable "user_data" {
    type = string
    default = ""
}