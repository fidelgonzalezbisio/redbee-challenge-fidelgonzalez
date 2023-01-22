#!/bin/bash

# wait-for-url() {
#     echo "Testing $1"
#     timeout --foreground -s TERM 120s bash -c \
#         'while [[ "$(curl -s -o /dev/null -m 3 -L -w ''%{http_code}'' ${0}/quotes)" != "200" ]];\
#         do echo "Waiting for ${0}" && kubectl get pods -n redbee-env && sleep 10 && echo;\
#         done' ${1}
#     echo "${1} - OK!"
# }

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

# url=$(minikube service -n redbee-env api-service web --url)
# quotes_url="${url}/quotes"

# # echo "Wait for URLs: $quotes_url"

# # for var in "$quotes_url"; do
# #     wait-for-url "$var"
# # done
# while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' ${quotes_url})" != "200" ]]; do echo ''%{http_code}'' sleep 5; done

# curl ${quotes_url}