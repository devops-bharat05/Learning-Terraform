### 🛠️ Hands-On Exercise 5: Nested Outputs with Complex Data Types

1. **Objective**: Use complex data structures (lists and maps) in outputs to return structured data.

2. **Goal**: Create a configuration that outputs multiple details about a resource in a structured format, like instance ID, type, and availability zone.

3. **Instructions**:
   - Define a resource with multiple attributes.
   - Create an output that returns these details in a map structure.

4. **Code**:

   ```hcl
   provider "aws" {
     region = "us-west-1"
   }

   resource "aws_instance" "example" {
     ami           = "ami-123456"
     instance_type = "t2.micro"
     tags = {
       Name = "StructuredOutputInstance"
     }
   }

   output "instance_details" {
     description = "Detailed information of the instance"
     value = {
       instance_id         = aws_instance.example.id
       instance_type       = aws_instance.example.instance_type
       availability_zone   = aws_instance.example.availability_zone
     }
   }
   ```

5. **Run**:
   - Run `terraform apply` to provision the instance.
   - Use `terraform output instance_details` to view the structured data, showing details like instance ID, type, and availability zone.
