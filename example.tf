provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# New resources for the S3 bucket our application will use.
resource "aws_s3_bucket" "example" {
  bucket = "mmaether-terraform-getting-started"
  acl    = "private"
}

resource "aws_instance" "example" {
  ami           = "ami-b374d5a5"
  instance_type = "t2.micro"
  depends_on    = [aws_s3_bucket.example]

  provisioner "local-exec" {
    command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  vpc = true
  instance = aws_instance.example.id
}