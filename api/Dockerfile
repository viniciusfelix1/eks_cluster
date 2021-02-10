FROM python:slim-buster

WORKDIR /app
COPY ./app /app/

RUN pip install -r requirements.txt

EXPOSE 80

ENTRYPOINT [ "python" ]
CMD [ "main.py" ]
