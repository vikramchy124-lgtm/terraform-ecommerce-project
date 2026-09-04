variable "bucket_count" {
  type    = number
  default = 2
}

resource "aws_s3_bucket" "count_example" {

  count = var.bucket_count

  bucket = "my-bucket-${count.index}"

}