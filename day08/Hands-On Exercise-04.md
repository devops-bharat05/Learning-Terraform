### **4. Fetching an Existing Security Group**

In this exercise, we'll fetch an existing security group by name and use it to launch an EC2 instance.

**Steps:**
1. Define the AWS provider.
2. Use the `aws_security_group` data source to fetch the security group.
3. Create an EC2 instance using the fetched security group.

**Terraform Code:**

```hcl
# Define the AWS provider
provider "aws" {
  region = "us-west-1"
}

# Fetch an existing security group by its name
data "aws_security_group" "existing_sg" {
  filter {
    name   = "group-name"
    values = ["my-existing-sg"]
  }
}

# Create an EC2 instance using the existing security group
resource "aws_instance" "my_instance" {
  ami               = "ami-0c55b159cbfafe1f0"
  instance_type     = "t2.micro"
  security_groups   = [data.aws_security_group.existing_sg.name]
  tags = {
    Name = "InstanceWithExistingSG"
  }
}
```

**Explanation:**
- The `aws_security_group` data source fetches the security group named `my-existing-sg`.
- The `aws_instance` resource creates an EC2 instance using the fetched security group.
