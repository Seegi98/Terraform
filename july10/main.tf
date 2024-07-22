#create vpc

resource "aws_vpc" "user" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "cust-vpc"
    }  
}

#create Internet gateway

resource "aws_internet_gateway" "user" {

    vpc_id = aws_vpc.user.id
    tags = {
      Name = "cust-ig"
    }
  
}

#create NATgateway

resource "aws_nat_gateway" "dev" {
    subnet_id = aws_subnet.user.id
    connectivity_type = "public"
    allocation_id = aws_eip.dev.id
    tags = {
      Name = "NAT"
    }
}

#allocating eip

resource "aws_eip" "dev" {

    domain = "vpc"
  
}

#create public subnet

resource "aws_subnet" "user" {

    vpc_id = aws_vpc.user.id
    cidr_block = "10.0.0.0/24"
    tags = {
      Name = "pub-subnet"
    }
}

#create private subnet

resource "aws_subnet" "dev" {
  vpc_id = aws_vpc.user.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "Private-subnet"
  }
}

#create Route-table

resource "aws_route_table" "user" {
    vpc_id = aws_vpc.user.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.user.id
    }
    tags = {
      Name = "cust-rt"
    }
}

#create Nat Route- table

resource "aws_route_table" "dev" {
    vpc_id = aws_vpc.user.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.dev.id
    }
    tags = {
      Name = "cust-NAT-rt"
    }
}

# Edit route-table-associations

resource "aws_route_table_association" "user" {
    route_table_id = aws_route_table.user.id
    subnet_id = aws_subnet.user.id
}

# Edit NAT-Route-table-associations

resource "aws_route_table_association" "dev" {
    route_table_id = aws_route_table.dev.id
    subnet_id = aws_subnet.dev.id
}

#create security groups

resource "aws_security_group" "user" {
    tags = {
      Name = "cust-sg"
    }
    vpc_id = aws_vpc.user.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

#create instance

resource "aws_instance" "user" {
    vpc_security_group_ids = [aws_security_group.user.id]
    ami = "ami-01376101673c89611"
    instance_type = "t2.micro"
    key_name ="pradeep"
    subnet_id = aws_subnet.user.id 
    associate_public_ip_address = true
    tags = {
      Name = "user"
    }
}

#create Private-instance

resource "aws_instance" "dev" {
    vpc_security_group_ids = [aws_security_group.user.id]
    ami = "ami-01376101673c89611"
    instance_type = "t3.micro"
    key_name ="pradeep"
    subnet_id = aws_subnet.dev.id 
    associate_public_ip_address = false
    tags = {
      Name = "private-user"
    }
}

#create s3 bucket

#resource "aws_s3_bucket" "user" {
 #  bucket = "seegi"
  
#}

#dyanmo DB

resource "aws_s3_bucket" "dev" {
    bucket = "seegi.boaz"
  
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


