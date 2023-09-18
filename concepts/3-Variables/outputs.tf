
output "my_container_ip" {
    value = docker_container.my_container.network_data[0].ip_address // I can write an expression
}
# With "$ terraform output" we are able to check out outputs

# $ terraform output my_container_ip
# This asks for a single output. The value will be returned in HCL
# I can ask for the value inn alternative languages: --json --raw
