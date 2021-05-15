# syntax=docker/dockerfile:1
FROM ruby:2.6.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY ./ /myapp
RUN cd /myapp
RUN rm Gemfile.lock
RUN gem install bundler
RUN bundle install
# RUN npm install
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
