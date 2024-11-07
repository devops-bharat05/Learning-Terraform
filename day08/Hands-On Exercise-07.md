### **7. Using Data Sources with Dynamic Block**

This exercise demonstrates how to use data sources with dynamic blocks for flexibility, specifically for creating a set of resources based on dynamically fetched data.

In this case, we will dynamically create multiple security groups based on a list of rules fetched from a central repository (or file).

**Steps:**
1. Define the AWS provider.
2. Use the `aws_security_group` data source to fetch a list of security group rules.
3. Use a `dynamic` block to create multiple security groups based on the fetched rules.

**Terraform Code:**

```hcl
# Define the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Fetch security group rules from an existing security group
data "aws_security_group" "existing_sg" {
  filter {
    name   = "group-name"
    values = ["my-existing-sg"]
  }
}

# Create multiple security groups dynamically based on fetched rules
resource "aws_security_group" "dynamic_sg" {
  for_each = toset(data.aws_security_group.existing_sg.ingress)

  name        = "dynamic-sg-${each.key}"
  description = "Dynamically created security group"

  ingress {
    from_port   = each.value.from_port
    to_port     = each.value.to_port
    protocol    = each.value.protocol
    cidr_blocks = each.value.cidr_blocks
  }
}
```

**Explanation:**
- The `aws_security_group` data source is used to fetch the ingress rules from an existing security group.
- The `for_each` function iterates over the fetched ingress rules and dynamically creates a security group for each rule using a `dynamic` block.
