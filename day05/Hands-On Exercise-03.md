### 🛠️ Hands-On Exercise 3: Outputting and Inspecting State Data

1. **Objective**: Extract data from the state file and output it to examine the structure.
2. **Instructions**:
   - Define resources with attributes that can be outputted.
   - Use `terraform output` to view the values stored in the state.

3. **Code**:

   ```hcl
   provider "aws" {
     region = "us-west-1"
   }

   resource "aws_instance" "example" {
     ami           = "ami-123456"
     instance_type = "t2.micro"
   }

   output "instance_id" {
     value = aws_instance.example.id
   }
   ```

4. **Run**:
   - Run `terraform apply`.
   - Use `terraform show` or `terraform output` to inspect the state data.
