#Create subnet groups for Redis
resource "aws_elasticache_subnet_group" "redis-subnet-group" {
  name       = "redis-subnet-group"
  subnet_ids = [data.aws_subnet.public_signeasy_sb1.id,data.aws_subnet.public_signeasy_sb2.id,data.aws_subnet.int_signeasy_sb1.id,data.aws_subnet.int_signeasy_sb2.id]
}


resource "aws_elasticache_replication_group" "prod-filesystem-cache-nocluster" {
  automatic_failover_enabled    = true
  availability_zones            = ["us-east-2a", "us-east-2b"]
  replication_group_id          = "prod-filesystem-cache-nocluster"
  replication_group_description = "prod-filesystem-cache-nocluster"
  multi_az_enabled = "true"
  number_cache_clusters         = 2
  engine               = "redis"
  engine_version       = "5.0.6"
  node_type                     = "cache.r5.xlarge"
  port                          = 6379
  subnet_group_name = "redis-subnet-group"
  security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  maintenance_window = "mon:04:00-mon:05:00"
  snapshot_window = "08:00-09:00"
  snapshot_retention_limit = "1"

  #cluster_mode {
   # replicas_per_node_group = 1
    #num_node_groups         = 1
  #}
}
resource "aws_elasticache_replication_group" "queue-broker-new" {
  automatic_failover_enabled    = true
  availability_zones            = ["us-east-2a", "us-east-2b"]
  replication_group_id          = "queue-broker-new"
  replication_group_description = "queue-broker-new"
  multi_az_enabled = "true"
  number_cache_clusters         = 2
  engine               = "redis"
  engine_version       = "5.0.6"
  node_type                     = "cache.m4.xlarge"
  port                          = 6379
  subnet_group_name = "redis-subnet-group"
  security_group_ids = [aws_security_group.signeasy_prod_int_sg.id]
  maintenance_window = "sun:16:00-sun:17:00"
  snapshot_window = "06:00-07:00"
  snapshot_retention_limit = "7"

  #cluster_mode {
   # replicas_per_node_group = 1
    #num_node_groups         = 1
  #}
}

