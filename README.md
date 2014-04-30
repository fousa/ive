# IVE

A gem that allows you to bump the version of your Xcode project.

The current bumps are supported by Ive:
- **Major** _Go from 1.0.0 to 2.0.0_
- **Minor** _Go from 1.0.0 to 1.1.0_
- **Patch** _Go from 1.0.0 to 1.0.1_
- **Build** _Go from 1.0.0-0001 to 1.0.0-0002_

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

    ive major
    ive minor
    ive patch
    ive build

To tag the commit add the _--git_ parameter.

    ive major --git
    ive minor --git
    ive patch --git
    ive build --git

You can also supply the path of the project root if needed. Just pass the _-p_ (or _--path_) parameter.

    ive major -p ~/Project
    ive major --path ~/Project

You can also specify the target/configuration you want to bump the version by adding an extra _.ive_ file in the project root. This file should contain a valid target and configuration in order to be used.

Here is an example of the configuration file.

    target: "TheProject"
    configuration: "Debug"

If a .ive configuration file is missing you can easlily generate one with his command.

   ive setup

It's also possible to check out the current version.

    ive version
    ive version -p ~/Project

Set the initial version to 1.0.0 with a build number 0001.

    ive init

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ive/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
