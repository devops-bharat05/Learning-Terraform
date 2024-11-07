### **2. Fetching an Existing VPC by Name**

Now, let’s fetch an existing VPC by its name tag and create an EC2 instance in that VPC.

**Steps:**
1. Define the AWS provider.
2. Use the `aws_vpc` data source to fetch the VPC by name.
3. Use the VPC ID to launch an EC2 instance in that VPC.

**Terraform Code:**

```hcl
# Define the AWS provider
provider "aws" {
  region = "us-west-1"
}

# Fetch the existing VPC by its Name tag
data "aws_vpc" "existing_vpc" {
  filter {
    name   = "tag:Name"
    values = ["my-existing-vpc"]
  }
}

# Create an EC2 instance in the fetched VPC
resource "aws_instance" "my_instance" {
  ami               = "ami-0c55b159cbfafe1f0"
  instance_type     = "t2.micro"
  vpc_security_group_ids = [data.aws_vpc.existing_vpc.id]
  tags = {
    Name = "InstanceInExistingVPC"
  }
}
```

**Explanation:**
- The `aws_vpc` data source fetches the VPC with the name `my-existing-vpc`.
- The `aws_instance` resource creates an EC2 instance in the fetched VPC by using the `vpc_security_group_ids` and `ami` attributes.
