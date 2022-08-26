FROM ruby:3.1.2

RUN apt-get update && apt-get install -y nodejs npm postgresql-client
RUN npm install -g yarn
RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY package.json ./
COPY yarn.lock ./
RUN yarn install
COPY . .

RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]