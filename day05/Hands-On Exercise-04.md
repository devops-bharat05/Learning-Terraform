#### 3. **Working with `terraform state` Commands**

   **Objective**: Get hands-on experience with `terraform state` commands to manage resources directly in the state file.

   - **Commands**:
     - `terraform state list`
     - `terraform state show <resource>`
     - `terraform state mv <old-resource> <new-resource>`
     - `terraform state rm <resource>`

   - **Steps**:
     1. Use `terraform state list` to display all resources in the state.
     2. Use `terraform state show <resource>` to examine specific resource details.
     3. Rename an existing resource in your configuration and use `terraform state mv` to apply the change in the state without re-creating the resource.
     4. Remove a resource from the state using `terraform state rm` (this won’t delete the actual resource, only removes tracking).

   - **Key Takeaways**:
     - Directly manipulating the state file for reorganization and troubleshooting.
     - Understanding state modification commands in complex Terraform environments.

   **Interview Points**: Describe how each `terraform state` command is used and scenarios where direct state manipulation is necessary.
