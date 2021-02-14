FROM imega/mysql-client
COPY backup.sql /
COPY script.sh /

ENTRYPOINT ["sh", "/script.sh"]
