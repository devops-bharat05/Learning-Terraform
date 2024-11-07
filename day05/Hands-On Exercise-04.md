#### 4. **Working with `terraform state` Commands**

   **Objective**: Get hands-on experience with `terraform state` commands to manage resources directly in the state file.

   - **Commands**:
     - `terraform state list`
     - `terraform state show <resource>`
     - `terraform state mv <old-resource> <new-resource>`
     - `terraform state rm <resource>`

   **Steps**:
   - Use `terraform state list` to list resources.
   - Use `terraform state show aws_instance.example` to view the state of the instance.
   - Modify the instance’s name in `main.tf`:
     ```hcl
     # Changing Name tag
     resource "aws_instance" "example" {
       ami           = "ami-0c55b159cbfafe1f0"
       instance_type = "t2.micro"

       tags = {
         Name = "RenamedInstance"
       }
     }
     ```
   - Use `terraform state mv aws_instance.example aws_instance.renamed_instance` to update the state name.
   - Use `terraform state rm aws_instance.example` to remove the resource from the state file.


   - **Key Takeaways**:
     - Directly manipulating the state file for reorganization and troubleshooting.
     - Understanding state modification commands in complex Terraform environments.

   **Interview Points**: Describe how each `terraform state` command is used and scenarios where direct state manipulation is necessary.
