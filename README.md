# timeoff-management


### Diagram
<p align="center">
  <img src="diagram.png" width="550" title="hover text">
</p>

#### the solution is executed by pushing to the main branch and deploying to aws in an ec2 instance inside it creates the docker container


## implementation:
Clone the repo
terraform init
terraform plan
terraformapply

In case you want to modify, you must start from the code found at: https://github.com/timeoff-management/timeoff-management-application
At the end of the modifications you must do:

Build:

$ docker build -t timeoff .

Run:

$ docker run -e NODE_ENV=production -e MYSQL_USER=timeoff timeoff


tags:

docker tag timeoff jaimesan/timeoff-management:v<next-version>