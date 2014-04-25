# IVE

A gem that allows you to bump the version of your Xcode project.

The current bumps are supported by Ive:
- **Major** _Go from 1.0.0 to 2.0.0_
- **Minor** _Go from 1.0.0 to 1.1.0_
- **Patch** _Go from 1.0.0 to 1.0.1_
- **Build** _Go from 1.0.0-100000 to 1.0.0-100001_

And you can even automatically tag the current commit with this lastest version bump.

## Installation

Add this line to your application's Gemfile:

    gem 'ive'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ive

## Usage

It's really simple to use. Just run anh of the following commands in the Terminal from the project root in order to bump.

    ivo bump:major
    ivo bump:minor
    ivo bump:patch
    ivo bump:build

To tag the commit add the _--git_ parameter.

    ivo bump:major --git
    ivo bump:minor --git
    ivo bump:patch --git
    ivo bump:build --git

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ive/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
