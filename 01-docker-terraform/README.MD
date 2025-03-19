## running script
- First run postgres and pgadmin from `docker compose`
- select the network and postgres host from `docker compose`

```bash
docker compose up

URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"

docker build -t taxi_ingest .
docker run --network=2_docker_sql_default taxi_ingest \
  --user=root \
  --password=root \
  --host=pgdatabase \
  --port=5432 \
  --db=ny_taxy \
  --table=yellow_ny_taxy \
  --url=${URL}
```

# Terraform
- Install terraform
- Create a service account in GCP and create key file
```bash
terraform init
```



# Notes

- I had to create a volume `docker volume create ny_taxy_postgres_data` for the docker files otherwise postgres is giving me an permission error.
- To solve this permission error I added to `/etc/wls.conf`
```
[automount]
options = "metadata,uid=1000,gid=1000,umask=22,fmask=11"
```
it seems that the folder was created under my user initially, with that the folder is created under `999:root`
- To upload a file to a vm machine
```bash
sftp machine # needs a .ssh/config
put file # upload a file from the local folder to machine
```


- pgcli -h localhost -p 5432 -u root -d ny_taxy


