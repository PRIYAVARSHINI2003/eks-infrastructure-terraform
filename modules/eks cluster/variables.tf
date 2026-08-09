variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
  default="my-eks-cluster"
}

variable "private_subnet_id_1" {
  description = "The ID of the first private subnet"
  type        = string
}

variable "private_subnet_id_2" {
  description = "The ID of the second private subnet"
  type        = string
}
variable "instance_type"{
    description="The instance type for the EKS node group"
    type=string
    default="t3.medium"
}