FROM ruby:3.2.2

WORKDIR /rails

# Copia o Gemfile e o lockfile primeiro (isso ajuda o cache do Docker)
COPY Gemfile Gemfile.lock ./

# Instala as gems
RUN bundle install

# Copia TODO o resto do projeto para dentro do container
COPY . .

# Expõe a porta 3000 (opcional)
EXPOSE 3000

# Comando padrão para rodar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
