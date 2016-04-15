## Demoqa

This repository houses tests against the http://store.demoqa.com site.

## Installation

Prerequisites:
    * Ruby 2.2.4
    * bundler 1.11.2
    * Working Chromedriver

After cloning this repository, execute:

    $ bundle install

## To Run

You need to get a login to the demoqa site. Once you have those, they need to be specified as
ENVARS on the command line

    $ USERNAME=<your username here> PASSWORD=<your password here> bundle exec rspec

Also, these tests use Chrome by default, if you want to use Firefox, then specify it with the DRIVER ENVAR

    $ DRIVER=firefox ...