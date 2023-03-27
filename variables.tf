#------------------------------------------------------------------------------------------------------------------------
#
# Generic variables
#
#------------------------------------------------------------------------------------------------------------------------
variable "prefix" {
  description = "Company naming prefix, ensures uniqueness of bucket names"
  type        = string
}

variable "owner" {
  description = "Company owner name"
  type        = string
}

variable "project" {
  description = "Company project name"
  type        = string
}

variable "environment" {
  description = "Company environment for which the resources are created (e.g. dev, tst, dmo, stg, prd, all)."
  type        = string
}

variable "region" {
  description = "Company region for which the resources are created (e.g. global, us, eu, asia)."
  type        = string
}

variable "gcp_project" {
  description = "GCP Project ID override - this is normally not needed and should only be used in specific cases."
  type        = string
  default     = null
}

#------------------------------------------------------------------------------------------------------------------------
#
# Bucket variables
#
#------------------------------------------------------------------------------------------------------------------------

variable "buckets_force_destroy" {
  description = "When set to true, allows TFE to remove buckets that still contain objects"
  type        = bool
  default     = false
}

variable "buckets" {
  description = "Map of buckets to be created. The key will be used for the bucket name so it should describe the bucket purpose."

  type = map(object({
    location                    = optional(string, "europe-west4")
    storage_class               = optional(string, "REGIONAL")
    versioning_enabled          = optional(bool, true)
    uniform_bucket_level_access = optional(bool, true)
    retention_policy = optional(object({
      is_locked        = bool
      retention_period = number
    }), null)
    lifecycle_rules = optional(map(object({
      action = map(string)
      condition = object({
        age                   = optional(number)
        with_state            = optional(string)
        created_before        = optional(string)
        matches_storage_class = optional(list(string))
        num_newer_versions    = optional(number)
      })
    })), null)
    logging = optional(object({
      log_bucket        = string
      log_object_prefix = string
    }), null)
    roles = map(object({
      members = map(string)
      condition = optional(object({
        expression  = string
        title       = string
        description = optional(string, null)
      }))
    }))
    labels = optional(map(string), {})
  }))
}
