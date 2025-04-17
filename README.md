# README

The API for Lollipop caffeine exercise is built using Ruby on Rails 8.0.2. The
minimum ruby version is 3.2.0. Feel free to install it using either `rvm` or
`rbenv`. The database of choice is Postgres 16, but it works perfectly with
Postgres 12+.

The database config file (`config/database.yml`) was adapted to perform the
test suite using github actions. Therefore it might be necessary to modify
connection information (host, database user, database name, port) according to
local settings.

Once the database is configured you should execute

```bash
$ bin/rails db:create
$ bin/rails db:migrate
$ bin/rails db:seed
```

To have the initial caffeine data stored.

Afterwards, the only thing remaining before manual testing is running the test suite by executing

```bash
$ bundle exec rspec
```

Happy testing!
