FROM python:3-alpine
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY counter-service.py ./
EXPOSE 80
ENTRYPOINT ["python3", "counter-service.py"]