### **2. Using Data Sources to Fetch an ELB and Register Targets Dynamically**

In this scenario, you'll:
- Fetch an existing **Elastic Load Balancer (ELB)**.
- Dynamically register EC2 instances as targets for the ELB.

**Steps:**
1. Define the AWS provider.
2. Use the `aws_lb` data source to fetch the existing Application Load Balancer (ALB).
3. Use the `aws_lb_target_group` and `aws_lb_target_group_attachment` data sources to register EC2 instances.

**Terraform Code:**

```hcl
# Define the AWS provider
provider "aws" {
  region = "us-west-1"
}

# Fetch the existing Application Load Balancer (ALB) by name
data "aws_lb" "existing_alb" {
  name = "my-alb"
}

# Fetch the existing Target Group for the ALB
data "aws_lb_target_group" "existing_target_group" {
  arn = data.aws_lb.existing_alb.arn
}

# Fetch all EC2 instances with the tag "web-server"
data "aws_instances" "web_servers" {
  filter {
    name   = "tag:Role"
    values = ["web-server"]
  }
}

# Register EC2 instances to the target group dynamically
resource "aws_lb_target_group_attachment" "web_server_attachment" {
  for_each = toset(data.aws_instances.web_servers.ids)

  target_group_arn = data.aws_lb_target_group.existing_target_group.arn
  target_id        = each.key
  port             = 80
}
```

**Explanation:**
- The `aws_lb` data source fetches the Application Load Balancer by name.
- The `aws_lb_target_group` data source fetches the associated target group for the ALB.
- The `aws_instances` data source fetches EC2 instances that are tagged as `"Role" = "web-server"`.
- The `aws_lb_target_group_attachment` resource registers the instances dynamically to the target group.
