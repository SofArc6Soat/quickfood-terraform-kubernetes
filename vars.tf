variable "regionDefault" {
    description = "The default region for the infrastructure"
    type        = string
    default     = "us-east-1"
}

variable "projectName" {
    description = "The name of the project"
    type        = string
    default     = "EKS-QuickFood"
}

variable "labRole" {
    description = "The role for the lab environment"
    type        = string
    default     = ""
}

variable "accessConfig" {
    description = "The access configuration for the infrastructure"
    type        = string
    default     = ""
}

variable "nodeGroup" {
    description = "The node group for the EKS cluster"
    type        = string
    default     = "fiap"
}

variable "instanceType" {
    description = "The instance type for the EC2 instances"
    type        = string
    default     = "t2.micro"
}

variable "principalArn" {
    description = "The ARN of the principal"
    type        = string
    default     = ""
}

variable "policyArn" {
    description = "The ARN of the policy"
    type        = string
    default     = ""
}