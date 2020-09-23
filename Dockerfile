FROM ruby:2.7.1
RUN gem install bundler && gem install rails -v 5.2.3
RUN mkdir /rails-app
WORKDIR /rails-app
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
RUN apt update && apt install postgresql-client -y
COPY . .
RUN mkdir -p /setup && echo \
  '#!/bin/bash \n\
  export PGPASSWORD="password" \n\
  until psql -U nullzone -h database -c "\q" &> /dev/null; do \n\
    sleep 1 \n\
  done \n\
  chmod +x bin/* \n\
  count=$(psql -U nullzone -h database -lt | cut -d \| -f 1 | grep -w "development" | wc -l) \n\
  if [ $count -eq '0' ]; then \n\
    bin/rails db:create \n\
    bin/rails db:schema:load \n\
  fi \n\
  rm -f tmp/pids/*.pid \n\
  bin/rails server -b 0.0.0.0' | cat > /setup/setup.sh && chmod +x /setup/*

CMD ["/setup/setup.sh"]
