FROM ghcr.io/open-education-hub/vmcheker-next-base-image/base-container:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN echo "Hello from Docker"

RUN apt update -y

RUN apt install -y octave python3

COPY ./checker ${CHECKER_DATA_DIRECTORY}
