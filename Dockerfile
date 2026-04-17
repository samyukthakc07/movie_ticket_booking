FROM python:3.12-slim

WORKDIR /app

COPY . .

RUN pip install --upgrade pip && \
    if [ -f requirements.txt ]; then pip install -r requirements.txt; else pip install django gunicorn; fi

EXPOSE 8000

CMD ["sh", "-c", "export DJANGO_DEBUG=True && export DJANGO_SECRET_KEY=abc123 && python manage.py runserver 0.0.0.0:8000"]