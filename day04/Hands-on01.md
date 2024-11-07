### 🛠️ Hands-On Exercise 1: Using Complex Variables

1. **Objective**: Use a **map** and **list** variable to define multiple configuration values.
   
2. **Goal**: Create two EC2 instances with different configurations (one for dev and one for prod) using a **map** variable.

3. **Instructions**:
   - Define a map variable to hold different instance types for development and production.
   - Use the list variable to specify two availability zones.
   - Use these variables to create two EC2 instances, one for each environment.

4. **Code**:

   ```hcl
   variable "instance_types" {
     description = "Instance types for different environments"
     type        = map(string)
     default     = {
       dev  = "t2.micro"
       prod = "t2.medium"
     }
   }

   variable "availability_zones" {
     description = "List of availability zones"
     type        = list(string)
     default     = ["us-west-1a", "us-west-1b"]
   }

   provider "aws" {
     region = "us-west-1"
   }

   resource "aws_instance" "dev_instance" {
     ami           = "ami-123456"
     instance_type = var.instance_types["dev"]
     availability_zone = var.availability_zones[0]
     tags = {
       Name = "DevInstance"
     }
   }

   resource "aws_instance" "prod_instance" {
     ami           = "ami-123456"
     instance_type = var.instance_types["prod"]
     availability_zone = var.availability_zones[1]
     tags = {
       Name = "ProdInstance"
     }
   }
   ```

5. **Run**:
   - Initialize Terraform with `terraform init`.
   - Apply the configuration with `terraform apply`.
   - Verify that two instances were created with the specified configurations.

---


