FROM ruby:3.1.2

# Install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy source code
COPY . .

# Run the app
CMD ["ruby", "bin/todo.rb"]