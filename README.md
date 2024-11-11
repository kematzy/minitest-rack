<!-- markdownlint-disable MD013 MD033 -->

# Minitest::Rack

[![Ruby](https://github.com/kematzy/minitest-rack/actions/workflows/ruby.yml/badge.svg?branch=master)](https://github.com/kematzy/minitest-rack/actions/workflows/ruby.yml) - [![Gem Version](https://badge.fury.io/rb/minitest-rack.svg)](https://badge.fury.io/rb/minitest-rack) - [![Minitest Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop/rubocop-minitest)

Coverage: **100%**

[Minitest](https://github.com/seattlerb/minitest) & [rack-test](https://github.com/rack/rack-test)
convenience assertions/expectations for DRY'er faster testing.

Save time and energy by writing short effecient obvious assertions/expectations with Rack-test
when using Minitest.

---

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-rack'
```

And then execute:

```bash
bundle
```

Or install it yourself as:

```bash
gem install minitest-rack
```

## Usage

Add the gem to your _Gemfile_ or _.gemspec_ file and then load the gem in your
`(test|spec)_helper.rb` file as follows:

```ruby
 # <snip...>

 require 'minitest/autorun'
 require 'minitest/rack'

 # <snip...>
```

Adding the above to your `spec_helper.rb` file automatically adds the key helper methods to the
`Minitest::Assertions` to test for Rack output.

---

## Requirements

- [json](https://github.com/flori/json)
- [rack-test](https://github.com/brynary/rack-test)
- [minitest](https://github.com/seattlerb/minitest) ~> 5.0

## Acknowledgements

Inspiration for this gem was taken from the
[`rack-minitest`](https://github.com/brandonweiss/rack-minitest) gem by Brandon Weiss

Copyright (c) 2012 Brandon Weiss and released under the MIT license.

---

## Development

After checking out the repo, run `bundle install` to install dependencies.
Then, run `bundle exec rake spec` to run the tests.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version:

1. update the version number in `version.rb`
2. run `bundle exec rake release`, which will create a git tag for the version
3. push git commits and tags
4. push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/kematzy/minitest-assert_errors).

This project is intended to be a safe, welcoming space for collaboration, and contributors are
expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## Copyright

Copyright (c) 2015 - 2024 Kematzy

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).
