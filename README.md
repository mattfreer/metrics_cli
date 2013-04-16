# Metrics CLi

A command-line interface for an existing machine metrics JSON Web API specification.

## JSON Web API
The prexisting JSON Web API responds to the following request:

* `GET /`: which returns a JSON mapping of machine ids to URLs

## CLi Description
Given a single argument (`url`), which will be the URL of the Web API to use. The metrics CLI makes
a `GET` request to the given URL and receives a JSON mapping of machine ids to URLs.

For each machine, the metrics CLi obtains its metrics by making a GET request to the specified URL.
The metrics CLi reports:

+ The number of machines which provide that metric.
+ Which machine has the lowest value.
+ Which machine has the highest value.
+ The standard deviation of the values.

The metrics CLi then prints the metrics summary in the following format:

    METRIC: metric_1
    NUM: 5
    MINIMUM: machine_1
    MAXIMUM: machine_2
    STD: 5.76

    METRIC: metric_2
    NUM: 5
    MINIMUM: machine_4
    MAXIMUM: machine_2
    STD: 7.18

Or if you specify the `--pretty` option the metrics summary is output in the following format:

    +----------+-----+-----------+-----------+------+
    | METRIC   | NUM | MINIMUM   | MAXIMUM   | STD  |
    +----------+-----+-----------+-----------+------+
    | metric_1 | 5   | machine_1 | machine_5 | 1.58 |
    +----------+-----+-----------+-----------+------+
    | metric_2 | 5   | machine_1 | machine_5 | 9.67 |
    +----------+-----+-----------+-----------+------+

## Installation

Add this line to your application's Gemfile:

    gem 'metrics' :git => 'git@github.com:mattfreer/metrics_cli.git'

And then execute:

    $ bundle install

## Usage

    $ bundle exec metrics [options] url

### Options:

* `-h, --help`: Show command line help
* `--pretty`: Make the metrics pretty
* `--version`: Show help/version info
* `--log-level LEVEL` `(debug|info|warn|error|fatal)` `(Default: info)`: Set the logging level

###Arguments:

* `url`: URL of the Web API to use

## Author: Matt Freer (matt.freer@gmail.com)
Copyright:: Copyright (c) 2013 Matt Freer
