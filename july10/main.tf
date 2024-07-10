resource "aws_instance" "dev" {
    
    ami = "ami-01376101673c89611"
    instance_type = "t3.micro"
    key_name ="pradeep" 
    associate_public_ip_address = true
    tags = {
      Name = "private-user1"
    }
}

resource "aws_s3_bucket" "dev" {
    bucket = "seegi.lock"
  
}


resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}
