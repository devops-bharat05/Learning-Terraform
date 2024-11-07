### 🛠️ Hands-On Exercise 4: Organizing Variables and Outputs with .tfvars Files and Modules

1. **Objective**: Use a `.tfvars` file for organized variable values and create a reusable module for creating EC2 instances.

2. **Goal**: Modularize the configuration and use `.tfvars` for variable inputs. Create an EC2 instance module that can be reused in other configurations.

3. **Instructions**:
   - Move the EC2 instance configuration into a `modules/instance` directory.
   - Create a `.tfvars` file to define variable values for a specific environment.
   - Import the module in the main configuration.

4. **Code**:

   **Module Configuration (modules/instance/main.tf)**:
   ```hcl
   variable "instance_type" {
     description = "Type of EC2 instance"
     type        = string
     default     = "t2.micro"
   }

   variable "instance_name" {
     description = "Name for the EC2 instance"
     type        = string
     default     = "ModuleInstance"
   }

   resource "aws_instance" "module_instance" {
     ami           = "ami-123456"
     instance_type = var.instance_type
     tags = {
       Name = var.instance_name
     }
   }

   output "instance_id" {
     description = "ID of the EC2 instance"
     value       = aws_instance.module_instance.id
   }
   ```

   **Main Configuration (main.tf)**:
   ```hcl
   provider "aws" {
     region = "us-west-1"
   }

   module "dev_instance" {
     source        = "./modules/instance"
     instance_type = "t2.small"
     instance_name = "DevInstance"
   }
   ```

   **Variable File (dev.tfvars)**:
   ```hcl
   instance_type = "t2.small"
   instance_name = "DevEnvironmentInstance"
   ```

5. **Run**:
   - Run `terraform apply -var-file="dev.tfvars"` to apply the configuration with the values defined in `dev.tfvars`.
   - Verify that the instance is created with the specified type and name from the `.tfvars` file.


