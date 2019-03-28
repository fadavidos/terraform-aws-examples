# terraform-aws-examples

Repositorio con el proposito de poner en práctica conocimientos sobre [AWS](https://aws.amazon.com/) y [Terraform](https://www.terraform.io/)

---

## Arquitectura:

Visualmente lo que queremos es llegar a esto:

![alt tet](https://github.com/fadavidos/terraform-aws-examples/blob/master/images/Topology.png "Topoología")

---

## Variables:

1. Por defecto se configura el puerto `8080` para que se escuchen las peticiones HTTP.
2. Se pide el nombre del profile que se desea utilizar. Los profiles se configuran en `~/.aws/credentials`
3. La región se deja por defecto en *us-east-1* para mostrar como definir una variable por defecto.

---

## Contenido:

A través del *user_data* en el *launch_configuration* se crea una página html con el contenido:

`Hello world, from EC2`

---

## Construir:

Inicializar terraform:
`terraform init`

Ver el resumen de lo que se ejecutará:
`terraform apply`

---

## Outputs:

>Outputs:
>
>out_dns_elb = myElb-1301689268.us-east-1.elb.amazonaws.com

Existe un *output* con el nombre del DNS del ELB, que será usado para acceder al servicio a través del navegador o curl:

> curl myElb-1301689268.us-east-1.elb.amazonaws.com
> Hello world, from EC2
