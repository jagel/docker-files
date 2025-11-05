terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"  # Windows-specific Docker socket
}

# Create a custom network
resource "docker_network" "dbnet" {
  name = "dbnet"
  lifecycle {
    ignore_changes = all # ignores if network already exists
  }
}

# Create named volume for SQL Server data
resource "docker_volume" "mssql_data" {
  name = "mssql2022_data"
}

# Create SQL Server container
resource "docker_container" "mssql" {
  name  = "dev-mssql2022"
  image = "mcr.microsoft.com/mssql/server:2022-latest"
  
  # Set hostname to match Docker Compose
  hostname = "dev-mssql2022"

  # Add project name label
  labels {
    label = "com.docker.compose.project"
    value = "databases"
  }

  env = [
    "ACCEPT_EULA=Y",
    "MSSQL_SA_PASSWORD=YourStrongPassword!",
    "MSSQL_PID=Express"
  ]

  # Add memory limits (required for SQL Server)
  memory               = 2048    # 2GB minimum required
  memory_swap          = 4096    # 4GB swap
  cpu_shares           = 1024    # Normal CPU priority

  ports {
    internal = 1433
    external = 1433
  }

  networks_advanced {
    name = docker_network.dbnet.name
  }

  restart = "unless-stopped"

  # Use named volume (Docker manages the location)
  volumes {
    volume_name    = docker_volume.mssql_data.name
    container_path = "/var/opt/mssql/data"
    read_only      = false
  }

  # Add user configuration to run as root (SQL Server requirement)
  user = "0:0"  # Run as root user

  # Add health check to match Docker Compose
  healthcheck {
    test     = ["CMD", "/opt/mssql-tools/bin/sqlcmd", "-S", "localhost", "-U", "sa", "-P", "YourStrongPassword!", "-Q", "SELECT 1"]
    interval = "10s"
    timeout  = "5s"
    retries  = 5
    start_period = "30s"
  }

  depends_on = [docker_volume.mssql_data]
}
