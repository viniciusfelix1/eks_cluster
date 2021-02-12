#!/bin/sh
MYSQL_PW=$(echo "${MYSQL_PW}" | base64 -d)

if [ ! -z "$MYSQL_PW"  ]; then
   mysql -h ${MYSQL_HOST} -u ${MYSQL_USER} -p${MYSQL_PW} ${MYSQL_NAME} < backup.sql
 else
   echo "NÃo foi identificado senha, fazendo a conexÃo sem senha."
   mysql -h ${MYSQL_HOST} -u ${MYSQL_USER} ${MYSQL_NAME} < backup.sql
fi

if [ $? -eq 0 ]; then
   echo "Restore realizado com exito."
 else
   echo "Falha ao restaurar o backup."
fi
