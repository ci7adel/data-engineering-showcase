# PostgreSQL
docker run -it \
-e POSTGRES_USER="root" \
-e POSTGRES_PASSWORD="root" \
-e POSTGRES_DB="ny_taxy" \
-v ny_taxy_postgres_data:/var/lib/postgresql/data \
-p 5432:5432 \
postgres:13


pgcli -h localhost -p 5432 -u root -d ny_taxy


# PgAdmin
docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin@admin.com" \
  -e PGADMIN_DEFAULT_PASSWORD="root" \
  -p 8080:80 \
  dpage/pgadmin4

# We need a network for postgres and pgadmin we able to connect

docker network create pg-network

docker run -it \
-e POSTGRES_USER="root" \
-e POSTGRES_PASSWORD="root" \
-e POSTGRES_DB="ny_taxy" \
-v ny_taxy_postgres_data:/var/lib/postgresql/data \
-p 5432:5432 \
--network pg-network \
--name pg-database \
postgres:13

docker run -it \
  -e PGADMIN_DEFAULT_EMAIL="admin" \
  -e PGADMIN_DEFAULT_PASSWORD="admin" \
  -p 8080:80 \
  --network pg-network \
  --name pgadmin \
  dpage/pgadmin4




  # Notes

  - I had to create a volume `docker volume create ny_taxy_postgres_data` for the docker files otherwise postgres is giving me an permission error.
  - To solve this permission error I added to `/etc/wls.conf`
  ```
  [automount]
  options = "metadata,uid=1000,gid=1000,umask=22,fmask=11"
  ```
  it seems that the folder was created under my user initially, with that the folder is created under `999:root`


  ## running script

URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/yellow/yellow_tripdata_2021-01.csv.gz"

python ingest_psql.py \
  --user=root \
  --password=root \
  --host=localhost \
  --port=5432 \
  --db=ny_taxy \
  --table=yellow_ny_taxy \
  --url=${URL}