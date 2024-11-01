variable "BeStrong_group_name" {
  description = "BeStrong Group Name"
  type        = string
}

variable "BeStrong_group_location" {
  description = "BeStrong Group Location"
  type        = string
}

variable "BeStrong_azSQL_login" {
  description = "BeStrong Azure SQL Login"
  type        = string
  sensitive   = true
}

variable "BeStrong_azSQL_password" {
  description = "BeStrong Azure SQL Password"
  type        = string
  sensitive   = true
}

variable "BeStrong_azSQL_vCPU_max" {
  description = "BeStrong Azure SQL max num of vCPU"
  type        = number

  validation {
    condition     = var.BeStrong_azSQL_vCPU_max >= 1 && var.BeStrong_azSQL_vCPU_max <= 80 && can(regex("^[0-9]+$", tostring(var.BeStrong_azSQL_vCPU_max)))
    error_message = "The BeStrong_azSQL_vCPU_max variable must be an integer from 1 to 80"
  }
}

variable "BeStrong_azSQL_vCPU_min" {
  description = "BeStrong Azure SQL min num of vCPU. Default is 0.5"
  type        = number
  default     = 0.5

  validation {
    condition     = var.BeStrong_azSQL_vCPU_min >= 0.5
    error_message = "The BeStrong_azSQL_vCPU_min variable must be integer >= 0.5"
  }
}

variable "BeStrong_azSQL_vCPU_pause_delay" {
  description = "Time in minutes after which database is automatically paused. Default is 60"
  type        = number
  default     = 1

  validation {
    condition     = var.BeStrong_azSQL_vCPU_pause_delay >= 1
    error_message = "The BeStrong_azSQL_vCPU_pause_delay variable must be integer >= 60"
  }
}

variable "BeStrong_azSQL_size_gb" {
  description = "BeStrong Azure SQL max size of DB in GB"
  type        = number

  validation {
    condition     = var.BeStrong_azSQL_size_gb >= 1 && can(regex("^[0-9]+$", tostring(var.BeStrong_azSQL_size_gb)))
    error_message = "The BeStrong_azSQL_size_gb variable must be integer >= 1"
  }
}

variable "BeStrong_storage_file_share_size_gb" {
  description = "BeStrong file share max size in GB"
  type        = number

  validation {
    condition     = var.BeStrong_storage_file_share_size_gb >= 1 && can(regex("^[0-9]+$", tostring(var.BeStrong_storage_file_share_size_gb)))
    error_message = "The BeStrong_storage_file_share_size_gb variable must be integer >= 1"
  }
}