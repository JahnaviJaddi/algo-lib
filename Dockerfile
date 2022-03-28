FROM tiangolo/uvicorn-gunicorn-fastapi:python3.7

COPY requirements.txt ./

ARG NODE_ENV=development
ARG PORT=3000
ENV PORT=$PORT

RUN python3 -m venv env
RUN ./env/Scripts/activate 
RUN apt-get update
RUN apt-get install ffmpeg libsm6 libxext6  -y
RUN apt-get install -y libgl1-mesa-dev
RUN apt-get update && apt-get install -y python3-opencv
RUN pip install opencv-python
RUN apt-get install python3-opencv

#RUN pip3 install torch==1.9.0+cu111 torchvision==0.10.0+cu111 torchaudio===0.9.0 -f https://download.pytorch.org/whl/torch_stable.html --user
RUN pip install -r requirements.txt




COPY ./app /app/app
COPY ./model_weights /app/model_weights

EXPOSE $PORT

#CMD uvicorn app.main:app --host 0.0.0.0 --port $PORT