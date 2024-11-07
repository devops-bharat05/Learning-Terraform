### 🛠️ Hands-On Exercise 2: Sensitive Variables and Outputs

1. **Objective**: Use sensitive variables for secure data and configure sensitive outputs.

2. **Goal**: Create an RDS database instance and set the password as a sensitive variable. Output the connection endpoint but mark it as sensitive.

3. **Instructions**:
   - Define a sensitive variable for the database password.
   - Use this variable in the RDS resource configuration.
   - Create an output for the database endpoint, and mark it as sensitive.

4. **Code**:

   ```hcl
   variable "db_password" {
     description = "The password for the RDS instance"
     type        = string
     sensitive   = true
   }

   provider "aws" {
     region = "us-west-1"
   }

   resource "aws_db_instance" "example" {
     allocated_storage    = 20
     engine               = "mysql"
     instance_class       = "db.t2.micro"
     name                 = "exampledb"
     username             = "admin"
     password             = var.db_password
     skip_final_snapshot  = true
   }

   output "db_endpoint" {
     description = "The connection endpoint for the RDS instance"
     value       = aws_db_instance.example.endpoint
     sensitive   = true
   }
   ```

5. **Run**:
   - Run `terraform apply`, and provide a value for the `db_password` variable when prompted.
   - After the resources are created, use `terraform output` to display the outputs.
   - Notice that the `db_endpoint` output is masked due to the `sensitive` setting.



