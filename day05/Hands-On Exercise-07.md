#### 7. **State Migration from Local to Remote**

   **Objective**: Practice migrating the Terraform state from a local backend to a remote backend (S3, GCS, or Terraform Cloud).

   - **Steps**:
     1. Initialize a local backend by running `terraform init` and applying a configuration.
     2. Configure an S3 backend as described earlier.
     3. Run `terraform init` again to trigger a migration prompt. Confirm the migration.
     4. Check the S3 bucket to ensure the state file has moved.

    ```hcl
    # backend.tf (new file)
       terraform {
         backend "s3" {
           bucket = "migration-bucket"
           key    = "state/terraform.tfstate"
           region = "us-west-2"
         }
       }
    ```
   **Commands**:
   ```bash
   terraform init
   ```
   - Follow the prompt to confirm the migration from local to S3.


   - **Key Takeaways**:
     - Migrating state files between backends safely.
     - Troubleshooting potential issues in state migrations.

   **Interview Points**: Explain the migration process, potential pitfalls, and reasons for migrating state to a remote backend.
