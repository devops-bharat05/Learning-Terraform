### 🛠️ Hands-On Exercise 1: Using a Local State File

1. **Objective**: Create resources and observe the local state file.
2. **Instructions**:
   - Create a simple configuration file to provision a resource (e.g., an EC2 instance).
   - Run `terraform apply` to create the resources.
   - Open `terraform.tfstate` to explore the structure and data stored.

3. **Code**:

   ```hcl
   provider "aws" {
     region = "us-west-1"
   }

   resource "aws_instance" "example" {
     ami           = "ami-123456"
     instance_type = "t2.micro"
   }
   ```

4. **Run**:
   - Run `terraform init` and `terraform apply`.
   - Explore the generated `terraform.tfstate` file.
