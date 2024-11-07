### **3. Fetching and Using Secrets from AWS Secrets Manager**

In this hands-on exercise, you will:
- Fetch sensitive information (like database credentials) stored in **AWS Secrets Manager**.
- Use the fetched secrets to configure an RDS instance or other resources securely.

**Steps:**
1. Define the AWS provider.
2. Use the `aws_secretsmanager_secret` and `aws_secretsmanager_secret_version` data sources to fetch secrets.
3. Use the fetched secrets to create a resource like an RDS instance.

**Terraform Code:**

```hcl
# Define the AWS provider
provider "aws" {
  region = "us-west-2"
}

# Fetch the secret from AWS Secrets Manager
data "aws_secretsmanager_secret" "db_credentials" {
  name = "db-credentials"
}

data "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = data.aws_secretsmanager_secret.db_credentials.id
}

# Create an RDS instance using the fetched secret for database credentials
resource "aws_db_instance" "example" {
  identifier        = "my-db-instance"
  engine            = "mysql"
  instance_class    = "db.t2.micro"
  allocated_storage = 20

  username          = jsondecode(data.aws_secretsmanager_secret_version.db_credentials_version.secret_string)["username"]
  password          = jsondecode(data.aws_secretsmanager_secret_version.db_credentials_version.secret_string)["password"]
  db_name           = "mydatabase"

  tags = {
    Name = "DBInstanceWithSecrets"
  }
}
```

**Explanation:**
- The `aws_secretsmanager_secret` data source fetches the metadata of the secret.
- The `aws_secretsmanager_secret_version` data source fetches the secret value itself.
- The `aws_db_instance` resource creates an RDS instance and uses the fetched database credentials.
