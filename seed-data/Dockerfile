FROM python:3.9
WORKDIR /app
COPY make-data.py .
RUN pip install urllib3
CMD ["python", "make-data.py"]