#!/bin/bash -x

machines=$(docker ps | awk '{print $NF}' | grep GNS3)

ip_host_1="30.1.1.1/24"
ip_host_2="30.1.1.2/24"

ip_router_1="10.1.1.1"
ip_router_2="10.1.1.2"
vxlan_ip_1="20.1.1.1"
vxlan_ip_2="20.1.1.2"

for i in 1 2
do
    if echo $machines | grep -q "host-"; then
	name=$(echo "$machines" | grep "host-$i")
        ip_machine="ip_host_${i}"
	docker exec $name ip addr add ${!ip_machine} dev eth1
    fi
done

for i in 1 2
do
    if echo $machines | grep -q "router-"; then
	name=$(echo "$machines" | grep "router-$i")
	router_ip="ip_router_${i}"
	if [ $i -eq 1 ]; then
	    other_router_ip=${!ip_router_2}
	else
	    other_router_ip=${!ip_router_1}
	vxlan_ip="vxlan_ip_${i}"
	docker exec $name ip link add br0 type bridge
	docker exec $name ip link set dev br0 up
	docker exec $name ip addr add ${!router_ip} dev eth0
	docker exec $name /sbin/ip link add name vxlan10 type vxlan id 10 dev eth0 remote 10.1.1.1 local 10.1.1.2 dstport 4789
	docker exec $name ip addr add ${!vxlan_ip} dev vxlan10
	docker exec $name brctl addif br0 eth1
	docker exec $name brctl addif br0 vxlan10
	docker exec $name ip link set dev vxlan10 up
    fi
done
