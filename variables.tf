variable domain_name {
    type = string
    description = "This is my website domain"
}

variable tag_name {
    type = string
    description = "Tag Name"
}

variable s3_remote_state {
    type = string
    description = "S3 bucket for my statefile"
}