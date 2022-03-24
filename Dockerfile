FROM tiangolo/uvicorn-gunicorn-fastapi:python3.7

COPY requirements.txt ./

ARG NODE_ENV=development
ARG PORT=3000
ENV PORT=$PORT

RUN pip install -r requirements.txt

COPY ./app /app/app
COPY ./model_weights /app/model_weights

EXPOSE $PORT

CMD ["npm", "run", "start"]
CMD uvicorn app.main:app --host 0.0.0.0 --port $PORT