### Day 6: Basic Configuration - Creating and Configuring AWS EC2 Instances with Terraform

On Day 6, you will set up and configure an AWS EC2 instance with Terraform. This hands-on exercise covers defining a basic infrastructure that includes an EC2 instance, a security group, and a key pair. By the end of this day, you’ll be familiar with provisioning and configuring basic AWS resources in Terraform.

---

### 📝 Overview

**Objectives**:
1. **Create an EC2 Instance**: Deploy a simple EC2 instance on AWS.
2. **Configure Security Groups**: Set up security rules to control inbound and outbound traffic.
3. **Define Key Pairs**: Generate or use an existing SSH key pair to securely access the instance.

### 🌐 Prerequisites
- **AWS IAM Permissions**: Ensure your IAM role has permissions to create EC2 instances, security groups, and key pairs.
- **AWS CLI & Terraform Installed**: Have Terraform and the AWS CLI configured with valid credentials.

---

### 🚀 Hands-On Exercises

#### 1. **Initialize Terraform Project**

Create a project folder for Day 6 exercises, and in it, create `main.tf` and `variables.tf` files.

**Project Structure**:
```plaintext
aws_ec2_example/
│
├── main.tf          # Main configuration for EC2 setup
├── variables.tf     # Variable definitions for dynamic configuration
└── terraform.tfvars # Optional, values for variables
```

---

#### 2. **Define Variables in `variables.tf`**

Using variables makes it easier to change values like region, instance type, and AMI without editing the code each time.

```hcl
# variables.tf
variable "region" {
  description = "The AWS region to deploy resources."
  default     = "us-west-2"
}

variable "instance_type" {
  description = "The type of EC2 instance to launch."
  default     = "t2.micro"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (for us-west-2)
}

variable "key_name" {
  description = "The key pair name for SSH access to EC2 instance."
  default     = "my-ec2-key"
}

variable "vpc_id" {
  description = "The VPC ID to deploy resources in. (Optional)"
  type        = string
  default     = ""
}
```

---

#### 3. **Create a Security Group and Key Pair in `main.tf`**

Configure a security group with inbound rules to allow SSH and HTTP access.

```hcl
# main.tf

provider "aws" {
  region = var.region
}

# Key Pair for SSH Access
resource "aws_key_pair" "my_key_pair" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub") # Use your local public SSH key path
}

# Security Group to Allow SSH and HTTP
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2-security-group"
  description = "Allow SSH and HTTP inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2 Security Group"
  }
}
```

---

#### 4. **Define the EC2 Instance**

Define the EC2 instance to use the AMI, instance type, key pair, and security group.

```hcl
# main.tf continued

resource "aws_instance" "my_ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.my_key_pair.key_name
  security_groups = [aws_security_group.ec2_security_group.name]

  tags = {
    Name = "MyTerraformEC2"
  }
}
```

---

#### 5. **Initialize and Deploy Resources**

Now, initialize the project, review, and apply the configuration.

```bash
terraform init           # Initialize Terraform
terraform plan           # Review resources to be created
terraform apply -auto-approve  # Deploy resources
```

---

### 🎯 Validation and Testing

1. **Verify EC2 Instance**:
   - Go to the **EC2 Dashboard** in AWS.
   - Locate the newly created instance and confirm it’s running.

2. **SSH into the Instance**:
   - Retrieve the public IP of the EC2 instance.
   - SSH into the instance using your private key.
   ```bash
   ssh -i ~/.ssh/id_rsa ec2-user@<public-ip-address>
   ```

3. **Test Security Group**:
   - Check that HTTP access on port 80 is open by running `curl localhost` inside the instance.
   - Confirm that SSH access is limited based on your security group configuration.

---

### 🛠️ Clean Up

To avoid unnecessary charges, destroy the resources when done.

```bash
terraform destroy -auto-approve
```

---

### 📚 Key Takeaways

- **AWS Provider Configuration**: Understanding provider configuration is essential in Terraform, as it connects to the AWS environment.
- **Security Groups**: By defining security groups in Terraform, you control access to instances programmatically.
- **Key Pairs**: Terraform can manage key pairs for secure access, making infrastructure fully managed by code.

---

This exercise gives a complete walkthrough to provision, configure, and access an EC2 instance on AWS using Terraform, covering foundational AWS resource configuration that will be invaluable in real-world scenarios and interviews.
