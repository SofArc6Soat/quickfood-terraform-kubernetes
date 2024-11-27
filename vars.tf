variable "regionDefault" {
    description = "The default region for the infrastructure"
    type        = string
    default     = "us-east-1"
}

variable "projectName" {
    description = "The name of the project"
    type        = string
    default     = "EKS-QUICKFOOD"
}

variable "labRole" {
    description = "The role for the lab environment"
    type        = string
    default     = "arn:aws:iam::869935090923:role/LabRole"
}

variable "accessConfig" {
    description = "The access configuration for the infrastructure"
    type        = string
    default = "API_AND_CONFIG_MAP"
}

variable "nodeGroup" {
    description = "The node group for the EKS cluster"
    type        = string
    default     = "quickfood"
}

variable "instanceType" {
    description = "The instance type for the EC2 instances"
    type        = string
    default     = "t2.micro"
}

variable "principalArn" {
    description = "The ARN of the principal"
    type        = string
    default     = "arn:aws:iam::869935090923:role/SofArc6Soat"
}

variable "policyArn" {
    description = "The ARN of the policy"
    type        = string
    default     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "db_username" {
  description = "The username for the RDS instance"
  type        = string
  default     = "sa"
}

variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
  default     = "quickfood-backend#2024"
  sensitive   = true
}