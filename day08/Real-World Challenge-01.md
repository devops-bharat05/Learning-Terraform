### **1. Fetching Resources Based on Tags and Using Them in Different Regions**

In this exercise, you'll:
- Fetch resources based on tags across multiple regions.
- Use the fetched resources (VPC, subnet, and security group) in a different region to launch a new EC2 instance.

**Steps:**
1. Define the AWS provider for multiple regions.
2. Fetch a VPC, subnet, and security group using the `aws_vpc`, `aws_subnet`, and `aws_security_group` data sources.
3. Use the fetched resources to create an EC2 instance in another region.

**Terraform Code:**

```hcl
# Define the AWS provider for multiple regions
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

# Fetch VPC based on tag in the us-east-1 region
data "aws_vpc" "existing_vpc" {
  provider = aws
  filter {
    name   = "tag:Name"
    values = ["my-production-vpc"]
  }
}

# Fetch subnet based on VPC in the us-east-1 region
data "aws_subnet" "existing_subnet" {
  provider = aws
  vpc_id   = data.aws_vpc.existing_vpc.id
}

# Fetch security group based on tag in the us-east-1 region
data "aws_security_group" "existing_sg" {
  provider = aws
  filter {
    name   = "group-name"
    values = ["allow-ssh-sg"]
  }
}

# Create an EC2 instance in us-west-2 using resources from us-east-1
resource "aws_instance" "my_instance" {
  provider         = aws.west
  ami              = "ami-0c55b159cbfafe1f0"
  instance_type    = "t2.micro"
  subnet_id        = data.aws_subnet.existing_subnet.id
  security_groups  = [data.aws_security_group.existing_sg.name]

  tags = {
    Name = "InstanceFromAnotherRegion"
  }
}
```

**Explanation:**
- The `provider` blocks define multiple regions (US East and US West).
- Data sources fetch resources (VPC, subnet, security group) from the US East region.
- An EC2 instance is created in the US West region using the fetched resources from US East.
