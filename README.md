# Social Network

# Table of Contents  
[Getting Started](#getting-started)

[Installation](#installation)

[Environments](#environments)

[Troubleshooting](#troubleshooting)

[Continuous Integration](#continuous-integration)

[Branching](#branching)

# Getting Started

Installing Ruby '3.1.4' with you Ruby Version Manager (rvm or rbenv)

````sh
rvm install 3.1.4

or

rbenv install 3.1.4
````

Cloning the repository

````sh
git clone git@github.com:santiago-koo/social-network.git
````

Installing Postgrsql 15 through [postgresapp](https://postgresapp.com/) (MacOS)

Creating **.env** file for environment variables with the following command:

````sh
cp .env.example .env
````
You must provide your Postgres database and AWS credentials.

Also the project is dockerized if you don't want installing the stack separately, so you must have [Docker Desktop](https://www.docker.com/products/docker-desktop/), after that, you need to create the respective image with this command:

````sh
docker-compose build
````

# Installation

## Setting up local database

Creating databases.
````sh
rails db:create

or

docker-compose run --rm web rails db:create
````

Running migrations.
````sh
rails db:migrate

or

docker-compose run --rm web rails db:migrate
````


# Environments

## Development

Running local environment with the following command:

````sh
rails server

or

docker-compose up
````

To execute tests, run the following command:

````sh
docker-compose run --rm -e RAILS_ENV=test doitcenter_app rspec
````

## Staging

TODO

## Production

TODO

# Troubleshooting
TODO

# Continuous Integration

TODO

# Branching

You can see this section in [CONTRIBUTING.md](CONTRIBUTING.md)
