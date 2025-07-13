# syntax=docker/dockerfile:1

# This Dockerfile is designed for production, not development. Use with Kamal or build'n'run by hand:
# docker build -t my_personal_library .
# docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name my_personal_library my_personal_library

# For a containerized dev environment, see Dev Containers: https://guides.rubyonrails.org/getting_started_with_devcontainer.html

# syntax=docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.2.2
FROM ruby:$RUBY_VERSION-slim

# Define o diretório de trabalho padrão
WORKDIR /rails

# Instala dependências do sistema
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  git \
  libyaml-dev \
  pkg-config \
  curl

# Cria o usuário 'vscode' com ID 1000 (padrão do Codespaces)
RUN useradd -m -u 1000 vscode
USER vscode

# Define variáveis de ambiente
ENV BUNDLE_PATH="/usr/local/bundle"

# Copia os arquivos do projeto
COPY --chown=vscode:vscode Gemfile Gemfile.lock ./

# Instala o bundler e as gems
RUN gem install bundler && \
    bundle install --with development test && \
    bundle exec bootsnap precompile --gemfile

# Copia o restante da aplicação
COPY --chown=vscode:vscode . .

# Precompila o bootsnap
RUN bundle exec bootsnap precompile app/ lib/

# Garante que os diretórios essenciais existam e tenham permissão
RUN mkdir -p tmp/pids log storage && \
    chown -R vscode:vscode tmp log storage

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
