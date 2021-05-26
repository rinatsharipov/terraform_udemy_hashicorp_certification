
* docker run --name postgres_12.7 -p 5432:5432 -e POSTGRES_USER=terraform -e POSTGRES_PASSWORD=terraform -e POSTGRES_DB=terraform -d postgres:12.7
* terraform init -backend-config="conn_str=postgres://terraform:terraform@localhost:5432/terraform?sslmode=disable"
* terraform apply
* terraform output ec2-ip
