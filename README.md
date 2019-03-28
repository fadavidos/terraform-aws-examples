# Terraform-aws-examples

Repositorio con el proposito de poner en práctica conocimientos sobre [AWS](https://aws.amazon.com/) y [Terraform](https://www.terraform.io/)

Se va a desplegar un (ELB)[https://aws.amazon.com/elasticloadbalancing/getting-started/] que recibe peticiones HTTP por el puerto 80 y las distribuye entre 3 instancias de (EC2)[https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html] auto estacaldas, que tratará de mantener 3 instancias siempre disponibles.

---

## Arquitectura:

Visualmente lo que queremos es llegar a esto:

![alt tet](https://github.com/fadavidos/terraform-aws-examples/blob/master/images/Topology.png "Topoología")

### ELB

El ELB escucha peticiones por el purto 80 y las enruta al puerto dado en la variable `in_server_port`

### Security Group

El Security Group recibe peticiones de cualquier ip al puerto dado en la variable `in_server_port`

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
`terraform plan`

Finalmente para aplicar los cambios, se ejecuta:
`terraform apply`

---

## Outputs:

Al ejecutar `terraform apply` se mostraran las variables de salida:


>Outputs:
>
>out_dns_elb = myElb-1301689268.us-east-1.elb.amazonaws.com


Con el nombre del dns del ELB podrémos acceder por curl o el navegador y obtendremos lo siguiente:

> curl myElb-1301689268.us-east-1.elb.amazonaws.com
>
> Hello world, from EC2
