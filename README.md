# README

Small Rails app with API endpoint which receives reservation payloads from different Hometime partners

## Dependencies

Ruby 3.1.2
SQLite3

## Usage

Ensure the database has been created and migrations have been run.
Start up the web server with default config with `bin/rails server`, then to simulate an example reservation:

```console
curl -X POST http://127.0.0.1:3000/v1/reservations \
   -H 'Content-Type: application/json' \
   -d @spec/fixtures/airbnb_payload.json
```

## Tests

```console
bundle exec rspec
```