#!/bin/bash

wait-for-url() {
    echo "Testing $1"
    timeout --foreground -s TERM 60s bash -c \
        'while [[ "$(curl -s -o /dev/null -m 3 -L -w ''%{http_code}'' ${0}/quotes)" != "200" ]];\
        do echo "Waiting for ${0}" && kubectl get pods -n redbee-env && sleep 10;\
        done' ${1}
    echo "${1} - OK!"
}

for i in $(ls -l [1-8]*.yaml | awk '{print $9}') ; 
do 
    kubectl apply -f ${i}
    if [ $? -eq 0 ]
    then
        echo ${i} OK
    else
        echo Error creando ${i} && exit 1
    fi
done

url=$(minikube service -n redbee-env api-service web --url)

echo "Wait for URLs: $url"

for var in "$url"; do
    wait-for-url "$var"
done

curl ${url}/quotes