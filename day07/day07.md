### **Day 7: Review and Practice with Multi-Cloud Deployments**

Today is a day for reviewing and reinforcing what you've learned in Terraform this week. Additionally, you’ll get hands-on experience deploying simple resources across multiple cloud providers, like AWS and Azure, to gain familiarity with Terraform’s multi-cloud capabilities.

---

## 🌟 **Goals for the Day**
1. **Review**: Summarize key concepts and commands from Days 1-6.
2. **Practice**: Deploy resources on different cloud providers.
3. **Consolidate**: Solidify your understanding of cross-provider syntax and basic infrastructure components.

---

## 📝 **Review Summary**

### **Key Concepts from Week 1**

1. **Infrastructure as Code (IaC)**:
   - **Benefits**: Reusability, automation, version control, and reduced manual errors.
   - **Terraform Setup**: Initializing the environment, setting up providers, defining resources.

2. **Providers**:
   - Configure providers like `aws`, `azure`, or `google` to deploy resources on various platforms.
   - Syntax: `provider "<cloud_provider>" { ... }`.

3. **Variables and Outputs**:
   - **Variables** for parameterizing configurations.
   - **Outputs** to expose information after deployment, like instance IPs.

4. **State Files**:
   - Purpose: Tracks resources to detect changes and avoid drift.
   - **Backend Configuration**: Local vs. remote (e.g., S3, Azure Blob).

5. **Resources and Basic Configurations**:
   - Basic resources like VPC, EC2, Security Groups.
   - Security group rules, tags, and routing configurations.

---

## 🛠️ **Hands-On Practice: Multi-Cloud Deployments**

### **Practice 1: AWS EC2 Instance with Security Group**

Let’s start by deploying a simple EC2 instance in AWS with a Security Group using Terraform.

#### 1. **Create `main.tf`**:
   ```hcl
   provider "aws" {
     region = "us-west-2"
   }

   resource "aws_instance" "web_server" {
     ami           = "ami-12345678"  # Replace with an actual Amazon Linux AMI ID
     instance_type = "t2.micro"

     tags = {
       Name = "web-server"
     }
   }

   resource "aws_security_group" "web_sg" {
     name        = "web_sg"
     description = "Allow HTTP and SSH"
     vpc_id      = "vpc-12345"  # Replace with your VPC ID

     ingress {
       from_port   = 22
       to_port     = 22
       protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
     }

     ingress {
       from_port   = 80
       to_port     = 80
       protocol    = "tcp"
       cidr_blocks = ["0.0.0.0/0"]
     }

     egress {
       from_port   = 0
       to_port     = 0
       protocol    = "-1"
       cidr_blocks = ["0.0.0.0/0"]
     }

     tags = {
       Name = "web-sg"
     }
   }
   ```

#### 2. **Deploy**:
   ```bash
   terraform init
   terraform apply -auto-approve
   ```

### **Practice 2: Azure Virtual Machine with Network Security Group**

Now, deploy a Virtual Machine in Azure with a Network Security Group (NSG).

#### 1. **Define Provider and Variables in `main.tf`**:
   ```hcl
   provider "azurerm" {
     features = {}
   }

   resource "azurerm_resource_group" "rg" {
     name     = "myResourceGroup"
     location = "East US"
   }

   resource "azurerm_virtual_network" "vnet" {
     name                = "myVnet"
     address_space       = ["10.0.0.0/16"]
     location            = azurerm_resource_group.rg.location
     resource_group_name = azurerm_resource_group.rg.name
   }

   resource "azurerm_subnet" "subnet" {
     name                 = "mySubnet"
     resource_group_name  = azurerm_resource_group.rg.name
     virtual_network_name = azurerm_virtual_network.vnet.name
     address_prefixes     = ["10.0.1.0/24"]
   }

   resource "azurerm_network_security_group" "nsg" {
     name                = "myNetworkSecurityGroup"
     location            = azurerm_resource_group.rg.location
     resource_group_name = azurerm_resource_group.rg.name

     security_rule {
       name                       = "Allow-HTTP"
       priority                   = 100
       direction                  = "Inbound"
       access                     = "Allow"
       protocol                   = "Tcp"
       source_port_range          = "*"
       destination_port_range     = "80"
       source_address_prefix      = "*"
       destination_address_prefix = "*"
     }
   }

   resource "azurerm_network_interface" "nic" {
     name                = "myNic"
     location            = azurerm_resource_group.rg.location
     resource_group_name = azurerm_resource_group.rg.name
     ip_configuration {
       name                          = "internal"
       subnet_id                     = azurerm_subnet.subnet.id
       private_ip_address_allocation = "Dynamic"
     }
   }

   resource "azurerm_linux_virtual_machine" "vm" {
     name                  = "myVM"
     resource_group_name   = azurerm_resource_group.rg.name
     location              = azurerm_resource_group.rg.location
     size                  = "Standard_B1s"
     admin_username        = "azureuser"
     network_interface_ids = [azurerm_network_interface.nic.id]
     admin_ssh_key {
       username   = "azureuser"
       public_key = file("~/.ssh/id_rsa.pub")  # Path to your public key
     }

     os_disk {
       caching              = "ReadWrite"
       storage_account_type = "Standard_LRS"
     }

     source_image_reference {
       publisher = "Canonical"
       offer     = "UbuntuServer"
       sku       = "18.04-LTS"
       version   = "latest"
     }
   }
   ```

#### 2. **Deploy to Azure**:
   ```bash
   terraform init
   terraform apply -auto-approve
   ```

---

### **Practice 3: Deploying to GCP (Google Cloud Platform)**

For an additional cloud platform, try deploying a simple Google Compute Engine instance in GCP.

#### 1. **Define Provider and Configuration in `main.tf`**:
   ```hcl
   provider "google" {
     credentials = file("path/to/credentials.json")  # Replace with your GCP credentials file
     project     = "my-project-id"                   # Replace with your project ID
     region      = "us-central1"
   }

   resource "google_compute_network" "vpc_network" {
     name = "terraform-vpc"
   }

   resource "google_compute_instance" "vm_instance" {
     name         = "terraform-instance"
     machine_type = "f1-micro"
     zone         = "us-central1-a"

     boot_disk {
       initialize_params {
         image = "debian-cloud/debian-10"
       }
     }

     network_interface {
       network = google_compute_network.vpc_network.name
       access_config {}
     }

     tags = ["web"]
   }
   ```

#### 2. **Deploy to GCP**:
   ```bash
   terraform init
   terraform apply -auto-approve
   ```

---

## 🔍 **Interview Tips: Multi-Cloud Experience**

- **Understand Provider Syntax**: Explain the provider blocks for different platforms and the syntax for common resources like instances and security groups.
- **State File Management**: Mention strategies for multi-cloud state file management, like using a single remote backend.
- **Modularity**: Discuss how to create reusable modules for resources common across providers (e.g., virtual machines, networks).

---

By following these exercises, you’ll get a thorough understanding of deploying resources across multiple providers with Terraform. Practicing these examples will be excellent preparation for both interviews and real-world multi-cloud infrastructure management.
