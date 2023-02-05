#!/bin/bash

# ip-адрес для сервиса c_master_ip, задается из подсети docker-хоста
c_master_ip=192.168.100.50
# ip-адрес для сервиса c_node_1_ip, задается из подсети docker-хоста
c_node_1_ip=192.168.100.51
# ip-адрес для сервиса c_node_2_ip, задается из подсети docker-хоста
c_node_2_ip=192.168.100.52
# название интерфейса хоста, узнать можно командой ip a
host_network_dev=ens33
# подсеть docker-хоста
host_subnet=192.168.100.0
# маска подсети docker-хоста
host_mask=24
# шлюз по умолчанию docker-хоста
host_gateway=192.168.100.1
# имя для нового интерфейса, служащего для связи контейнеров с локальной сетью
bridge_int_name=doc-host
# ip-адрес для нового интерфейса, служащего для связи контейнеров с локальной сетью
bridge_int_ip=192.168.100.60
# имя docker-compose файла
docker_compose_file=./docker-compose.yml

sed -i "s/<c_master_ip>/${c_master_ip}/" ${docker_compose_file}
sed -i "s/<c_node_1_ip>/${c_node_1_ip}/" ${docker_compose_file}
sed -i "s/<c_node_2_ip>/${c_node_2_ip}/" ${docker_compose_file}
sed -i "s/<host_network_dev>/${host_network_dev}/" ${docker_compose_file}
sed -i "s/<host_subnet>/${host_subnet}/" ${docker_compose_file}
sed -i "s/<host_mask>/${host_mask}/" ${docker_compose_file}
sed -i "s/<host_gateway>/${host_gateway}/" ${docker_compose_file}

docker-compose up -d

ip link add $bridge_int_name link $host_network_dev type macvlan mode bridge
ip addr add ${bridge_int_ip}/${host_mask} dev ${bridge_int_name}
ip link set ${bridge_int_name} up
ip route add ${host_subnet}/${host_mask} dev ${bridge_int_name}

sed -i "s/${c_master_ip}/<c_master_ip>/" ${docker_compose_file}
sed -i "s/${c_node_1_ip}/<c_node_1_ip>/" ${docker_compose_file}
sed -i "s/${c_node_2_ip}/<c_node_2_ip>/" ${docker_compose_file}
sed -i "s/${host_network_dev}/<host_network_dev>/" ${docker_compose_file}
sed -i "s/${host_subnet}/<host_subnet>/" ${docker_compose_file}
sed -i "s/${host_mask}/<host_mask>/" ${docker_compose_file}
sed -i "s/${host_gateway}/<host_gateway>/" ${docker_compose_file}

exit