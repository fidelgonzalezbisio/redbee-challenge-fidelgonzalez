# <em> Challenge técnico proceso de selección Redbee </em>

## Tabla de contenidos
1. [Objetivo](#objetivo).
2. [Tecnologias](#tecnologias).
3. [Arquitectura](#arquitectura).
4. [CI/CD](#cicd).
5. [Instalación](#instalacion).

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

## Arquitectura
***
A continuación se detalla el diagrama de arquitectura desplegado en kubernetes. 

![Diagrama de arquitectura](https://github.com/fidelgonzalezbisio/redbee-challenge-fidelgonzalez/blob/main/infra-diagram/kubernetes-infra.drawio.png)

## CI/CD
***
El proceso de Ci/CD (Continuous Integration/Continuous Delivery) con Docker es una forma increíblemente eficaz de construir, probar y desplegar aplicaciones de forma rápida y eficiente. En este caso, se crea de manera breve un Worflow de Github actions para build de imagen docker, ubicado en --> **.github/workflows/buildApi.yaml**. Este workflow de Github Actions, diseñado para realizar tareas de desarrollo de Docker, realiza los siguientes pasos:

* Primero, el workflow realiza un inicio de sesión seguro en la Registry Dockerhub utilizando los secrets de Github Actions. Esto asegura que la autenticación se realice de forma segura y que los datos de la cuenta no se divulguen.
* Una vez autenticado, el workflow procede a la construcción de la imagen Docker. Esto implica la compilación de los archivos necesarios, la creación de los contenedores, la instalación de los paquetes y la configuración necesaria para hacer que la imagen Docker se ejecute correctamente.
* Finalmente, el workflow hace un push de la imagen Docker hacia la Registry Dockerhub. Esto permite a los desarrolladores acceder a la imagen Docker desde cualquier parte y permitir a los usuarios descargarla y utilizarla.

## Instalacion
***
Una vez que tenemos nuestro repositorio clonado y un cluster de Minikube iniciado y configurado en nuestro entorno, debemos situarnos en el directorio kubernetes. 
Dentro de dicho directorio tendremos el siguiente listado de archivos yaml:
```
1-namespace.yaml
2-ingress.yaml
3-services.yaml
4-secrets.yaml
5-volumes.yaml
6-configmap.yaml
7-mysqlDeploy.yaml
8-apiDeploy.yaml
pod-test.yaml
start-infra.sh
```

Para iniciar el cluster, basta con ejecutar el script start-infra.sh, el cual se encarga de ejecutar todos los archivos yaml y realizar un testeo sobre la url del ingress. El resultado debería ser algo asi.

```
➜  kubernetes git:(main) ✗ ./start-infra.sh
namespace/redbee-env unchanged
1-namespace.yaml OK
ingress.networking.k8s.io/simpsonsquotes-ingress unchanged
2-ingress.yaml OK
service/api-service unchanged
service/mysql unchanged
3-services.yaml OK
secret/mysql-secret unchanged
secret/api-secret unchanged
4-secrets.yaml OK
persistentvolume/mysql-pv-volume unchanged
persistentvolumeclaim/mysql-pv-claim unchanged
5-volumes.yaml OK
configmap/mysql-initdb-config unchanged
6-configmap.yaml OK
deployment.apps/mysql unchanged
7-mysqlDeploy.yaml OK
deployment.apps/redbee-challenge unchanged
8-apiDeploy.yaml OK
Wait for URLs: http://192.168.49.2:30199
Testing http://192.168.49.2:30199
http://192.168.49.2:30199 - OK!
[{"id":"1","quote":"Yo no fui!"},{"id":"2","quote":"Doh!"},{"id":"3","quote":"A la grande le puse cuca"},{"id":"4","quote":"Plan dental! Lisa necesita frenos!"},{"id":"5","quote":"La comida va aqui! Claro que si!"},{"id":"6","quote":"Si es claro y amarillo seguro que es juguillo, si es turbio y picoson es sidra muchachon"},{"id":"7","quote":"Ay! ese perro tiene la cola peluda"}]% 
```