# Load testing files

This folder contains load testing files and utilities for running load tests.

## How to run a load test locally

Make sure the application and database servers are running, then run
```
docker-compose up
```
to start the load test. The Tsung GUI server will stay open until you manually
close it--either with the "Stop" button in the GUI, or by Ctrl+C twice.

By default, the load test will use `simple.xml`. You can change some of the
settings in `docker-compose.yml` to use a different file.
