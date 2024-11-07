### **5. Fetching a List of EC2 Instances and Modifying Them**

In this scenario, you will:
- Fetch all EC2 instances in a region that match a specific tag.
- Modify the instance types of the selected instances dynamically.

**Steps:**
1. Define the AWS provider.
2. Use the `aws_instances` data source to fetch all EC2 instances with a specific tag.
3. Modify the instance types of the selected instances.

**Terraform Code:**

```hcl
# Define the AWS provider
provider "aws" {
  region = "us-west-1"
}

# Fetch all EC2 instances with a specific tag
data "aws_instances" "tagged_instances" {
  filter {
    name   = "tag:Name"
    values = ["my-instance-tag"]
  }
}

# Modify the instance type for each selected EC2 instance
resource "aws_instance" "modified_instance" {
  for_each = toset(data.aws_instances.tagged_instances.ids)

  instance_id     = each.key
  instance_type   = "t2.medium"
  availability_zone = "us-west-1a"
}
```

**Explanation:**
- The `aws_instances` data source fetches all EC2 instances that match the specified tag (`tag:Name` = `my-instance-tag`).
- The `aws_instance` resource then modifies the instance type for each fetched EC2 instance using the `for_each` function.
