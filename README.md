# LogParser

[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)

This gem parses a log file and print a report informing the page views count per page and also the unique page views.

It's possible to generate reports like this:
```
# Total page views

/about/2 90 visits
/contact 89 visits
/index 82 visits
/about 81 visits
/help_page/1 80 visits
/home 78 visits

# Unique page views

/help_page/1 23 unique views
/contact 23 unique views
/home 23 unique views
/index 23 unique views
/about/2 22 unique views
/about 21 unique views
```

## Installation

Execute:

    $ bundle install

## Usage

To parse a log a file use the `bin/parser` binary giving the log file path as parameter.
For example, if you have a webserver.log file inside this library folder, you could run it like:

    $ ./bin/parser webserver.log

The log file should contain each line a path and an IP address separated by space. Eg.:

```
/help_page/1 722.247.931.582
/contact 184.123.665.067
/help_page/1 929.398.951.889
/home 316.433.849.805
/contact 316.433.849.805
/home 184.123.665.067
/home 235.313.352.950
/contact 184.123.665.067
/home 316.433.849.805
/about 061.945.150.735
/home 316.433.849.805
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

This gem uses Standard Ruby (https://github.com/testdouble/standard) for linting purposes. This is a wrapper on top of Rubocop. So in order to check your code style simply run:

    $ rake standard

## Tests

In order to run the tests either use `rake spec` or `bundle exec rspec spec`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/felipehespanhol/log_parser.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
