### 🛠️ Hands-On Exercise 2: Configuring Remote State with S3

1. **Objective**: Configure an **S3 backend** to store state files remotely and add **state locking** using DynamoDB.
2. **Instructions**:
   - Set up an S3 bucket and DynamoDB table in AWS.
   - Configure the Terraform backend to use S3 with DynamoDB for state locking.

3. **Code**:

   ```hcl
   terraform {
     backend "s3" {
       bucket         = "my-terraform-state-bucket"
       key            = "project-name/terraform.tfstate"
       region         = "us-west-2"
       dynamodb_table = "terraform-state-lock"
       encrypt        = true
     }
   }
   ```

4. **Run**:
   - Run `terraform init` to initialize the remote backend.
   - Check the S3 bucket to confirm the state file is stored there.
