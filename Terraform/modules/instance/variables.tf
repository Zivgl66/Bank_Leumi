variable "instances" {
  description = "A map of instances with AMI IDs, instance types, subnets, and instance names"
  type = map(object({
    ami           = string
    name          = string
    instance_type = string
    subnet_id     = string
  }))
}