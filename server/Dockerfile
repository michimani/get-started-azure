FROM python:3.11-buster as builder

WORKDIR /opt/app

COPY requirements.lock /opt/app/
RUN pip3 install -r requirements.lock

FROM python:3.11-slim-buster as app

COPY ./app .

COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages/
COPY --from=builder /usr/local/bin/uvicorn /usr/local/bin

CMD ["/usr/local/bin/uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]