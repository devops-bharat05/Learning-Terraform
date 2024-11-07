### **5. Fetching a Route Table by VPC ID**

In this exercise, we'll fetch an existing route table from a given VPC and add a route to it.

**Steps:**
1. Define the AWS provider.
2. Use the `aws_route_table` data source to fetch the route table from the specified VPC.
3. Add a route to the existing route table.

**Terraform Code:**

```hcl
# Define the AWS provider
provider "aws" {
  region = "us-west-1"
}

# Fetch the existing route table by VPC ID
data "aws_route_table" "existing_rt" {
  vpc_id = "vpc-12345678"
}

# Add a route to the existing route table
resource "aws_route" "additional_route" {
  route_table_id         = data.aws_route_table.existing_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "igw-12345678"
}
```

**Explanation:**
- The `aws_route_table` data source fetches the route table for the specified VPC ID (`vpc-12345678`).
- The `aws_route` resource adds a route to the fetched route table.
