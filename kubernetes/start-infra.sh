#!/bin/bash

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
