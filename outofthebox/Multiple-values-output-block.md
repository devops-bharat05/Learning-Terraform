Display multiple values in a single `output` block in Terraform. There are a few ways to achieve this:

### 1. **Using a Map**
You can use a map to group multiple values together and return them in a single `output` block.

```hcl
output "instance_details" {
  value = {
    instance_id   = aws_instance.example.id
    public_ip     = aws_instance.example.public_ip
    private_ip    = aws_instance.example.private_ip
  }
}
```

### 2. **Using a List**
If the values are of the same type and order matters, you can use a list.

```hcl
output "instance_ips" {
  value = [aws_instance.example.public_ip, aws_instance.example.private_ip]
}
```

### 3. **Using a Multi-line String**
For better readability, you can use a multi-line string.

```hcl
output "instance_info" {
  value = <<EOT
  Instance ID: ${aws_instance.example.id}
  Public IP: ${aws_instance.example.public_ip}
  Private IP: ${aws_instance.example.private_ip}
  EOT
}
```

Each method depends on your use case, but using a **map** is the most structured and readable approach. 🚀
