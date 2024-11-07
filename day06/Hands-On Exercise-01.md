#### **1. Create Multiple EC2 Instances with a Load Balancer**

In this exercise, you’ll deploy multiple EC2 instances and place them behind an Elastic Load Balancer (ELB) for scalability.

1. **Define Variables** in `variables.tf`:
    ```hcl
    variable "num_instances" {
      description = "Number of EC2 instances"
      default     = 2
    }

    variable "instance_type" {
      description = "EC2 instance type"
      default     = "t2.micro"
    }
    ```

2. **Update `main.tf` for Multiple Instances**:
    ```hcl
    resource "aws_instance" "app_server" {
      count         = var.num_instances
      ami           = var.ami_id
      instance_type = var.instance_type
      key_name      = aws_key_pair.my_key_pair.key_name
      security_groups = [aws_security_group.ec2_security_group.name]

      tags = {
        Name = "AppServer-${count.index}"
      }
    }
    ```

3. **Add a Load Balancer**:
    ```hcl
    resource "aws_lb" "app_lb" {
      name               = "app-load-balancer"
      internal           = false
      load_balancer_type = "application"
      security_groups    = [aws_security_group.ec2_security_group.id]
      subnets            = ["subnet-12345678"] # Replace with your VPC subnet

      tags = {
        Name = "AppLB"
      }
    }

    resource "aws_lb_target_group" "app_tg" {
      name     = "app-tg"
      port     = 80
      protocol = "HTTP"
      vpc_id   = var.vpc_id
    }

    resource "aws_lb_target_group_attachment" "app_targets" {
      count            = var.num_instances
      target_group_arn = aws_lb_target_group.app_tg.arn
      target_id        = aws_instance.app_server[count.index].id
      port             = 80
    }
    ```

4. **Output Load Balancer URL**:
    ```hcl
    output "load_balancer_dns" {
      value = aws_lb.app_lb.dns_name
    }
    ```

5. **Deploy Resources**:
    ```bash
    terraform init
    terraform apply -auto-approve
    ```

This exercise covers horizontal scaling using an ELB, which is useful knowledge for interviews about scaling architecture and application load balancing.
