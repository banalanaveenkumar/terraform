output "vpc_id" {
value=aws_vpc.myvpc.id
}
output "subnet_ids" {
value =aws_subnet.public_subnet.*.id 
}
