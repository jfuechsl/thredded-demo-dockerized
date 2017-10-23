#!/bin/bash

export RAILS_ENV=production

./script/wait-for-tcp db 3306
bundle exec rake db:migrate
bundle exec rake db:seed

exec bundle exec puma
