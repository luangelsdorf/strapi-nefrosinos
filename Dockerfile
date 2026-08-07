FROM node:18-alpine3.18

# Instala dependências do sistema necessárias para o Strapi e processamento de imagens (sharp)
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev

WORKDIR /app

# Instala as dependências
COPY package.json package-lock.json ./
RUN npm ci

# Copia o código-fonte
COPY . .

# Configura o ambiente de produção e realiza o build do painel admin
ENV NODE_ENV=production
RUN npm run build

EXPOSE 1337

CMD ["npm", "run", "start"]
