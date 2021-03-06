![Logo of Consul]
(http://www.coruna.es/IMG/P_Suceso_1442838188465_640_480_U_2c8e14d5f665318819e59946b27ba2.jpg)

# A Porta Aberta

A Porta Aberta, a Citizen Participation and Open Government Application based on Consul

[![Build Status](https://travis-ci.org/consul/consul.svg?branch=master)](https://travis-ci.org/consul/consul)
[![Code Climate](https://codeclimate.com/github/consul/consul/badges/gpa.svg)](https://codeclimate.com/github/consul/consul)
[![Dependency Status](https://gemnasium.com/consul/consul.svg)](https://gemnasium.com/consul/consul)
[![Coverage Status](https://coveralls.io/repos/consul/consul/badge.svg?branch=master&service=github)](https://coveralls.io/github/consul/consul?branch=master)

This is the opensource code repository for "A Porta Aberta", based on Consul, developed by the Madrid City government.

## Current state



## Roadmap



## Tech stack

The application backend is written in the [Ruby language](https://www.ruby-lang.org/) using the [Ruby on Rails](http://rubyonrails.org/) framework.

Frontend tools used include [SCSS](http://sass-lang.com/) over [Foundation](http://foundation.zurb.com/) for the styles.

## Configuration for development and test environments

Prerequisites: install git, Ruby 2.2.3, bundler gem, ghostscript and PostgreSQL (>=9.4).

```
git clone https://github.com/ConcelloCoruna/aportaaberta.git
cd aportaaberta
bundle install
cp config/database.yml.example config/database.yml
cp config/secrets.yml.example config/secrets.yml
rake db:create
bin/rake db:setup
bin/rake db:dev_seed
RAILS_ENV=test bin/rake db:setup
```

Run the app locally:
```
bin/rails s

```

Prerequisites for testing: install PhantomJS >= 1.9.8

Run the tests with:

```
bin/rspec
```

You can use the default admin user from the seeds file:

 **user:** admin@madrid.es
 **pass:** 12345678

But for some actions like voting, you will need a verified user, the seeds file also includes one:

 **user:** verified@madrid.es
 **pass:** 12345678

### OAuth

To test authentication services with external OAuth suppliers - right now Twitter, Facebook and Google - you'll need to create an "application" in each of the supported platforms and set the *key* and *secret* provided in your *secrets.yml*

In the case of Google, verify that the APIs *Contacts API* and *Google+ API* are enabled for the application.

## License

Code published under AFFERO GPL v3 (see [LICENSE-AGPLv3.txt](LICENSE-AGPLv3.txt))

## Contributions

See [CONTRIBUTING_EN.md](CONTRIBUTING_EN.md)
