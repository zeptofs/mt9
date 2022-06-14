# MT9

MT9 is a data standard used within the NZ banking industry for the creation of Bulk Payments (credits) and Receipts (debits). It is ASB's preferred data standard.
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

Require the gem

```ruby
require 'mt9'
```

Unlike ABA, MT9 requires that all credits must be grouped together in the same credit file, and all debits in the same debit file. Two methods `MT9#batch_credits` and `MT9#batch_debits` are exposed to create a credit or debit batch respectively.

When transactions are added to the batch object, their transaction code is automatically set for the type of batch they're in (either `051` for credit batches or `000` for debit batches). [List of valid transaction codes](https://github.com/zeptofs/mt9/blob/main/lib/mt9/values.rb#L14)

> **Note**
> A single batch can only hold up to a maximum of 9,999,999,999 cents ($99,999,999.99) in total of transactions.

Example usage:
```ruby
# Initialise a credit batch
credit_batch = MT9.batch_credits(
  account_number: "224444777777722", # Must be 15 digits
  due_date: Date.parse("4/5/2020"),
  client_short_name: "ACME Pty Ltd",  # Optional, highly recommended to fill
)

credit_batch.add_transaction(
  account_number: "1234567890123450", # Must be 15 or 16 digits
  amount: 1000,
  transaction_code: "052",            # Optional, defaults to 051 for credit batches, 000 for debit batches
  this_party: {
    name: "This Name",                # Name of person being credited
    code: "This code",
    alpha_reference: "This alpha",    # Optional
    particulars: "This particulars",  # Optional
  },
  other_party: {
    name: "Other name",               # Optional, defaults to the batch's client_short_name
    code: "Other code",               # Optional
    alpha_reference: "Other alpha",   # Optional
    particulars: "Other particulars", # Optional
  },
)

credit_batch.add_transaction(
  account_number: "1234561234567890",
  amount: 3000,
  this_party: {
    name: "John Smith",
    code: "Testing code",
  },
)

credit_batch.generate # To string
```

The batch can also be generated straight to a file. ASB recommend a filename format like so `credit00batchyyMMddhhmmssFFF`. File extension can either be: `.txt`, `.dat` or `.mt9`.
```ruby
credit_batch.generate_to_file("credit00batch#{DateTime.now.strftime("%y%m%d%H%M%S%L")}.mt9")
```

Alternatively you can pass a block when creating the batch:
```ruby
debit_batch = MT9.batch_debits(
  account_number: "224444777777722",
  due_date: Date.parse("4/5/2020"),
  client_short_name: "ACME Pty Ltd",
) do |b|
  10.times.do
    b.add_transaction(
      account_number: "1234561234567890",
      amount: 5000,
      this_party: {
        name: "John Smith",
        code: "Testing code",
      },
    )
  end
end
```

Trying to create an invalid batch or transaction will raise a `MT9::ValidationError`. You can access the result of the validation by calling `#result` on the exception, which returns a [`Dry::Validation::Result`](https://rubydoc.info/gems/dry-validation/Dry/Validation/Result) object.

```ruby
begin
  credit_batch = MT9.batch_credits(
    account_number: "7777777",
    due_date: Date.parse("4/5/2020"),
    client_short_name: "ACME Pty Ltd",
  )
rescue MT9::ValidationError => e
  e.result
end
=> #<Dry::Validation::Result{:file_type=>"12", :account_number=>"7777777", :due_date=>#<Date: 2020-05-04 ((2458974j,0s,0n),+0s,2299161j)>, :client_short_name=>"ACME Pty Ltd"} errors={:account_number=>["length must be 15"]}>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zeptofs/mt9.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
