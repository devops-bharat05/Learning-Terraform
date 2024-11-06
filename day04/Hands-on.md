🛠️ Hands-On Exercise 1: Using Complex Variables

1. Objective: Use a map and list variable to define multiple configuration values.


2. Goal: Create two EC2 instances with different configurations (one for dev and one for prod) using a map variable.


3. Instructions:

Define a map variable to hold different instance types for development and production.

Use the list variable to specify two availability zones.

Use these variables to create two EC2 instances, one for each environment.



4. Code:

variable "instance_types" {
  description = "Instance types for different environments"
  type        = map(string)
  default     = {
    dev  = "t2.micro"
    prod = "t2.medium"
  }
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1b"]
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "dev_instance" {
  ami           = "ami-123456"
  instance_type = var.instance_types["dev"]
  availability_zone = var.availability_zones[0]
  tags = {
    Name = "DevInstance"
  }
}

resource "aws_instance" "prod_instance" {
  ami           = "ami-123456"
  instance_type = var.instance_types["prod"]
  availability_zone = var.availability_zones[1]
  tags = {
    Name = "ProdInstance"
  }
}


5. Run:

Initialize Terraform with terraform init.

Apply the configuration with terraform apply.

Verify that two instances were created with the specified configurations.





---

🛠️ Hands-On Exercise 2: Sensitive Variables and Outputs

1. Objective: Use sensitive variables for secure data and configure sensitive outputs.


2. Goal: Create an RDS database instance and set the password as a sensitive variable. Output the connection endpoint but mark it as sensitive.


3. Instructions:

Define a sensitive variable for the database password.

Use this variable in the RDS resource configuration.

Create an output for the database endpoint, and mark it as sensitive.



4. Code:

variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
  sensitive   = true
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_db_instance" "example" {
  allocated_storage    = 20
  engine               = "mysql"
  instance_class       = "db.t2.micro"
  name                 = "exampledb"
  username             = "admin"
  password             = var.db_password
  skip_final_snapshot  = true
}

output "db_endpoint" {
  description = "The connection endpoint for the RDS instance"
  value       = aws_db_instance.example.endpoint
  sensitive   = true
}


5. Run:

Run terraform apply, and provide a value for the db_password variable when prompted.

After the resources are created, use terraform output to display the outputs.

Notice that the db_endpoint output is masked due to the sensitive setting.





---

🛠️ Hands-On Exercise 3: Dynamic Resource Count with Variables

1. Objective: Use a number variable to dynamically control the count of a resource.


2. Goal: Create multiple EC2 instances with a variable that allows you to specify the desired instance count.


3. Instructions:

Define a count variable to control how many EC2 instances are created.

Use this variable in the aws_instance resource’s count argument.



4. Code:

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = "ami-123456"
  instance_type = "t2.micro"
  tags = {
    Name = "Instance-${count.index + 1}"
  }
}

output "instance_ids" {
  description = "List of IDs for created EC2 instances"
  value       = [for instance in aws_instance.example : instance.id]
}


5. Run:

Run terraform apply to create the default number of instances.

To create more instances, override the default by using -var="instance_count=4" when applying the configuration.

Verify the number of instances created in the AWS console.





---

🛠️ Hands-On Exercise 4: Organizing Variables and Outputs with .tfvars Files and Modules

1. Objective: Use a .tfvars file for organized variable values and create a reusable module for creating EC2 instances.


2. Goal: Modularize the configuration and use .tfvars for variable inputs. Create an EC2 instance module that can be reused in other configurations.


3. Instructions:

Move the EC2 instance configuration into a modules/instance directory.

Create a .tfvars file to define variable values for a specific environment.

Import the module in the main configuration.



4. Code:

Module Configuration (modules/instance/main.tf):

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
  default     = "ModuleInstance"
}

resource "aws_instance" "module_instance" {
  ami           = "ami-123456"
  instance_type = var.instance_type
  tags = {
    Name = var.instance_name
  }
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.module_instance.id
}

Main Configuration (main.tf):

provider "aws" {
  region = "us-west-1"
}

module "dev_instance" {
  source        = "./modules/instance"
  instance_type = "t2.small"
  instance_name = "DevInstance"
}

Variable File (dev.tfvars):

instance_type = "t2.small"
instance_name = "DevEnvironmentInstance"


5. Run:

Run terraform apply -var-file="dev.tfvars" to apply the configuration with the values defined in dev.tfvars.

Verify that the instance is created with the specified type and name from the .tfvars file.





---

🛠️ Hands-On Exercise 5: Nested Outputs with Complex Data Types

1. Objective: Use complex data structures (lists and maps) in outputs to return structured data.


2. Goal: Create a configuration that outputs multiple details about a resource in a structured format, like instance ID, type, and availability zone.


3. Instructions:

Define a resource with multiple attributes.

Create an output that returns these details in a map structure.



4. Code:

provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = "t2.micro"
  tags = {
    Name = "StructuredOutputInstance"
  }
}

output "instance_details" {
  description = "Detailed information of the instance"
  value = {
    instance_id         = aws_instance.example.id
    instance_type       = aws_instance.example.instance_type
    availability_zone   = aws_instance.example.availability_zone
  }
}


5. Run:

Run terraform apply to provision the instance.

Use terraform output instance_details to view the structured data, showing details like instance ID, type, and availability zone.





---

These exercises will help solidify your knowledge of Terraform’s variables and outputs by exploring practical scenarios.

