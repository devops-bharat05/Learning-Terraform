#### **3. Use Data Sources to Dynamically Fetch AMI IDs**

Data sources allow Terraform to query existing resources. In this example, we’ll fetch the latest Amazon Linux 2 AMI.

1. **Define AMI Data Source**:
    ```hcl
    data "aws_ami" "latest_amazon_linux" {
      most_recent = true
      owners      = ["amazon"]

      filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
      }
    }
    ```

2. **Reference AMI Data Source in EC2 Instance**:
    ```hcl
    resource "aws_instance" "web_server" {
      ami           = data.aws_ami.latest_amazon_linux.id
      instance_type = var.instance_type
      key_name      = aws_key_pair.my_key_pair.key_name
      security_groups = [aws_security_group.ec2_security_group.name]

      tags = {
        Name = "WebServer"
      }
    }
    ```

3. **Deploy Resources**:
    ```bash
    terraform apply -auto-approve
    ```

This exercise helps you learn how to use Terraform data sources, a common interview topic when dealing with dynamic or frequently updated resources.
