
output "my_container_ip" {
    value = [ for container in docker_container.my_container:
                container.network_data[0].ip_address ]
}
output "my_other_container_ip" {
    value = [ for container_name, container in docker_container.my_simple_custom_containers:
                container.network_data[0].ip_address ]
}