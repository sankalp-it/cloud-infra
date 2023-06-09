variable "availability_zone" {
    type = string
}

variable "esb_volume_size" {
    type = number
    default = 1
}

variable "esb_volume_name" {
    type = string
}

variable "volume_source_snapshot_id" {
    type = string
    default = ""
}