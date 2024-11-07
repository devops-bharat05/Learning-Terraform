#### 8. **State File Backup and Recovery**

   **Objective**: Simulate state file corruption and recover using a backup to understand disaster recovery steps.

   - **Steps**:
     1. Take a backup of the current `terraform.tfstate` file.
     2. Simulate a failure by corrupting the `terraform.tfstate` file manually.
     3. Try running `terraform apply` to see the errors caused by a corrupted state file.
     4. Replace the corrupted file with the backup and re-run `terraform apply` to verify recovery.
        
   - **Commands**:
   ```bash
   cp terraform.tfstate terraform.tfstate.bak
   ```

   - Open `terraform.tfstate` and delete some content to simulate corruption.
   - Run `terraform apply` to see the error due to corruption.
   - Restore the backup:
     ```bash
     cp terraform.tfstate.bak terraform.tfstate
     terraform apply
     ```

   - Verify the state recovery.

   - **Key Takeaways**:
     - Understanding the importance of regular state backups.
     - Familiarity with disaster recovery steps for critical infrastructure.

   **Interview Points**: Discuss state file backup strategies and recovery steps, especially in critical production environments.
