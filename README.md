# nullZone
A forum

## Getting Started

These instructions will get you a copy of the project up and running on your local machine.

### Prerequisites

In order to run the system you will need:

```
Ruby 2.7.1
Ruby on Rails 5.2.3 or higher
PostgreSQL
```

### Setup

To set up the gems, run:

```
$ bundle install
```

You may need to create a new role named nullzone in postgresql:

```
postgres=# CREATE ROLE nullzone WITH CREATEDB LOGIN PASSWORD 'password'
```

To setup the database, use:

```
$ bin/rails db:setup
```

The above command will populate the database using seeds. In case you don't want that:

```
$ bin/rails db:create
$ bin/rails db:schema:load
```

To get the server running:

```
$ bin/rails server
```

## License

This project is licensed under the MIT License.
