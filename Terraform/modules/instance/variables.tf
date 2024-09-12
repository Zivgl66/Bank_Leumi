variable "instances" {
  description = "Map of EC2 instances to create"
  type = map(object({
    ami           = string
    instance_type = string
    subnet_id     = string
    name          = string
    vpc_security_group_ids = list(string)
    key_name = optional(string)  
    user_data     = optional(string)  
  }))
}