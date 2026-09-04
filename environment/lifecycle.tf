resource "aws_s3_bucket" "lifecycle_test_" {
  bucket = "${var.project_name}-${var.environment}-lifecycle-test-${random_id.bucket_suffix.hex}"

}

lifecycle {
  prevent_destroy = true
}