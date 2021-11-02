# Specify the Docker image to use as a base:
FROM registry.gitlab.com/rubyonracetracks/docker-debian-bullseye-rvm-rails-neutrino6

ENV DEBIAN_FRONTEND=noninteractive

RUN sudo sed -i '/deb-src/d' /etc/apt/sources.list && \
    sudo apt-get update && \
    sudo apt-get install -y build-essential libsqlite3-dev sqlite3 tree graphviz
