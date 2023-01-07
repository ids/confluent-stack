# Confluent Docker Compose Stacks for ksqlDB Tutorials and Development

This is the confluent stack with MSSQL, MySQL, MongoDB, Postgres and ElasticSearch, all tweaked to support the [Materialized Views](https://docs.ksqldb.io/en/latest/tutorials/materialized) and [Streaming ETL](https://docs.ksqldb.io/en/latest/tutorials/etl) ksqlDB tutorials, seperated into linked docker compose stacks.

Neither tutorial worked exactly as documented at the time as this writing, there were errors in the __confluent-hub__ commands to install the connectors (--worker-configs was not set to /dev/null), and the docker-compose.yml (missing docker images for latest, seems they autogenerate the docs but don't always validate the image tag), so unfortunately nothing just worked - initially.  

Also, __neither tutorial works on Windows__, oddly, since the entire example uses docker... for some odd reason the tutorials use the __confluent-hub__ command on the host, and confluent-hub does not work on Windows directly (though it seems to work in WSL2 if not blocked by a corporate security team). 

__Yet the entire example uses docker!__  

So rather then fix their tutorials one off it seemed more practical to roll everything into one development stack that could be used post-tutorial, on any platform.  

> It seems someone at Confluent does not understand the fundamental concept behind docker.  

With all this, you can jump to "start the stack" in each tutorial, and follow the Kafka related commands, which are all OS agnostic.  Everything works on Windows.

> __NOTE:__ The full stack will require a machine with at least 16GB of RAM, 32GB to be useful for development.  64GB is best. Make sure to increase your default __Docker Desktop resource settings__ to at least __16GB of RAM__ and __4 vCPU__, or the stack is likely to experience instability and resource starvation crashes (the ksqldb-server tends to die suddenly).   The stacks were broken into seperate docker compose segments to allow for easier management of machine resources.  They all connect to the same __default__ docker network created by the __confluent__ stack initially.

> On the test Windows machine Docker __Docker Swap resources__ were also increased.  The __confluent__ stack alone consumed __12.36GB of RAM__ idle at the 5 min mark.  With the __postgres-mongo-elastic__ stack added __14.04 GB RAM__.

## Stacks
All stacks are dependent on the __confluent__ stack network, which must be started first.
    
### confluent 
the confluent stack, from the downloaded original-cp-stack, modified to pre-load required connectors.
    
### mssql
joins an mssql db to the confluent stack for CDC testing

### mysql
joins a mysql db to the confuent for the mat view tutorial

### postgres-mongo-elastic
joins the postgres, mongo and elastic servers for the streaming etl tutorial


## Usage 

```
cd stacks/confluent
docker-compose up -d    # starts the confluent stack
cd ../postgres-mongo-elastic
docker-compose up -d    # starts the servers required for the streaming ETL tutorial
```

_On Windows, the command to start the stack is slightly different (no hyphen):_

```
docker compose up -d
```

## Additional Notes

Instead of doubling up on the ksqlDB server and turning it into a connect server, this approach simply connects the ksqlDB server to the connect server, the proper way, and loads the connectors at startup.  You can add additional connectors as required in the __confluent__ stack connect server startup.


