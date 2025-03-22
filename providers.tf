terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.91.0"
    }
  }

  backend "s3" {
    bucket  = "emb-tfstate-bucket"
    region  = "us-east-2"
    key     = "terraform.tfstate"
    encrypt = true
    profile = "emb-sso"
  }
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.tfstate_bucket

  lifecycle {
    prevent_destroy = true
  }
}


resource "aws_s3_bucket_versioning" "terraform_state_version" {
  bucket = aws_s3_bucket.terraform_state.bucket

  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [aws_s3_bucket.terraform_state]
}
