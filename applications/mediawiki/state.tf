terraform {
  backend "s3" {
    bucket = "mediawiki-state-bucket"
    region = "ap-southeast-2"
  }
}
