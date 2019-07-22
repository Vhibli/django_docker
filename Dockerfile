# pull official base image
FROM python:3.7

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip setuptools virtualenv

# create user for the Django project
RUN useradd -ms /bin/bash myproject

# set current user
USER myproject

# set work directory
WORKDIR /home/myproject

# create and activate virtual environment
RUN virtualenv venv

# copy and install pip requirements
COPY --chown=myproject ./src/myproject/requirements.txt /home/myproject/
RUN ./venv/bin/pip3 install -r /home/myproject/requirements.txt

# copy Django project files
COPY --chown=myproject ./src/myproject /home/myproject/
