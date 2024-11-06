## 📘 Day 4: Variables and Outputs in Terraform

On Day 4, we’ll cover **variables** and **outputs** in Terraform. These features allow you to create more flexible and reusable infrastructure configurations. By using variables, you can parameterize your configurations, and with outputs, you can access key information from your resources once they’re created.

---

### 📌 Objectives

1. **Understand Terraform Variables**: Learn how to define and use variables for dynamic configuration.
2. **Learn about Outputs**: Discover how to use outputs to capture and display resource values for further use.

---

## 🎛️ Variables in Terraform

### What are Variables?
Variables in Terraform allow you to define reusable, dynamic configurations. Instead of hard-coding values, you can define variables that store different types of data, making your code more flexible and reusable.

### Types of Variables

1. **String**: A single string value, such as a region or instance type.
2. **Number**: A numeric value, like instance count or size.
3. **Bool**: A boolean value for true/false settings.
4. **List**: A list of values, such as a list of availability zones.
5. **Map**: A set of key-value pairs, useful for defining multiple parameters at once.

### Defining Variables

Variables are defined using the `variable` block. Here’s the syntax:

```hcl
variable "variable_name" {
  type        = <type>       # Optional; defines the data type
  default     = <default>    # Optional; provides a default value
  description = <description> # Optional; adds a description for readability
}
```

### Example Variables

#### Simple Variable Example
Define a variable for the AWS region:

```hcl
variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-west-1"
}
```

#### List Variable Example
Define a list of availability zones:

```hcl
variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1b"]
}
```

#### Map Variable Example
Define a map for instance sizes:

```hcl
variable "instance_types" {
  description = "Map of instance types based on environment"
  type        = map(string)
  default     = {
    dev  = "t2.micro"
    prod = "t2.large"
  }
}
```

### Using Variables in Resources

Once defined, variables can be used in resource blocks with the `var.` prefix:

```hcl
provider "aws" {
  region = var.region
}

resource "aws_instance" "web" {
  ami           = "ami-123456"
  instance_type = var.instance_types["dev"]  # Use the instance type for dev environment
  tags = {
    Name = "WebInstance"
  }
}
```

### Setting Variable Values

Variables can be set in multiple ways:
1. **Default Value**: Defined within the `variable` block.
2. **Terraform CLI**: Use the `-var` flag when running `terraform apply`.
   ```bash
   terraform apply -var="region=us-west-2"
   ```
3. **.tfvars File**: Store variable values in a `terraform.tfvars` file for organized and reusable configurations.

Example `terraform.tfvars`:
```hcl
region = "us-west-1"
availability_zones = ["us-west-1a", "us-west-1b"]
```

---

## 📤 Outputs in Terraform

### What are Outputs?
Outputs in Terraform allow you to extract values from your configuration and make them accessible after the infrastructure is provisioned. They are helpful for capturing resource attributes like IP addresses or IDs, which may be needed in other configurations or for logging.

### Defining Outputs

Outputs are defined using the `output` block. Each output can have a description and can refer to specific resource attributes.

```hcl
output "output_name" {
  description = <description>  # Optional; adds clarity to the output
  value       = <expression>   # The actual value to output
}
```

### Example Outputs

#### Output EC2 Instance Public IP
Capture the public IP of an EC2 instance:

```hcl
output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}
```

#### Output VPC ID
Capture the VPC ID for reference in other configurations:

```hcl
output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.main.id
}
```

#### Conditionally Sensitive Outputs

If some output values contain sensitive information, you can mark them as sensitive using the `sensitive = true` attribute:

```hcl
output "db_password" {
  description = "The database password"
  value       = aws_rds_instance.example.password
  sensitive   = true
}
```

### Using Outputs

After running `terraform apply`, outputs are displayed in the CLI. You can also use `terraform output` to view specific outputs at any time:

```bash
terraform output instance_public_ip
```

### Outputting as JSON

If you need the outputs in JSON format (for integrating with other tools), you can use:

```bash
terraform output -json
```

---

## 🌟 Practical Example: Using Variables and Outputs Together

Let’s combine variables and outputs for a complete configuration.

```hcl
# Define a variable for the instance type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# Define a variable for the AWS region
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

# Set the AWS provider with the region variable
provider "aws" {
  region = var.region
}

# Create an EC2 instance using the instance_type variable
resource "aws_instance" "example" {
  ami           = "ami-123456"
  instance_type = var.instance_type

  tags = {
    Name = "ExampleInstance"
  }
}

# Output the public IP of the created EC2 instance
output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.example.public_ip
}
```

### Running This Configuration

1. **Define your variables** in a `terraform.tfvars` file if you want to override the defaults.
2. Run `terraform init` to initialize the provider plugins.
3. Run `terraform apply` to provision the resources.
4. Check the output to see the EC2 instance's public IP.

---

## ✅ Summary

Today, you learned about:
- **Terraform Variables**: How to define, configure, and use variables to create dynamic infrastructure configurations.
- **Terraform Outputs**: How to define outputs to capture and share resource values after creation.

By using variables and outputs, you’re now able to write reusable and modular Terraform code, which is essential for scaling infrastructure management. These skills allow you to build flexible, well-parameterized configurations that are ready for use across multiple environments.
