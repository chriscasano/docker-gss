FROM alpine:3.9

RUN apk add --no-cache \
  krb5-server \
  && rm -rf /var/cache/apk/*

COPY krb5.conf /etc/krb5.conf

RUN kdb5_util create -s -P kpass \
  && kadmin.local -q "addprinc -pw psql tester@MY.EX" \
  && kadmin.local -q "addprinc -randkey postgres/cockroach@MY.EX" \
  && kadmin.local -q "addprinc -randkey postgres/psql@MY.EX" \
  && kadmin.local -q "addprinc -randkey postgres/gss_cockroach_1.gss_default@MY.EX"
  #  && kadmin.local -q "addprinc -randkey DOCKER-GSS_DEFAULT@MY.EX" \
  #  && kadmin.local -q "addprinc -randkey postgres/DOCKER-GSS_DEFAULT@MY.EX" \

CMD ["/start.sh"]
