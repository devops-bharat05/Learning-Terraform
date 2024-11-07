### **1. Fetching and Using the Latest AMI Based on Specific Filters (Multiple Filters)**

In this scenario, you will:
- Fetch the most recent Amazon Linux 2 AMI with multiple filters.
- Use this AMI to create an EC2 instance in a specific availability zone.

**Steps:**
1. Define the AWS provider.
2. Use the `aws_ami` data source to fetch the latest Amazon Linux 2 AMI with multiple filters (name and architecture).
3. Create an EC2 instance in a specific availability zone.

**Terraform Code:**

```hcl
# Define the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Fetch the latest Amazon Linux 2 AMI with filters for architecture and name
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filters = {
    name                 = "amzn2-ami-hvm-*-x86_64-gp2"
    architecture         = "x86_64"
    virtualization_type  = "hvm"
  }
}

# Create an EC2 instance using the fetched AMI in a specific availability zone
resource "aws_instance" "my_instance" {
  ami               = data.aws_ami.latest_amazon_linux.id
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"

  tags = {
    Name = "AmazonLinuxInstance"
  }
}
```

**Explanation:**
- The `aws_ami` data source fetches the most recent Amazon Linux 2 AMI with filters for both architecture (`x86_64`) and virtualization (`hvm`).
- The `aws_instance` resource then creates an EC2 instance using the fetched AMI in a specific availability zone (`us-east-1a`).
