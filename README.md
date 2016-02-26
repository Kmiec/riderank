# README
Things you may want to cover:
* Ruby 2.1+ 
* MySQL 5.5+, any gem dependencies from Gemfile
* Configuration:
copy and fill database config file:
```sh
$ cp config/database.sample.yml config/database.yml
```
and secrets ;)
```sh
$ cp config/secrets.sample.yml config/secrets.yml
```
* Database creation
```sh
$ rake db:setup
```
* Run application
```sh
$ rails s
```
or in production mode:
```sh
$ RAILS_ENV=production rake assets:precompile & rails s -b0.0.0.0
```
