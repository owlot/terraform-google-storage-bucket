output "map" {
  description = "outputs for all google_storage_buckets created"
  value       = google_storage_bucket.map
}
output "local_buckets" {
  description = "outputs for all google_storage_buckets created"
  value       = local.buckets #google_storage_bucket.map
}
