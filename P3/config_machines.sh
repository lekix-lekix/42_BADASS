#!/bin/bash -x

machines=$(docker ps | awk '{print $NF}' | grep GNS3)

for i in 1 2 3 4
do
    if echo $machines | grep -q "router-"; then
	machine_name=$(echo "$machines" | grep "router-$i")

	if [ -e "./kipouliq-router-$i" ]; then
            # filename="./kipouliq-router-$i"
            # echo "filename = $filename"
            while IFS= read -r line
            do
	        docker exec $machine_name $line
		#echo "executing docker exec $machine_name $line"
            done < "./kipouliq-router-$i"
	fi

	if [ -e ./kipouliq-router-$i-vtysh ]; then
#	    filename="./kipouliq-router-$i-vtysh"
#	    echo "filename vtysh = $filename"
    	    docker exec -i $machine_name vtysh < "./kipouliq-router-$i-vtysh"
	fi
    fi
done


docker exec $(echo "$machines" | grep "host-1") ip addr add 20.1.1.1/24 dev eth1
docker exec $(echo "$machines" | grep "host-3") ip addr add 20.1.1.2/24 dev eth0


