# Import JSON with Multiple records
resource "null_resource" "dynamodb_bulk_powershell" {
  provisioner "local-exec" {
    command = "PowerShell -file dynamodb-bulk.ps1"
  }      
  triggers = {
    always_run = timestamp()
  }
}