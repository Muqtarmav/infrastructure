FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt /app

RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 5000

ENTRYPOINT ["python3"]

CMD ["app.py"]
