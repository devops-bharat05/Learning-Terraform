# Terraform Basics:

This guide provides an introduction to Infrastructure as Code (IaC) and walks through setting up a development environment for Terraform. It includes an overview of Terraform’s CLI, commands, and basic syntax in HCL (HashiCorp Configuration Language).

## Table of Contents
- [Introduction to Infrastructure as Code (IaC)](#introduction-to-infrastructure-as-code-iac)
- [What is Terraform?](#what-is-terraform)
- [Installing Terraform](#installing-terraform)
- [Setting Up the Development Environment](#setting-up-the-development-environment)
- [Understanding the Terraform CLI](#understanding-the-terraform-cli)
- [Basic Terraform Commands](#basic-terraform-commands)
- [Terraform Syntax and Configuration Structure](#terraform-syntax-and-configuration-structure)
- [Next Steps](#next-steps)

---

## Introduction to Infrastructure as Code (IaC)

### What is IaC?
Infrastructure as Code (IaC) is a practice in DevOps and cloud computing that involves managing and provisioning computing resources through machine-readable definition files, rather than through physical hardware configuration or interactive configuration tools.

### Benefits of IaC
- **Consistency**: Ensures consistent setup across environments.
- **Automation**: Automates repetitive tasks, reducing manual errors.
- **Version Control**: Code changes can be tracked, and infrastructure can be rolled back to a previous state.
- **Scalability**: Easily scale resources up or down based on demand.

## What is Terraform?

Terraform is an open-source IaC tool developed by HashiCorp. It enables users to define and provision data center infrastructure using a declarative configuration language (HCL - HashiCorp Configuration Language). Terraform can be used across various cloud providers (AWS, Azure, GCP) and other infrastructure providers, making it highly versatile.

## Installing Terraform

Follow these steps to install Terraform on your local machine.

### Prerequisites
- **OS**: This guide covers installation on Windows, macOS, and Linux.
- **Package Managers**: Depending on your OS, you may use tools like Homebrew (macOS) or APT (Linux).

### Installation
1. **Download Terraform**:
   - Visit [Terraform’s official download page](https://www.terraform.io/downloads.html).
   - Select the version for your OS and download the zip file.
   
2. **Install Terraform**:
   - Unzip the downloaded file.
   - Move the executable to a directory within your system's PATH (e.g., `/usr/local/bin` on Linux/macOS).

3. **Verify Installation**:
   - Open a terminal and run:
     ```bash
     terraform -v
     ```
   - This command should output the installed Terraform version, confirming that it’s set up correctly.

## Setting Up the Development Environment

1. **Create a Project Directory**:
   - Open your terminal or command prompt.
   - Create a directory to store Terraform configurations:
     ```bash
     mkdir terraform-project
     cd terraform-project
     ```

2. **Create a Basic Terraform Configuration File**:
   - Inside the project directory, create a new file named `main.tf`. This file will contain Terraform code written in HCL.
   - Example `main.tf` content:
     ```hcl
     provider "aws" {
       region = "us-west-2"
     }

     resource "aws_instance" "example" {
       ami           = "ami-0c55b159cbfafe1f0"
       instance_type = "t2.micro"
     }

   - Note: You’ll replace this with more advanced configurations as you progress.

## Understanding the Terraform CLI

Terraform’s CLI is where you execute commands to interact with your infrastructure. Here are the key commands you’ll use:

1. **`terraform init`**:
   - Initializes a Terraform working directory.
   - Downloads required provider plugins and modules.

2. **`terraform plan`**:
   - Creates an execution plan, showing what actions Terraform will take to reach the desired state.
   - Helps you review any changes before applying them.

3. **`terraform apply`**:
   - Executes the actions defined in the plan to create, update, or delete resources.
   - Example:
     ```bash
     terraform apply
     ```

4. **`terraform destroy`**:
   - Destroys all resources managed by the Terraform configuration in the current directory.
   - Use with caution, as it will remove resources from your infrastructure.

## Basic Terraform Commands

### Initialize Terraform
```bash
terraform init
```
This command sets up the working directory by downloading necessary provider plugins.

### Create a Plan
```bash
terraform plan
```
This command shows the changes that will be made by Terraform if you apply the configuration.

### Apply Changes
```bash
terraform apply
```
This command applies the configuration and provisions the infrastructure.

### Destroy Resources
```bash
terraform destroy
```
This command tears down and removes all resources created by the configuration.

## Terraform Syntax and Configuration Structure

### HashiCorp Configuration Language (HCL)
Terraform uses HCL, a human-readable language designed for Terraform configurations.

### Basic Structure
A basic Terraform file has the following elements:

1. **Providers**: Define the cloud provider (e.g., AWS, Azure, GCP).
   ```hcl
   provider "aws" {
     region = "us-west-2"
   }
   ```

2. **Resources**: Specify the components (e.g., VMs, storage) to create or manage.
   ```hcl
   resource "aws_instance" "example" {
     ami           = "ami-0c55b159cbfafe1f0"
     instance_type = "t2.micro"
   }
   ```

3. **Variables** (optional): Allow you to define inputs for your configuration, making it reusable.
   ```hcl
   variable "instance_type" {
     default = "t2.micro"
   }
   ```

4. **Outputs** (optional): Expose information about your infrastructure after it’s created.
   ```hcl
   output "instance_ip" {
     value = aws_instance.example.public_ip
   }
   ```

## Next Steps

You’ve completed the basics! Continue to the next days for deeper exploration of:
- Variables, Outputs, and State Management
- Managing multiple environments
- Modules and advanced configurations

For further reading:
- [Terraform Documentation](https://www.terraform.io/docs)
- [HashiCorp Learn - Terraform](https://learn.hashicorp.com/terraform)
