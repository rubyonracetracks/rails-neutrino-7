FROM ghcr.io/rubyonracetracks/docker-debian-bullseye-rvm-general

ENV DEBIAN_FRONTEND=noninteractive

COPY . .

RUN sudo chown -R winner:winner /home/winner/neutrino && \
    cd /home/winner/neutrino && bash build-rails.sh
