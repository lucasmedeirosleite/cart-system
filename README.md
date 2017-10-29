# Cart system

This application simulates a cart system.

## Pre-requisites

You need to have docker with docker-compose installed.

**P.S:** If you don't use docker you will need to have installed:

* Ruby 2.4.2
* PostgreSQL
* NodeJS

### With docker

* Make sure you give the right permissions to the scripts inside `scripts` directory. (a `chmode 777` can be used)
* Run `cp .env.sample .env`
* Run `./scripts/build`
* Run `docker-compose up`

### Without docker

* Run `cp .env.sample .env`
* Update the `DATABASE_HOST` env var value inside `.env` to `localhost`
* Change the `confic/database.yml` credentials based on your local database
* Run `bundle install`
* Run `bundle exec rails db:create db:migrate db:seed`
* Run `bundle exec rails s`

## Running specs

### With Docker

To run with docker follow these steps:

* Run `docker-compose run app bash`
* Run `rs`

### Without Docker

To run without docker follow these steps:

* Run `RAILS_ENV=test bundle exec rails db:create db:migrate`
* Run `bundle exec rspec spec`

## Libraries used

The following libraries were used to help the development of the funcionalities:

* `devise`: generate user model and handles authentication
* `materialize-sass`: used to build a more friendly UI
* `dotenv-rails`: handle ENV vars in development and test environments
* `rubocop`: lint the code
* `simplecov`: used for code coverage of specs
* `rspec-rails`: rspec for rails application
* `shoulda-matchers`: rspec matchers for rails based applications
* `timecop`: time travel easily in test environment
* `factory_bot_rails`: generate models for testing (old `factory_girl_rails`)
* `database_cleaner`: clean test database after spec finished
* `api_matchers`: rspec matchers for api based controller specs


## About the application

You can log in the application with the password `password` with the following emails:

* `joao@example.com`
* `diogo@example.com`

After logged you will see the products available in the system based in [this gist](https://gist.github.com/anonymous/cb6d271590ab1f4cf3f6ed78e524e493)

## What you can do

You can:

* Add a product to your cart
* Edit an item in your cart
* Remove an item in your cart
* Purchase your cart items

You are able to see the price you have to pay per item and the total to pay of your cart

## API

The API is an open API (unfortunatelly I did not have the time to add an API based authentication)

Path | Status | Description
--- | --- | ---
/api/products/quantity | 200, 404 | Products quantities in whole system
/api/products/amount | 200, 404 | Money to receive (per product) in whole system


### Examples

* **GET** `/api/products/quantity`

```json
{
  1: {
  	"product_name": "Learn RoR - Beginner",
	"quantity": 2
  },
  2: {
  	"product_name": "Mastering RoR - Level over 9000",
	"quantity": 3
  }
}
```

* **GET** `/api/products/amount`

```json
{
  1: {
  	"product_name": "Learn RoR - Beginner",
	"amount": "21.0"
  },
  2: {
  	"product_name": "Mastering RoR - Level over 9000",
	"amount": "9001.0"
  }
}
```
