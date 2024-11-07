### How can I apply the Terraform configuration from a specific file, such as data-source.tf, without applying the resources defined in the main.tf file when they are in same workspace/dir?

If you have two separate files, `main.tf` and `data-source.tf`, and you want to apply the Terraform configuration in `data-source.tf` without touching `main.tf`, you can use a specific approach, but there's no direct flag to apply only one `.tf` file. However, you can achieve this by **targeting resources defined in `data-source.tf`** and **using a workaround** to isolate the resources in that file.

### Here’s how you can do it:

#### 1. **Use `-target` Option to Apply Only Resources from `data-source.tf`:**

You can use the `-target` flag to specify the resources defined in `data-source.tf`. This flag allows you to target specific resources or data sources that are defined in that file.

#### Steps:

1. **Identify the resources/data sources in `data-source.tf`**: 
   Suppose `data-source.tf` contains a data source like this:

   ```hcl
   # data-source.tf
   data "aws_ami" "latest_ubuntu" {
     most_recent = true
     owners      = ["099720109477"]
     filters = {
       name = "ubuntu/images/*/ubuntu*"
     }
   }
   ```

2. **Run `terraform plan` or `terraform apply` with the `-target` flag** to apply only the `data-source.tf` content.

   For example, if `aws_ami.latest_ubuntu` is the data source you want to apply from `data-source.tf`, use the following command:

   ```bash
   terraform apply -target=data.aws_ami.latest_ubuntu
   ```

   This will only target and apply the resource defined in `data-source.tf` (in this case, the `aws_ami` data source) and will ignore resources in `main.tf` unless they depend on the data source.

3. **Running the Apply Command**: Once you've verified that the changes are targeting the correct resource, run the following:

   ```bash
   terraform apply -target=data.aws_ami.latest_ubuntu
   ```

   This will apply only the changes related to the data source, and the resources defined in `main.tf` will not be applied or affected unless they're explicitly dependent on `data-source.tf`.

#### 2. **Use `-state` or `-state-out` (Optional for Isolating State)**

If you want to further isolate the state files (for example, applying only the data sources and keeping the state of the resources in `main.tf` separate), you can use the `-state` or `-state-out` flags to specify a different state file for the `data-source.tf` changes.

For example:

```bash
terraform apply -state=data-source.tfstate -target=data.aws_ami.latest_ubuntu
```

This would apply only the data source and save its state in a separate `data-source.tfstate` file.

### 3. **Best Practice - Separate Terraform Workspaces or Directories**

If your `main.tf` and `data-source.tf` files are logically different, it might be better to separate them into different directories or workspaces. Terraform allows you to define different workspaces, and you can have a separate configuration for each (i.e., one workspace for `main.tf` and another for `data-source.tf`).

For example:

1. **Separate directories for main.tf and data-source.tf**:
   - `/main`: Contains `main.tf` with the actual infrastructure resources.
   - `/data-source`: Contains `data-source.tf` for the data sources.

2. **Run Terraform in the specific directory:**

   Navigate to the directory containing `data-source.tf` and run:

   ```bash
   terraform apply
   ```

   This applies only the configuration in `data-source.tf`.

---

### Conclusion:

While Terraform doesn’t directly allow applying just one `.tf` file, you can target specific resources or data sources using the `-target` flag. This way, you can isolate the application of `data-source.tf` without modifying `main.tf`. Additionally, consider using different directories or workspaces for even more control.
