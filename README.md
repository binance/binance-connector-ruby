# Binance Connector Ruby

[![Gem Version](https://badge.fury.io/rb/binance-connector-ruby.svg)](https://badge.fury.io/rb/binance-connector-ruby)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop-hq/rubocop)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

This is a lightweight library that works as a connector to [Binance public API](https://github.com/binance/binance-spot-api-docs). It’s designed to be simple, clean, and easy to use with minimal dependencies.

- Supported APIs:
    - `/api/*`
    - `/sapi/*`
    - Spot Websocket Market Stream
    - Spot User Data Stream
- Inclusion of test cases and examples
- Customizable base URL, request timeout
- Response metadata can be displayed
- Customizable Logger

## Installation

1. Include the library in Gemfile and then install it when execute the bundler.

	Add this line in the Gemfile.

	```ruby
	gem 'binance-connector-ruby'
	```

	And then execute the bundler via CLI:

  ```shell
   bundle
  ```
2. Install it with CLI:
  ```shell
  gem install binance-connector-ruby
  ```

## Documentation

[https://www.rubydoc.info/gems/binance-connector-ruby](https://www.rubydoc.info/gems/binance-connector-ruby)

## Restful APIs

```ruby
require 'binance'

# Create a new client instance.
# If the APIs do not require the keys, (e.g. market data), key and secret can be omitted.
client = Binance::Spot.new(key: key, secret: secret)

# Send a request to query server time
puts client.time

# Send a request to query BTCUSDT ticker
puts client.ticker_24hr(symbol: 'BTCUSDT')

# Send a request to get account information
puts client.account

# Place an order
response = client.new_order(symbol: 'BNBUSDT', side: 'BUY', price: 20, quantity: 1, type: 'LIMIT', timeInForce: 'GTC')
```


Please find `examples` folder to check for more endpoints.


### Testnet

While `/sapi/*` endpoints don't have testnet environment yet, `/api/*` endpoints can be tested in 
[Spot Testnet](https://testnet.binance.vision/). You can use it by changing the base URL:

```ruby
client = Binance::Spot.new(base_url: 'https://testnet.binance.vision')
puts client.time
```

### Base URL

If `base_url` is not provided, it defaults to `api.binance.com`.

It's recommended to pass in the `base_url` parameter, even in production as Binance provides alternative URLs in case of performance issues:

- `https://api1.binance.com`
- `https://api2.binance.com`
- `https://api3.binance.com`

### Proxy

If you need to use a proxy you can define `proxy_url`

```
client = Binance::Spot.new(base_url: 'https://api1.binance.com', proxy_url: 'http://myproxy.com')
```

### RSA Signature

Binance support both HMAC and RSA signature. Please find the example at `examples/trade/account.rb` for how to sign in both solutions.

### RecvWindow

From Binance API, recvWindow is available for all endpoints require signature. By default, it's 5000ms.
You are allowed to set this parameter to any value less than 60000, number beyond this limit will receive error from Binance server.
```ruby

response = client.account(recvWindow: 2_000)

```

### Optional parameters

For the optional parameters in the endpoint, pass exactly the field name from API document into method.
e.g

```ruby
client = Binance::Spot.new

# correct
response = client.cancel_order(symbol: 'BNBUSDT', orderId: 25)

# this is incorrect
response = client.cancel_order(symbol: 'BNBUSDT', order_id: 25)
```

### Timeout

Timeout (unit: second) can be specified when initializing a client instance. If `timeout` is not set, the default is **no timeout**.

```ruby
client = Binance::Spot.new(timeout: 2)
```

### Response Metadata

The Binance API server provides weight usages in the headers of each response. This information can be fetched from `headers` property. `x-mbx-used-weight` and `x-mbx-used-weight-1m` show the total weight consumed within 1 minute. This is very useful to indentify the current usage.
To display this value, specify `show_weight_usage: true` when intializing a new client instance.

```ruby
client = Binance::Spot.new(show_weight_usage: true)
```

Then, take server time API (`GET /api/v3/time`) as an example, the response data is shown as below:

```ruby
{:data=>{:serverTime=>1589860878546}, :weight_usage=>{"x-mbx-used-weight"=>"1", "x-mbx-used-weight-1m"=>"1"}}
```

When `show_header: true`, the library has the ability to print out all response headers, which may be very helpful for debugging the program.

```ruby
client = Binance::Spot.new(show_header: true)
```

Then, take the same example as above, the response data becomes:

```ruby
{:data=>{:serverTime=>1589863539220}, :header=>{"content-type"=>"application/json;charset=utf-8",...}}
```

### Custom Logger Integration

The client class accepts a [Logger](https://ruby-doc.org/stdlib-2.4.0/libdoc/logger/rdoc/Logger.html) instance as an input parameter.

```ruby
logger = Logger.new(STDOUT)
client = Binance::Spot.new(logger: logger)
logger.info(client.time)
```

### Exception

There are 3 types of exceptions:
- `Binance::RequiredParameterError`
  - When missing required param
  - Not sending out the request
- `Binance::ClientError`
  - This is thrown when API server returns `4XX`, it's an issue from client side.
  - The following properties may be helpful to resolve the issue:
    - Response header - Please refer to `Response Metadata` section for more details.
    - HTTP status code
    - Error code - Server's error code, e.g. `-1102`
    - Error message - Server's error message, e.g. `Unknown order sent.`
    - Request config - Configuration send to the server, which can include URL, request method and headers.
- `Binance::ServerError`
  - When API server returning 5XX
  - sending out the request

They all inherit from `Binance::Error`

```ruby
begin
  response = client.time
rescue Binance::ClientError => e
  e.response[:status]
  e.response[:headers]
  e.response[:body]
end
```

## Websocket

```ruby
require 'binance'
require 'eventmachine'

client = Binance::Spot::WebSocket.new

EM.run do
  onopen = proc { logger.info('connected to server') }
  onmessage = proc { |msg, _type| logger.info(msg) }
  onerror   = proc { |e| logger.error(e) }
  onclose   = proc { logger.info('connection closed') }

  callbacks = {
    onopen: onopen,
    onmessage: onmessage,
    onerror: onerror,
    onclose: onclose
  }

  client.kline(symbol: 'btcusdt', interval: '30m', callbacks: callbacks)
end
```

More websocket examples are available in the `examples` folder

### Auto response
Binance requires `pong` for heartbeat, response is sent automatically.

## Limitation

Futures and Vanilla Options APIs are not supported:

  - `/fapi/*`
  - `/dapi/*`
  - `/vapi/*`
  -  Associated Websocket Market and User Data Streams
