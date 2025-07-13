# syntax=docker/dockerfile:1

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t my_personal_library .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name my_personal_library my_personal_library

# For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

# syntax=docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim AS base

# Define a working directory
WORKDIR /rails

# Install system dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  git

# Create non-root user for Codespaces
RUN useradd -m -u 1000 codespace
USER codespace

# Set common environment variables
ENV BUNDLE_PATH="/usr/local/bundle"

# -------------------
# Build stage
# -------------------
FROM base AS build

WORKDIR /rails

# Install additional build dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install gems
COPY --chown=codespace:codespace Gemfile Gemfile.lock ./
RUN gem install bundler && \
    bundle install --with development test && \
    rm -rf ~/.bundle "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# Copy app source
COPY --chown=codespace:codespace . .

# Precompile bootsnap
RUN bundle exec bootsnap precompile app/ lib/

# -------------------
# Final stage
# -------------------
FROM base AS final

WORKDIR /rails

# Copy the app and gems from the build stage
COPY --from=build /rails /rails
COPY --from=build /usr/local/bundle /usr/local/bundle

# Create runtime user
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER 1000:1000

EXPOSE 3000
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
CMD ["./bin/rails", "server"]
