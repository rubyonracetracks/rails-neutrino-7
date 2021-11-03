FROM registry.gitlab.com/rubyonracetracks/docker-debian-bullseye-rvm-rails-neutrino6

ENV DEBIAN_FRONTEND=noninteractive

COPY . .

RUN sudo chown -R winner:winner /home/winner/neutrino && \
    cd /home/winner/neutrino && bash build-rails.sh
