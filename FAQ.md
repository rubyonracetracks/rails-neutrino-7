# Frequently Asked Questions

## Why doesn't the continuous integration script use Docker Compose?

Docker Compose behaves very differently in the continuous integration environments than it does on my local machine.  Running the docker/build script on the newly created Rails app works on my local machine but results in weird permissions issues in the continuous integration environments.

## Why must the continuous integration setup use the "docker build" command?  Why didn't you just pick a Ruby environment to run the build-rails.sh script?

CI environemnts require specifying a version number for the Ruby version.  This has to be manually updated from time to time.  On the other hand, the Docker image specified in the Dockerfile is automatically updated on a daily basis and always has the latest stable version of Ruby.

