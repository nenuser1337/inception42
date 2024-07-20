FROM alpine:3.20.1

RUN apk update && apk upgrade
RUN apk add --no-cache mariadb mariadb-client

RUN sed -i "s|skip-networking|skip-networking=0|g" /etc/my.cnf.d/mariadb-server.cnf && \
    sed -i "s|#bind-address=0.0.0.0|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

RUN mkdir -p /run/mysqld /var/lib/mysql
RUN chown -R mysql:mysql /run/mysqld /var/lib/mysql
RUN chmod 777 /run/mysqld

COPY requirements/mariadb/conf/start.sh /usr/local/bin/db
RUN chmod +x /usr/local/bin/db

USER mysql

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

CMD ["/bin/sh", "/usr/local/bin/db"]