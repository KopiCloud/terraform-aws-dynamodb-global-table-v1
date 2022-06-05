# Import JSON with Multiple records
resource "null_resource" "dynamodb_bulk_bash" {
  provisioner "local-exec" {
    command = "PowerShell -file dynamodb-bulk.sh"
  }      
  triggers = {
    always_run = timestamp()
  }
}