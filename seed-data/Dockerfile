FROM python:3.13-rc-slim

RUN apt-get update && apt-get install -y apache2-utils
WORKDIR /seed
COPY . .
RUN chmod +x ./generate-votes.sh

RUN apt-get install dos2unix && dos2unix ./generate-votes.sh
RUN  python3 make-data.py
CMD ["bash", "./generate-votes.sh"]
