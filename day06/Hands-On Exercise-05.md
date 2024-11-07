#### **4. Implement an Auto-Scaling Group**

Auto-scaling groups (ASG) ensure high availability by automatically adjusting the number of EC2 instances based on demand.

1. **Create Launch Template**:
    ```hcl
    resource "aws_launch_template" "web_server_template" {
      name = "web-server-template"
      image_id = data.aws_ami.latest_amazon_linux.id
      instance_type = var.instance_type
    }
    ```

2. **Define Auto-Scaling Group**:
    ```hcl
    resource "aws_autoscaling_group" "web_asg" {
      desired_capacity     = 2
      max_size             = 5
      min_size             = 1
      vpc_zone_identifier  = ["subnet-12345678"] # Replace with your subnet
      launch_template {
        id      = aws_launch_template.web_server_template.id
        version = "$Latest"
      }

      tags = [
        {
          key                 = "Name"
          value               = "AutoScalingWebServer"
          propagate_at_launch = true
        }
      ]
    }
    ```

3. **Apply Configuration**:
    ```bash
    terraform apply -auto-approve
    ```

This hands-on exercise covers configuring an ASG, which is key for high availability and is a frequently asked question in interviews.
