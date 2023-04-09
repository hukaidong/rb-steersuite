# Steersuite

Steersuite is a Ruby gem that provides a Ruby interface to the SteerSuite C++ library. SteerSuite is a 
physics-based simulation library for autonomous agents. It provides a set of tools for simulating
autonomous agents in complex environments.

Currently, the Steersuite gem only supports the control of autonomous agents in the simulation and
the post-processing of SteerSuite simulation data.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'steersuite'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install steersuite

## Usage

### Command Line Interface

#### Plotting Simulation Data

```bash
$ plot.rb source_file  # This will plot the simulation data in source_file with results in source_file.png
```

### Ruby Interface

#### Loading Simulation Data

```ruby
require 'steersuite'

# Load the simulation data from a file
Steersuite::SteersimResult.from_file('source.bin')
```

#### Plotting Simulation Data

```ruby
require 'steersuite'

Steersuite::SteersimPlot.plot_file('source.bin', 'destination.png')
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/steersuite. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/steersuite/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Steersuite project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/steersuite/blob/master/CODE_OF_CONDUCT.md).
