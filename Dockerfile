FROM python:3.5

# Apt-install mysql client and cleanup temporary files afterwards
RUN apt-get update && apt-get install -y mysql-client git vim && apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY requirements.txt /tmp/requirements.txt

RUN python3.5 -m pip install --trusted-host content.dev.faforever.com -r /tmp/requirements.txt

ADD . /code/
WORKDIR /code/

RUN python3.5 -m pip install -e .

# Main entrypoint and the default command that will be run
CMD ["./server.py"]

# Game server runs on 8000/tcp, lobby server runs on 8001/tcp, nat echo server runs on 30351/udp
EXPOSE 8000 8001 30351

RUN python3.5 -V
