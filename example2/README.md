# Terraform-aws-examples

This repository aims to practice concepts about [AWS](https://aws.amazon.com/) and [Terraform](https://www.terraform.io/).

We going to deploy an [ELB](https://aws.amazon.com/elasticloadbalancing/getting-started/) that receives HTTP requests through port 80 then It distributes them among 3 [EC2](https://docs.aws.amazon.com/autoscaling/ec2/userguide/what-is-amazon-ec2-auto-scaling.html) instances, with auto-scaling. That auto-scaling going to try keep 3 EC2 instances always running.

---

## Architecture:

Visually what we want to achieve is this:

![alt tet](https://github.com/fadavidos/terraform-aws-examples/blob/master/example2/images/Topology.png "Topoology")

---

## Remote State Storage

We're going to use [terragrunt](https://github.com/gruntwork-io/terragrunt) that allow us configure remote state automatically and provides locking by using [Amazon DynamoDB](https://aws.amazon.com/dynamodb/)

We're going to isolate state files. For the time being, we going to have 1 environment (stage). Why ? The whole point of having separate environments is that they are isolated from each other, so if you are managing all the environments from a single set of Terraform configurations, you are breaking that isolation. 

---

## ELB

ELB listens request through port 80 and then routes it to port `in_server_port` to a instance EC2

---

## Security Group

The Security Group receives requests from any ip to the given port in the variable `in_server_port`.

---

## Variables:

1. *`in_server_port`:* By default we configure port `8080` to listen to the HTTP request
2. *`in_profile`:* The name of the profile you want to use is requested. The profiles are set to `~/.aws/credentials`
3. *`in_region`:* By default the name of region is *us-east-1*.
4. *`name_instance_launch`:* By default the name of instance launch is *Terraform-asg-axample*

---

## Contenido:

A través del *user_data* en el *launch_configuration* se crea una página html con el contenido:

`Hello world, from EC2`

---

## Construir:

When you need to initialize terragrunt, then you must run next comand line:

`export AWS_PROFILE="yourProfile"`

`terragrunt init -backend-config="profile=yourProfile"`

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

---

## Consumir servicios

Con el nombre del dns del ELB podrémos acceder por curl o el navegador y obtendremos lo siguiente:

> curl myElb-1301689268.us-east-1.elb.amazonaws.com
>
> Hello world, from EC2


## How to export variables ?

> export TF_VAR_db_password="(YOUR_DB_PASSWORD)"
Admin1234$



