# In Development...

psql "postgresql://root@cockroach:26257?sslcert=%2Fcerts%2Fclient.root.crt&sslkey=%2Fcerts%2Fclient.root.key&sslmode=verify-full&sslrootcert=%2Fcerts%2Fca.crt"

SET cluster setting server.host_based_authentication.configuration = 'host all all all gss include_realm=0';

create user tester;

grant all on database defaultdb to tester;

database=test

psql "postgresql://cockroach:26257/test?sslmode=require" -U tester
