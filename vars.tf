variable "regionDefault" {
  description = "The default region for the infrastructure"
  type        = string
  default     = "us-east-2"
}

variable "projectName" {
  description = "The name of the project"
  type        = string
  default     = "EKS-QuickFood"
}

variable "labRole" {
  description = "The role for the lab environment"
  type        = string
  default     = "arn:aws:iam::869935090923:role/LabRole"
}

variable "accessConfig" {
  description = "The access configuration for the infrastructure"
  type        = string
  default     = "API_AND_CONFIG_MAP"
}

variable "nodeGroup" {
  description = "The node group for the EKS cluster"
  type        = string
  default     = "quickfood"
}

variable "instanceType" {
  description = "The instance type for the EC2 instances"
  type        = string
  default     = "t3.medium"
}

variable "principalArn" {
  description = "The ARN of the principal"
  type        = string
  default     = "arn:aws:iam::869935090923:role/LabRole"
}

variable "policyArn" {
  description = "The ARN of the policy"
  type        = string
  default     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}


variable "db_instance_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
  default     = "quickfood-db"
}

variable "db_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
  default     = "db.t3.micro"
}

variable "db_engine" {
  description = "The database engine for the RDS instance"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "The engine version for the RDS instance"
  type        = string
  default     = "8.0"
}

variable "db_username" {
  description = "The master username for the RDS instance"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "The master password for the RDS instance"
  type        = string
  default     = "quickfood-backend#2024"
  sensitive   = true
}

variable "db_allocated_storage" {
  description = "The allocated storage for the RDS instance"
  type        = number
  default     = 20
}

variable "db_subnet_group_name" {
  description = "The subnet group name for the RDS instance"
  type        = string
  default     = "quickfood-db-subnet-group"
}
