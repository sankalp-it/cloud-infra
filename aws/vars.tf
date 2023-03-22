variable "ami_id" {
    type = string
}
variable "instance_type" {
    type = string
}

variable "instance_name_prefix" {
    type = string
}

variable "availability_zone" {
    type = string
}

variable "esb_volume_size" {
    type = number
}

variable "device_name" {
    type = string
}

variable "esb_volume_name" {
    type = string
}

variable "existing-volume-id" {
    type = string
}

variable "ami_virtualization_type" {
    type = string
}
variable "custom_ami_name" {
    type = string
}

variable "root_device_name" {
    type = string
}

variable "volume_size" {
    type = number
}