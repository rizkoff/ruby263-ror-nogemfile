FROM ruby:2.6.3

WORKDIR /build
COPY Gemfile /build/
RUN apt update && apt install -y nodejs npm vim nginx
RUN npm install -g yarn

RUN echo 'install: --no-document' >> ~/.gemrc; echo 'update: --no-document' >> ~/.gemrc
RUN gem install rails -v 6.1.3.1

WORKDIR /opt/ex1
RUN rails new .
RUN bundle exec rails g scaffold item f1 f2:integer
RUN bundle exec rails db:migrate

COPY default /etc/nginx/sites-available/default
COPY entrypoint.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/entrypoint.sh
COPY puma.rb config/puma.rb

EXPOSE 8080

ENTRYPOINT [ "entrypoint.sh" ]

CMD ["puma"]
