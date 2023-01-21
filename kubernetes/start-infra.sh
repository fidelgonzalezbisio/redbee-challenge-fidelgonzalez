#!/bin/bash

for i in $(ls -l [1-8]*.yaml | awk '{print $9}') ; 
do 
    kubectl apply -f ${i}
    if [ $? -eq 0 ]
    then
        echo OK && sleep 5
    else
        echo Error creando ${i} && exit 1
    fi
done

url=$(minikube service -n redbee-env api-service web --url)

kubectl get all -n redbee-env

echo "\nTESTEO DE URL CON CURL"
sleep 10
curl ${url}/quotes

    # echo $i && sleep 3; done
# ls -l [1-7]*.yaml