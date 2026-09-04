variable "bucket_count" {
  type    = number
  default = 2
}

resource "random_id" "count_bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "count_example" {

  count = var.bucket_count

  bucket = "${var.project_name}-${count.index}-${random_id.count_bucket_suffix.hex}"

}