[![Build Status](https://travis-ci.org/paultyng/appt.svg)](https://travis-ci.org/paultyng/appt)
[![Code Climate](https://codeclimate.com/github/paultyng/appt/badges/gpa.svg)](https://codeclimate.com/github/paultyng/appt)
[![Test Coverage](https://codeclimate.com/github/paultyng/appt/badges/coverage.svg)](https://codeclimate.com/github/paultyng/appt/coverage)

# Appt

[![Join the chat at https://gitter.im/paultyng/appt](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/paultyng/appt?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

*Appt* is an open source engine for Ruby on Rails.

It's designed to be dropped in to an existing app to provide appointment scheduling features, including:

* iCalendar syncing of external busy information
* iCalendar subscription to scheduled appointments
* Mutiple appointment types (differing durations and cushions)
* ...tbd... (*Appt* is a work-in-progress)

## Installation

Add to your Gemfile:

```ruby
gem 'appt'
```

Then:

```shell
bundle install
rake railties:install:migrations
rake db:migrate
```
