# Incoming

A nice way to parse incoming data.

At Everyday Hero we use this to massage data coming through the private API.

## Installation

Add this line to your application's Gemfile:

    gem 'incoming', github: 'everydayhero/incoming'

And then execute:

    $ bundle install

## Usage

Create a receiver for any resource that you are interested in listening for.

``` ruby
class Receivers::Charity
  attr_accessor :name

  def initialize attributes = nil
    attributes ||= {}

    attributes.slice(*accepted_attributes).each do |attr, value|
      send "#{attr}=", value
    end
  end

  def self.payload_key
    'charity'
  end

  def accepted_attributes
    %w(name)
  end

  def receive
  end
end
```

There are a couple of important points to note about receivers. Firstly you must define a class method called `payload_key` which holds the value of the root node of the payload you wish this class to receive. Secondly is the list of accepted attributes, these are attributes that are known about and this class can handle. And lastly is the receive method, this needs to return `true` or `false` depending on what you do with the data.

Register the receiver with the registry in an initializer.

``` ruby
Incoming.receivers.register Receivers::Charity
```

The receiver will then be available for use in the controller handling incoming payloads.

``` ruby
class API::Private::Incoming
  def receive
    receiver = Incoming.receivers.for payload
  end

  def payload
    ActiveSupport::JSON.decode params.fetch(:payload, '{}')
  end
end
```

There is an included `Lint` test for ensureing receivers follow the expected API. It's as simple as including it.

``` ruby
module Receivers
  class CharityTest < MiniTest::Unit::TestCase
    inlcude Incoming::Lint::Tests

    def model
      Charity.new
    end
  end
end
```

Currently the receiver has a very opinionated viewpoint on the payload that it expects, it needs to be a hash with a root node.

``` ruby
payload = {
  'charity' => {
    'name' => 'Starlight'
  }
}
```

If there are no registered receivers for a payload then `Incoming::Unknown` will be used. It conforms to the receiver interface.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
