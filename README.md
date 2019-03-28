# terraform-aws-examples

## Variables:

1. Por defecto se configura el puerto `8080` para que se escuchen las peticiones HTTP.
2. Se pide el nombre del profile que se desea utilizar. Los profiles se configuran en `~/.aws/credentials`
3. La región se deja por defecto en *us-east-1* para mostrar como definir una variable por defecto.

## Arquitectura:

Visualmente lo que queremos es llegar a esto:

![alt tet](https://github.com/fadavidos/terraform-aws-examples/blob/master/images/Topology.png "Topoología")


## Contenido:

A través del *user_data* en el *launch_configuration* se crea una página html con el contenido:

`Hello world, from EC2`