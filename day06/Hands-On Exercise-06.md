#### **5. Use Terraform Modules to Organize Resources**

Modules allow for reusability and cleaner code, which is crucial for production-level infrastructure. In this exercise, you’ll create a module for an EC2 instance.

1. **Create Module Structure**:
    - Create a `modules/instance` folder with `main.tf`, `variables.tf`, and `outputs.tf` files.

2. **Define Module Variables** (`modules/instance/variables.tf`):
    ```hcl
    variable "ami" {}
    variable "instance_type" {}
    variable "security_group_id" {}
    variable "key_name" {}
    ```

3. **Define EC2 Instance** (`modules/instance/main.tf`):
    ```hcl
    resource "aws_instance" "module_instance" {
      ami           = var.ami
      instance_type = var.instance_type
      key_name      = var.key_name
      security_groups = [var.security_group_id]
    }
    ```

4. **Call the Module**:
    ```hcl
    module "web_server" {
      source           = "./modules/instance"
      ami              = data.aws_ami.latest_amazon_linux.id
      instance_type    = var.instance_type
      security_group_id = aws_security_group.ec2_security_group.id
      key_name         = aws_key_pair.my_key_pair.key_name
    }
    ```

5. **Deploy Module**:
    ```bash
    terraform apply -auto-approve
    ```

This exercise teaches how to use Terraform modules, an important skill for managing large projects and a common interview topic related to modular infrastructure.
