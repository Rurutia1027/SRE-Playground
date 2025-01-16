variable "region" {
  type        = string
  description = "AWS region"
}

variable "description" {
  type        = string
  default     = ""
  description = "Short description of the Environment"
}

variable "elastic_beanstalk_application_name" {
  type        = string
  description = "Elastic Beanstalk application name"
}

variable "environment_type" {
  type        = string
  default     = "LoadBalanced"
  description = "Environment type, e.g., 'LoadBalanced' or 'SingleInstance'. If setting to 'SingleInstance', `rolling_update_type` must be set to 'Time', `updating_min_in_service` must be set to 0, and `loadbalancer_subnets` will be unused (it applies to the ELB, which does not exist in SingleInstance environments)"
}

variable "loadbalancer_type" {
  type        = string
  default     = "classic"
  description = "Load Balancer type, e.g., 'application` or 'classic'"
}

variable "loadbalancer_is_shared" {
  type        = bool
  default     = false
  description = "Flag to create a shared application loadbalancer. Only when loadbalancer_type = \"application\" https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environments-cfg-alb-shared.html"
}

variable "shared_loadbalancer_arn" {
  type        = string
  default     = ""
  description = "ARN of the shared application load balancer. Only when loadbalancer_type = \"application\"."
}

variable "loadbalancer_crosszone" {
  type        = bool
  default     = ""
  description = "ARN of the shared application load balancer. Only when loadbalancer_type = \"application\"."
}

variable "loadbalancer_connection_idle_timeout" {
  type        = number
  default     = 60
  description = "Classic load balancer only: Number of seconds that the load balancer waits for any data to be sent or received over the connection. If not data has been sent or received after this time period elapses, the load balancer closes the connection."
}

variable "dns_zone_id" {
  type        = string
  default     = ""
  description = "Route53 parent zone ID. The module will create sub-domain DNS record in the parent zone for the EB environment"
}

variable "dns_subdomain" {
  type        = string
  default     = ""
  description = "The subdomain to create on Route53 for the EB environment. For the subdomain to be created, the `dns_zone_id` variable must be set as well"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC in which to provision the AWS resources"
}

variable "loadbalancer_subnets" {
  type = list(string)
  description = "List of subnets to place Elastic Load Balancer"
  default = []
}

variable "application_subnets" {
  type = list(string)
  description = "List of subnets to place EC2 instances"
}

variable "availability_zone_selector" {
  type        = string
  default     = "Any 2"
  description = "Availability Zone selector"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instances type"
}

variable "enable_spot_instances" {
  type        = bool
  default     = false
  description = "Enable Spot Instance requests for your environment"
}

variable "spot_fleet_on_demand_base" {
  type        = number
  default     = 0
  description = "The minmum number of On-Demand Instances that your Auto Scaling group provisions before considering Spot Instances as your environment scales up. This options is relevant only when enable_spot_instances is true."
}

variable "spot_fleet_on_demand_above_base_percentage" {
  type        = number
  default     = -1
  description = "THe percentage of On-Demand Instances as part of additional capacity that your Auto Scaling group provisions beyond the SpotOnDemandBase instances. This option is relevant only when enable_spot_instances is true."
}

variable "spot_max_price" {
  type        = number
  default     = -1
  description = "The maximum price per unit hour, in US$, that you're willing to pay for a Spot Instance. This option is relevant only when enable_spot_instances is true. Valid values are between 0.001 and 20.0"
}

variable "enhanced_reporting_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable \"enhanced\" health reporting for this environment. If false, \"basic\" reporting is used. When you set this to false, you must also set `enable_managed_actions` to false"
}

variable "managed_actions_enabled" {
  type        = bool
  default     = true
  description = "Enable managed platform updates. When you set this to true, you must also specify a `PreferredStartTime` and `UpdateLevel`"
}

variable "autoscale_min" {
  type = number
}

