# <em> Challenge técnico proceso de selección Redbee </em>

## Tabla de contenidos
1. [Objetivo](#objetivo)
2. [Tecnologias](#tecnologias)
3. [Installation](#installation)
4. [Collaboration](#collaboration)
5. [FAQs](#faqs)

## Objetivo
***
Cómo parte del proceso de seleeción para integrar el equipo de Redbee, se debe construir un cluster de kubernetes el cual asegure la alta disponibilidad de una API hecha en Python con FastApi+SQLAlchemy y su correspondiente Base de datos en MySQL.
Se deben lograr los siguientes objetivos:
* Buildear la imagen de la API y subirla a la registry de docker que utilice el cluster.
* Generar los correspondientes Deployments para las aplicaciones y verificar que están visibles entre sí utilizando el objeto Service.
* Generar un Volumen persistente para la Base de datos.
* Generar un Secrets de K8S para evitar acceder a la contraseña de la base por texto plano.
* Generar el Ingress para que la API sea accesible y pueda consultarse mediante curl, o desde un navegador.

## Tecnologias
***
Lista de tecnologías utilizadas en el proyecto:
* [Minikube](https://minikube.sigs.k8s.io/): Version: v1.28.0
* [Python](https://hub.docker.com/_/python): Version 3.9
* [Mysql](https://hub.docker.com/_/mysql): Version 8.0

1 - El workflow .github/workflows/buildApi.yaml realiza las siguientes acciones:
    - Login seguro a la registry dockerhub utilizando secrets de github actions. 
    - Build de imagen docker.
    - Push de imagen hacia la registry dockerhub. 
