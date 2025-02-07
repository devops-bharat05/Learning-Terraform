Terraform using different AWS profiles by specifying the profile explicitly in multiple ways:

---

### 1️⃣ **Set the AWS Profile in the Provider Block**
Modify your `provider.tf` file to use a specific profile dynamically:

```hcl
provider "aws" {
  region  = "us-east-1"
  profile = var.aws_profile
}
```

Then, define the variable in `variables.tf`:

```hcl
variable "aws_profile" {
  type    = string
  default = "dev-aws"  # Change to "qa-aws" when needed
}
```

Override the profile while running Terraform:

```sh
terraform apply -var="aws_profile=qa-aws"
```

---

### 2️⃣ **Use Environment Variables**
You can override the AWS profile for Terraform execution using environment variables:

```sh
AWS_PROFILE=dev-aws terraform apply
```

Or switch to another profile:

```sh
AWS_PROFILE=qa-aws terraform apply
```

---

### 3️⃣ **Pass Profile via CLI Argument**
You can set the AWS profile inline when running Terraform:

```sh
terraform apply -var="aws_profile=dev-aws"
AWS_PROFILE=qa-aws terraform apply
```

---

### 4️⃣ **Use Different Workspaces for Different Profiles**
If you're managing multiple environments, Terraform workspaces can help:

```sh
terraform workspace new dev
terraform workspace select dev
AWS_PROFILE=dev-aws terraform apply
```

```sh
terraform workspace new qa
terraform workspace select qa
AWS_PROFILE=qa-aws terraform apply
```

---

### Best Practice:
✅ **Use the `profile` argument in the provider block** if your Terraform setup explicitly needs different profiles.  
✅ **Use environment variables** (`AWS_PROFILE`) when switching between profiles frequently.  
✅ **Workspaces** help in managing different environments within the same Terraform configuration.

Let me know if you need further clarification! 🚀
