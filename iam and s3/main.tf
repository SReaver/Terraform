terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "example" {
  bucket = "cloudonaut-lesson-tf-aim-policy"
}

resource "aws_iam_policy" "inline" {
  name   = "tf-inline"
  policy = <<EOF
		{
			"Version": "2012-10-17",
			"Statement": [
				{
					"Effect": "Allow",
					"Action": "s3:ListBucket",
					"Resource": "${aws_s3_bucket.example.arn}",
				},
				{
					"Effect": "Allow",
					"Action": [
						"s3:GetObject",
						"s3:PutObject"
					],
					"Resource": "${aws_s3_bucket.example.arn}/*",
				}
			]
		}
	EOF
}

data "aws_iam_policy_document" "example" {
	statement {
		effect = "Allow"
		actions = [ "s3:ListBucket" ]
		resources = [ aws_s3_bucket.example.arn  ]
	}
	statement {
		effect = "Allow"
		actions = [ 
			"s3:GetObject",
			"s3:PutObject"
		 ]
		resources = [ 
			"${aws_s3_bucket.example.arn }/*"
		 ]
	}
}