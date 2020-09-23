# nullZone
A forum

## Getting Started
These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites
In order to run the system you will need [Docker](https://www.docker.com/) and
[Docker Compose](https://docs.docker.com/compose/).

### Setup
For the setup, just run:

```
$ docker-compose up --build
```

In case you want to use seeds for the database:

```
$ docker-compose exec web bin/rails db:seed
```

## License
This project is licensed under the MIT License.
