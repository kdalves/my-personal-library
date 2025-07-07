FROM ruby:3.2.2

# Define diretório de trabalho dentro do container
WORKDIR /usr/src/app

# Copia apenas os arquivos de dependência antes para usar cache do Docker
COPY Gemfile Gemfile.lock ./

# Atualiza apt e instala dependências necessárias (build tools, libpq, nodejs)
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs && rm -rf /var/lib/apt/lists/*

# Instala as gems
RUN bundle install

# Copia o restante do código para dentro do container
COPY . .

# Expõe a porta 3000
EXPOSE 3000

# Comando para iniciar o servidor Rails
CMD ["rails", "server", "-b", "0.0.0.0"]
