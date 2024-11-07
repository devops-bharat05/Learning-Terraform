#### 5. **Splitting State by Environments Using Workspaces**

   **Objective**: Set up Terraform workspaces to manage separate state files for different environments (e.g., `dev`, `staging`, `prod`).

   - **Steps**:
     1. Initialize Terraform and create a basic resource (like an S3 bucket).
     2. Use `terraform workspace new dev` and `terraform workspace new prod` to create separate environments.
     3. Deploy resources in each workspace using `terraform apply`.
     4. Observe the separate state files created for each workspace, and confirm isolation by making changes in one workspace without affecting the other.
  - **Commands**:
   ```bash
   terraform workspace new dev
   terraform workspace new prod
   terraform workspace list
   terraform apply -auto-approve
   ```
   - Change configurations within each workspace, and observe how each workspace has isolated state files.

   - **Key Takeaways**:
     - Using workspaces to separate environment configurations.
     - Avoiding resource overlap and conflicts by using isolated state files.

   **Interview Points**: Explain the purpose of workspaces, their limitations, and how they differ from manually splitting configurations by environment.
