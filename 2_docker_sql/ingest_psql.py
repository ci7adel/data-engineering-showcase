import pandas as pd
import argparse
import os
from time import time
from sqlalchemy import create_engine


def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table = params.table
    url = params.url
    csv = 'output.csv.gz'

    os.system(f"wget {url} -O {csv}")

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')
    df = pd.read_csv(csv, nrows=100)

    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)


    print(pd.io.sql.get_schema(df, name=table, con=engine))


    df.head(n=0).to_sql(name=table, con=engine, if_exists="replace")

    df_iter = pd.read_csv(csv, iterator=True, chunksize=100000)

    while True:
        t_start = time()
        df = next(df_iter)
        df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
        df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
        df.to_sql(name="yellow_taxi_data", con=engine, if_exists="append")

        t_end = time()

        print("inserted another chunk, took %.3f second" % (t_end - t_start))



if __name__ == '__main__':
    
    parser = argparse.ArgumentParser(
        description="Ingest data CSV to PostgresSQL",
    )

    parser.add_argument('--user')
    parser.add_argument('--password') 
    parser.add_argument('--host') 
    parser.add_argument('--port') 
    parser.add_argument('--db') 
    parser.add_argument('--table') 
    parser.add_argument('--url') 
    params = parser.parse_args()

    print(params)
   
    
    main(params)