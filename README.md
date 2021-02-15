# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Setting up the development environment

```
# Start the database server
docker-compose up -d db

# Initialize the database
bundle exec rails db:setup

# Set up image storage
bundle exec rails active_storage:install

# Migrate database schemas
bundle exec rails db:migrate

# Set up javascript files
yarn

# Start application server
bundle exec rails s
```


## Development tips

Create a new model and its associated CRUD stuff with `bundle exec rails
generate scaffold <model_name>`.

### Prototyping models without user creation

Once you have postgres running in docker, connect to it with
```
psql postgresql://postgres:postgres@localhost:5432
```
you may need to expose its default ports in the docker configuration.

Now connect to the database:
```
postgres=# \c app_development
psql (10.14, server 13.1 (Debian 13.1-1.pgdg100+1))
WARNING: psql major version 10, server major version 13.
         Some psql features might not work.
You are now connected to database "app_development" as user "postgres".
```

Figure out which data types the user schema uses:
```
app_development=# select column_name, data_type from information_schema.columns where table_name = 'users';
 column_name |          data_type          
-------------|-----------------------------
 id          | bigint
 username    | character varying
 password    | character varying
 created_at  | timestamp without time zone
 updated_at  | timestamp without time zone
(5 rows)
```

Now insert a test user:
```
app_development=# insert into users (id, username, password, created_at, updated_at) values (0, 'testuser', 'password', now(), now());
INSERT 0 1
app_development=# select * from users;
 id | username | password |         created_at         |         updated_at     
    
----|----------|----------|----------------------------|------------------------
----
  0 | testuser | password | 2021-02-15 03:36:06.477456 | 2021-02-15 03:36:06.477
456
(1 row)

```
