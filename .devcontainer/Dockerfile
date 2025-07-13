FROM ruby:3.2.2

# Instala dependências básicas para Rails
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn \
  git \
  curl \
  vim

# Cria diretório de trabalho
WORKDIR /workspace

# Instala bundler e as gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# Copia o restante do projeto
COPY . .

# Deixa pronto para uso no terminal
CMD ["bash"]
