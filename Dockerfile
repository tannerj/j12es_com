# Use an official Ruby image (lightweight)
FROM ruby:3.2-slim

# Install system dependencies needed for Jekyll + native gems
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  git \
  curl \
  nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Set working directory inside container
WORKDIR /site

# Copy Gemfile first for caching bundle install
COPY Gemfile Gemfile.lock ./

# Install bundler + dependencies
RUN gem install bundler && bundle install

# Copy the rest of the site files
COPY . .

# Expose Jekyll dev server port
EXPOSE 4000

# Default command: run Jekyll in dev mode with live reload
CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload"]

