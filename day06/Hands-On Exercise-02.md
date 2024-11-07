#### **2. Store Terraform State in an S3 Bucket with Remote Backend Configuration**

A remote backend is essential for collaborative projects, so let’s move the Terraform state to an S3 bucket.

1. **Create an S3 Bucket in AWS**:
    ```hcl
    resource "aws_s3_bucket" "terraform_state" {
      bucket = "my-terraform-state-bucket-unique"
      acl    = "private"
      versioning {
        enabled = true
      }
    }
    ```

2. **Configure Backend in `main.tf`**:
    ```hcl
    terraform {
      backend "s3" {
        bucket = "my-terraform-state-bucket-unique"
        key    = "terraform/state"
        region = "us-west-2"
      }
    }
    ```

3. **Initialize Backend**:
    ```bash
    terraform init -reconfigure
    ```

4. **Verify Remote State**:
   - Check the S3 bucket for the state file, and confirm it’s stored and versioned in S3.

This exercise demonstrates knowledge of Terraform backend setup, a vital skill for collaborative workflows.
