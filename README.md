# MT9

MT9 is a data standard used within the NZ banking industry for the creation of Bulk Payments and Receipts. It is ASB's preferred data standard.
The MT9 data standard is supported by Windows-based PCs and mainframes. ASB's FastNet Business accepts the following import file standards:
- Each record in the file must be 160 characters in length.
- The file must contain a header, a record line for each transaction and a trailer.
- Fields declared as fillers must be space filled.
- Fields are fixed length.
- Files must be in ASCII TEXT fixed-length format.
- The header and all detail records must be completed with a carriage return.

**Important:** The carriage return at the end of the file is optional.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mt9'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mt9

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zeptofs/mt9.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
