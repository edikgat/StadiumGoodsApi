# StadiumGoodsApi
- [Grape](https://github.com/ruby-grape/grape) For fast and well designed API
- [Swagger](https://swagger.io/) for interactive api documentation
- Latest Rails without activerecord for flexibility, live documentation and caching purposes (Swager need rails sprockets to show interactive api documentation)
- Latest Ruby (2.6.5)
- [RSpec](https://github.com/rspec/rspec) For Tests
- Tests Coverage 99% by [SimpleCov](https://github.com/colszowka/simplecov)
- Code Inspected by [RuboCop](https://github.com/rubocop-hq/rubocop)
- [Pry](https://github.com/pry/pry) For Easy Debugging And Code Inspecting
- Based on [Typhoeus](https://github.com/typhoeus/typhoeus) parallel requests sending
- For sending requests for each social network used special pull of parallel requests (10 by default, but configurable), with restarting failed requests, until first success request with json body. Maximum number of restarts is also configurable parameter (30 by default), if after 30 restarts we still not have any success json response, we will return empty array
- Each social network also pulling at parallel way
- In average, successful result, from all social networks, without caching is obtained in less than 0.7 seconds
- Success response from social network will be cached, and stored for 1 minute (can be changed)
- To allow caching please create `tmp/caching-dev.txt` file

## Requirements
- Ruby = 2.6.5

## Setup
- Goto project's folder in your terminal
- Run `bundle install`

## Setup
- Goto project's folder in your terminal
- Run `bundle install`

## Run API
- Start server `rails s`
- Go to `http://localhost:3000/`

## API Documantation
- Start server `rails s`
- Go to `http://localhost:3000/documentation`

## Running tests
- `rspec spec/`

## Tests Coverage Report
- Not At `.gitignore` for easy review
- Open In Browser `coverage/index.html`

## Code Quality report
- Run `rubocop`
