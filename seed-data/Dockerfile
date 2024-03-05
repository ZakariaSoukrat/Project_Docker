FROM python:3.9

WORKDIR /app

COPY . .

RUN apt-get update \
    && apt-get install -y dos2unix apache2-utils \
    && dos2unix generate-votes.sh \
    && pip install urllib3

CMD python make-data.py && chmod +x ./generate-votes.sh && ./generate-votes.sh; tail -f /dev/null

#remove tail - f /dev/null to let the container shut after completing the task
