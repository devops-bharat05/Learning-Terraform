### **4. Using Data Sources to Fetch a List of Available Availability Zones and Launching EC2 Instances**

In this hands-on exercise, you'll:
- Fetch a list of available availability zones in a region.
- Use the availability zones dynamically to launch multiple EC2 instances across different zones.

**Steps:**
1. Define the AWS provider.
2. Use the `aws_availability_zones` data source to fetch available availability zones.
3. Launch EC2 instances in different availability zones.

**Terraform Code:**

```hcl
# Define the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Fetch available availability zones
data "aws_availability_zones" "available_zones" {}

# Launch EC2 instances in different availability zones
resource "aws_instance" "ec2_instances" {
  for_each = toset(data.aws_availability_zones.available_zones.names)

  ami             = "ami-0c55b159cbfafe1f0"
  instance_type   = "t2.micro"
  availability_zone = each.key

  tags = {
    Name = "Instance-${each.key}"
  }
}
```

**Explanation:**
- The `aws_availability_zones` data source fetches all the available zones in the specified region.
- The `aws_instance` resource dynamically creates EC2 instances in each of the available zones using `for_each`.
