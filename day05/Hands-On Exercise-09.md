#### 9. **Understanding `terraform refresh` and Its Impact on State Files**

   **Objective**: Explore how the `terraform refresh` command updates the state file and synchronizes it with actual infrastructure.

   - **Steps**:
     1. Apply a Terraform configuration to create a resource (e.g., EC2 instance).
     2. Manually change a resource attribute directly in the AWS Console (e.g., update the EC2 instance’s tag).
     3. Run `terraform refresh` and check the state file to observe the updated state reflecting the manual change.

   - **Key Takeaways**:
     - Using `terraform refresh` to bring state files in sync with real-world infrastructure.
     - Recognizing the limitations of refresh when resources are modified outside Terraform.

   **Interview Points**: Explain when and why you would use `terraform refresh`, and the risks of relying on it in automated workflows.
