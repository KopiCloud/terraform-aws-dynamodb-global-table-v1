// Create DynamoDB Table
resource "aws_dynamodb_table" "book_catalog_table" {
  name             = "BookCatalog"
  billing_mode     = "PROVISIONED"
  read_capacity    = 1
  write_capacity   = 1 
  hash_key         = "BookName"
  
  attribute {
    name = "BookName"
    type = "S"
  }
  
  attribute {
    name = "Author"
    type = "S"
  }

  global_secondary_index {
    name               = "Author-Index"
    hash_key           = "Author"
    write_capacity     = 1
    read_capacity      = 1
    projection_type    = "INCLUDE"
    non_key_attributes = ["Genre"]
  }

  tags = {
    Name        = "book-catalog-table"
    Environment = "production"
  }
 }

// Create DynamoDB Single Item
resource "aws_dynamodb_table_item" "book_catalog_item_1" {
  table_name = aws_dynamodb_table.book_catalog_table.name
  hash_key   = aws_dynamodb_table.book_catalog_table.hash_key

  item = <<ITEM
 {
    "BookName": {"S": "Seven Fires"},
    "Author": {"S": "Francis Mallmann"},
    "Genre": {"S": "Cooking"}
}
ITEM
}

// Create DynamoDB Single Item
resource "aws_dynamodb_table_item" "book_catalog_item_2" {
  table_name = aws_dynamodb_table.book_catalog_table.name
  hash_key   = aws_dynamodb_table.book_catalog_table.hash_key

  item = <<ITEM
 {
    "BookName": {"S": "The Most Beautiful Walk in the World"},
    "Author": {"S": "John Baxter"},
    "Genre": {"S": "Travel"}
}
ITEM
}

// Create DynamoDB Multiple Items
resource "aws_dynamodb_table_item" "book_catalog_fiction_items" {
  table_name = aws_dynamodb_table.book_catalog_table.name
  hash_key   = aws_dynamodb_table.book_catalog_table.hash_key
  
  for_each = {
    "Rayuela" = {
      author = "Julio Cortazar"
      genre  = "Fiction"
    }
    "A Moveable Feast" = {
      author = "Ernest Hemingway"
      genre  = "Fiction"    
    }
    "The Great Gatsby" = {
      author = "F. Scott Fitzgerald"
      genre  = "Fiction"    
    }
  }
  item = <<ITEM
 {
    "BookName": {"S": "${each.key}"},
    "Author": {"S": "${each.value.author}"},
    "Genre": {"S": "${each.value.genre}"}
  }
  ITEM
}
