#!/bin/sh

set -e

# The /keytab directory is volume mounted on both kdc and cockroach. kdc
# can create the keytab with kadmin.local here and it is then useable
# by cockroach.

kadmin.local -q "ktadd -k /keytab/crdb.keytab postgres/gss_cockroach_1.gss_default@MY.EX"
kadmin.local -q "ktadd -k /keytab/crdb.keytab postgres/cockroach@MY.EX"
kadmin.local -q "ktadd -k /keytab/crdb.keytab postgres/psql@MY.EX"
kadmin.local -q "ktadd -k /keytab/crdb.keytab postgres/docker-gss_default@MY.EX"
#kadmin.local -q "ktadd -k /keytab/crdb.keytab postgres/DOCKER-GSS_DEFAULT@MY.EX"

krb5kdc -n
