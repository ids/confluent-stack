Then enable SQL Agent in the configuration file and restart the SQL Server service:

docker exec into the container:

```
/opt/mssql/bin/mssql-conf set sqlagent.enabled true
systemctl restart mssql-server.service
```
