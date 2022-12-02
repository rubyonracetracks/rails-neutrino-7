FROM ghcr.io/rubyonracetracks/docker-debian-bullseye-rvm-general

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /home/winner/neutrino

COPY . .

RUN sudo chown -R winner:winner /home/winner/neutrino && \
    cd /home/winner/neutrino && bin/build-rails
