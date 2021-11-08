# Frequently Asked Questions

## Why is this repository on GitLab instead of GitHub?

I was unable to get continuous integration for Rails Neutrino to work in GitHub Workflows or CircleCI.  GitHub Workflows and CircleCI work for existing Ruby on Rails apps, but they didn't work for me for testing Rails Neutrino, which creates a new Rails app from scratch.  GitLab CI works better for testing Rails Neutrino.

## What problems did GitHub Workflows and CircleCI have that GitLab resolved?

* Docker behaves very differently in the GitHub Workflows and CircleCI environments than it does on my local machine.  The Docker environment in those CI environments had permissions issues that I never had on my local machine.  Directories and files that were owned by the user "winner" in my local Docker environment were owned by the root user in Docker within GitHub Workflows and CircleCI.

* GitLab CI had fewer of these weird permissions issues compared to GitHub Workflows and CircleCI.  The build-rails.sh script behaves the same way in the Docker environment of GitLab CI as it does in the Docker environment on my local machine.

## Why doesn't the continuous integration script use Docker Compose?

Docker Compose behaves very differently in the continuous integration environments than it does on my local machine.  Running the docker/build script on the newly created Rails app works on my local machine but results in weird permissions issues in the continuous integration environments, including the GitLab CI environment.

## Why must the continuous integration setup use the "docker build" command?  Why didn't you just pick a Ruby environment to run the build-rails.sh script?

* GitHub Workflows and CircleCI require specifying a version number for the Ruby version.  This has to be manually updated from time to time.  On the other hand, the Docker image specified in the Dockerfile is automatically updated on a daily basis and always has the latest stable version of Ruby.

* I also encountered permissions issues when trying to run GitHub Workflows and CircleCI when running the build-rails.sh script in the Ruby environment.
