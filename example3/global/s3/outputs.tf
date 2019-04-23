output "s3_bucket_arn" {
  value = "${aws_s3_bucket.s3_status.arn}"
}