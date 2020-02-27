terraform {
  backend "s3" {
    bucket = "tf-immutable-infrastructure-remote-state-storage"
    key    = "static_json_test"
    region = "eu-north-1"
  }
}
