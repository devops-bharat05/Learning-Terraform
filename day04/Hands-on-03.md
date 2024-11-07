### 🛠️ Hands-On Exercise 3: Dynamic Resource Count with Variables

1. **Objective**: Use a **number** variable to dynamically control the count of a resource.

2. **Goal**: Create multiple EC2 instances with a variable that allows you to specify the desired instance count.

3. **Instructions**:
   - Define a `count` variable to control how many EC2 instances are created.
   - Use this variable in the `aws_instance` resource’s `count` argument.

4. **Code**:

   ```hcl
   variable "instance_count" {
     description = "Number of EC2 instances to create"
     type        = number
     default     = 2
   }

   provider "aws" {
     region = "us-west-1"
   }

   resource "aws_instance" "example" {
     count         = var.instance_count
     ami           = "ami-123456"
     instance_type = "t2.micro"
     tags = {
       Name = "Instance-${count.index + 1}"
     }
   }

   output "instance_ids" {
     description = "List of IDs for created EC2 instances"
     value       = [for instance in aws_instance.example : instance.id]
   }
   ```

5. **Run**:
   - Run `terraform apply` to create the default number of instances.
   - To create more instances, override the default by using `-var="instance_count=4"` when applying the configuration.
   - Verify the number of instances created in the AWS console.


