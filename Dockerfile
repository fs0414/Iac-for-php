FROM php:8.2-cli

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# パッケージのインストール
RUN apt-get update && apt-get install -y \
    tzdata \
    zip \
    unzip \
 && pecl install xdebug \
 && docker-php-ext-install pdo_mysql \
 && rm -rf /var/lib/apt/lists/*

# AWS CLIのインストール
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# AWS SDKのインストール
# RUN composer require aws/aws-sdk-php
RUN curl "https://docs.aws.amazon.com/aws-sdk-php/v3/download/aws.zip" -o "awssdkphp.zip"
RUN unzip awssdkphp.zip -d /tmp

# タイムゾーンを設定する環境変数
ENV TZ=Asia/Tokyo
