output "dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.main.dns_name
}
output "security_group_id" {
  description = "The security group ID for the ALB"
  value       = aws_security_group.alb_sg.id
}