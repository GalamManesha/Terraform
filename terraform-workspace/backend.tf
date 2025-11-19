terraform {
  backend "s3" {
    bucket = "my-first-bucket-state-file"
    key    = "env/dev/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
  }
}

