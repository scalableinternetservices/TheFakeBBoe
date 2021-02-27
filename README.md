
## Deploy to beanstalk
```
ssh -i TheFakeBBoe.pem TheFakeBBoe@ec2.cs291.com
```

```
cd TheFakeBBoe
git pull origin main
eb init --keyname $(whoami) \
  --platform "64bit Amazon Linux 2 v3.2.2 running Ruby 2.7" \
  --region us-west-2 TheFakeBBoe
```

```
eb create --envvars SECRET_KEY_BASE=BADSECRET \
  -db.engine postgres -db.i db.t3.micro -db.user u \
  -i t3.micro --single INSERT_SOME_NAME_HERE
```

After 10-20 minutes, it will finish. Run:
```
eb status INSERT_SOME_NAME_HERE
```
The status should be `Green` and the url is next to the `CNAME`.

## Load Testing

First, ssh into the ec2 instance

In the root folder, there should be this file: `TheFakeBBoe_web_credentials.txt`. It has the url, username, and password to login to the AWS console. 

Then, run this:

```
launch_tsung.sh
```

You will then see something like: `ssh ec2-user@SOMETHINGHERE`
Give it a few seconds before trying it. If you ssh immediately after it shows up, you will get a connection timeout.
SSH into the tsung instance to start load testing. 

## Run tsung_load tests

There is an example load test `tsung_example.xml`. Modify the file or write a new one and make sure you change the server tag to be the deployed instance.

Run
```
tsung -f tsung_example.xml -k start
```

It takes a while to run. You will know when it is done because you will see: `All slaves have stopped; keep controller and web dashboard alive. 
Hit CTRL-C or click Stop on the dashboard to stop.`

# View Tsung Logs

Log into the AWS console with TheFakeBBoe credentials and view all the EC2 instances. Make sure that the AWS region is set to Oregon (in the top right corner).
One of the instances will be `tsung-TheFakeBBoe` (or multiple of them if we are all running load tests at the same time). Figure out which one is yours, then click on the Instance ID. Copy-paste the public IPv4 address into the browser to view all the stats.


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

#### Rails console method

Once you have postgres running in docker, run `bundle exec rails console`:
```
irb(main):006:0> user = User.new({ :id => 0, :username => "testuser", :password => "password" })
irb(main):007:0> user.save
  TRANSACTION (0.2ms)  BEGIN
  User Create (0.6ms)  INSERT INTO "users" ("id", "username", "password", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5) RETURNING "id"  [["id", 0], ["username", "testuser"], ["password", "password"], ["created_at", "2021-02-16 02:28:43.461203"], ["updated_at", "2021-02-16 02:28:43.461203"]]
  TRANSACTION (5.9ms)  COMMIT
=> true
irb(main):008:0> user
=> #<User id: 0, username: "testuser", password: [FILTERED], created_at: "2021-02-16 02:28:43.461203000 +0000", updated_at: "2021-02-16 02:28:43.461203000 +0000">

```

#### Manual method

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



