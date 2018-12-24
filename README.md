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

@isbn.ean_ucc # get ISBN EAN UCC
@isbn.group # get ISBN Group id
@isbn.publisher #get ISBN publisher code
@isbn.title #get ISBN publisher book title order
@isbn.check_digit # get ISBN check digit

@isbn.thirteen # generate ISBN with 13 digits and join with -
@isbn.thirteen(" ") # generate ISBN with 13 digits and join with space
@isbn.ten # generate ISBN with 10 digitsand join with -
@isbn.ten(" ") # generate ISBN with 10 digitsand join with space
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hfl/bookisbn. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

