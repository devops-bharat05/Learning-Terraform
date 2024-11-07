### **1. Fetching the Latest Amazon Linux AMI**

In this exercise, we will fetch the latest Amazon Linux 2 AMI from AWS and use it to create an EC2 instance.

**Steps:**
1. Define the provider for AWS.
2. Use the `aws_ami` data source to fetch the latest Amazon Linux AMI.
3. Use the fetched AMI to create an EC2 instance.

**Terraform Code:**

```hcl
# Define the AWS provider
provider "aws" {
  region = "us-west-1"
}

# Fetch the latest Amazon Linux 2 AMI
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filters = {
    name                 = "amzn2-ami-hvm-*-x86_64-gp2"
    virtualization_type  = "hvm"
  }
}

# Create an EC2 instance using the fetched AMI
resource "aws_instance" "my_instance" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t2.micro"
  tags = {
    Name = "MyInstance"
  }
}
```

**Explanation:**
- The `aws_ami` data source fetches the most recent Amazon Linux 2 AMI that matches the specified filter.
- The `aws_instance` resource then uses the `data.aws_ami.latest_amazon_linux.id` to launch an EC2 instance with the fetched AMI.
