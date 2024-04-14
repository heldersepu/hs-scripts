security_groups = {
  "Frontend-ALB-Security-Group" = {
    name        = "Frontend-ALB-Security-Group"
    description = "Enable http/https access on port 80/443"
    vpc         = "tersu"
    ingress = [
      {
        description = "http access"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "https access"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }

  "Backend-NLB-Security-Group" = {
    name        = "Backend-NLB-Security-Group"
    description = "Enable http/https access on port 5000"
    vpc         = "tersu"
    ingress = [
      {
        description = "Backend access from frontend"
        from_port   = 5000
        to_port     = 5000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  },

  "Frontend-Security-Group" = {
    name        = "Frontend-Security-Group"
    description = "Enable http, https, and ssh access on ports 80, 443, and 22 respectively"
    vpc         = "tersu"
    ingress = [
      {
        description = "HTTP access"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "HTTPS access"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "ssh access"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        description = "Allow outbound traffic to backend"
        from_port   = 5000
        to_port     = 5000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }

  "Backend-Security-Group" = {
    name        = "Backend-Security-Group"
    description = "Enable http, https, on port 5000 for ingress, and 5432 for egress respectively"
    vpc         = "tersu"
    ingress = [
      {
        description = "Allow inbound traffic from frontend"
        from_port   = 5000
        to_port     = 5000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        description = "Allow outbound traffic to database"
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }

  "Database-Security-Group" = {
    name        = "Database-Security-Group"
    description = "Enable Postgresql access on port 5432"
    vpc         = "tersu"
    ingress = [
      {
        description = "https access"
        from_port   = 5432
        to_port     = 5432
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
  }

  "SSH-Security-Group" = {
    name        = "SSH-Security-Group"
    description = "Enable SSH access on port 22"
    vpc         = "tersu"

    ingress = [
      {
        description = "ssh access"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = [
      {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        security_groups = "Database-Security-Group"
      }
    ]
  }
}
