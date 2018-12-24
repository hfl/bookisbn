# Bookisbn

Welcome to ISBN gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bookisbn'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bookisbn

## Usage

```ruby
@isbn = Bookisbn::Isbn.new "978-7-115-36646-7"

# validate ISBN
@isbn.validate?

# check ISBN
@isbn.check?

@isbn.ean_ucc      # return ISBN EAN UCC
@isbn.group        # return ISBN Group id
@isbn.publisher    # return ISBN publisher code
@isbn.title        # return ISBN publisher book title order
@isbn.check_digit  # return ISBN check digit

@isbn.thirteen        # generate ISBN with 13 digits and join with -
@isbn.thirteen(" ")   # generate ISBN with 13 digits and join with space
@isbn.ten             # generate ISBN with 10 digitsand join with -
@isbn.ten(" ")        # generate ISBN with 10 digitsand join with space
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hfl/bookisbn. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

