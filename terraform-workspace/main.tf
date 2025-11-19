resource "aws_instance" "example" {
  instance_type = var.instance_type
  key_name      = var.key_name
  ami           = var.ami
  tags = {
    Name = var.tags
  }
}
resource "aws_s3_bucket" "my-first-bucket-state-file" {
  bucket = var.aws_s3_bucket
   region = var.region
  
}
}
