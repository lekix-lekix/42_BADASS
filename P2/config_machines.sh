#! /usr/bin/sh -x

MACHINES=$(docker ps | awk '{print $NF}' | grep GNS3)

ip_host_1="30.1.1.1/24"
ip_host_2="30.1.1.2/24"

ip_router1="10.1.1.1/24"
ip_router2="10.1.1.2/24"
vxlan_ip1="20.1.1.1/24"
vxlan_ip2="20.1.1.2/24"

router_ip=""
vxlan_ip=""

router1_config=$(cat << 'EOF'
ip link add br0 type bridge
ip link set dev br0 up
ip addr add ${ip} dev eth1
/sbin/ip link add name vxlan10 type vxlan id 10 dev eth0 remote 10.1.1.2 local 10.1.1.1 dstport 4789
ip addr add ${vxlan_ip} dev vxlan10
brctl addif br0 eth1
brctl addif br0 vxlan10
ip link set dev vxlan10 up
EOF
)

for i in {1..2}
do
    name=$(echo "$MACHINES" | awk -v col="$i" 'NR==1{print $col}')
    echo "NAME = $name"
    if echo $name | grep -q "host-1"; then
#	echo "docker exec $name ip addr add ${ip_host_1} dev eth1"
	docker exec $name ip addr add ${ip_host_1} dev eth1
    elif echo $name | grep -q "host-2"; then
	docker exec $name ip link add ${ip_host_2} dev eth1
    elif echo $name | grep -q "router"; then
	if echo $name | grep -q "router-1"; then
	    router_ip=$ip_router_1
	    vxlan_ip=$vxlan_ip_1
        else
	    router_ip=$ip_router2
	    vxlan_ip=$vxlan_ip2
	fi
	docker exec $name $router1_config
    fi
done
