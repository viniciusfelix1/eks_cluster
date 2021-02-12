FROM imega/mysql-client
COPY backup.sql /
COPY script.sh /

ENTRYPOINT ["sh", "/script.sh"]
#RUN MYSQL_PW=$(echo "${MYSQL_PW}" | base64 -d) \
#    && echo "$MYSQL_PW ${MYSQL_HOST} ${MYSQL_USER} ${MYSQL_NAME}"\
#    && mysql -h ${MYSQL_HOST} -u ${MYSQL_USER} -p ${MYSQL_NAME}
 #< backup.sql
#ENTRYPOINT ["mysql"]
#CMD ["-h", "${MYSQL_HOST}", "-u", "${MYSQL_USER}", "-p{MYSQL_PW}", "${MYSQL_NAME}", "<", "backup.sql"]
