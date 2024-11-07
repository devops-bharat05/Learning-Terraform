### **6. Fetching EC2 Instance Metadata and Updating Tags**

In this exercise, you will:
- Fetch metadata for an existing EC2 instance.
- Update the tags of the instance based on fetched data (using dynamic values).

**Steps:**
1. Define the AWS provider.
2. Use the `aws_instance` data source to fetch an existing EC2 instance by ID.
3. Use dynamic values from the fetched data to modify the tags of the instance.

**Terraform Code:**

```hcl
# Define the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Fetch metadata for an existing EC2 instance
data "aws_instance" "existing_instance" {
  instance_id = "i-0abcd1234efgh5678"
}

# Update the tags of the existing EC2 instance dynamically based on metadata
resource "aws_instance" "updated_instance" {
  instance_id = data.aws_instance.existing_instance.id

  tags = {
    Name        = "UpdatedInstance"
    InstanceID  = data.aws_instance.existing_instance.id
    IP          = data.aws_instance.existing_instance.public_ip
    LaunchTime  = data.aws_instance.existing_instance.launch_time
  }
}
```

**Explanation:**
- The `aws_instance` data source fetches metadata for the existing EC2 instance using its `instance_id`.
- The `aws_instance` resource uses dynamic attributes (like the `public_ip` and `launch_time`) from the fetched instance to update its tags.
