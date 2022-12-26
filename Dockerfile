FROM perl:slim AS builder

WORKDIR /opt/mydirt-api

RUN apt-get update
RUN apt-get install -y curl gnupg
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl -sSL https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql18 unixodbc-dev

COPY cpanfile .
#RUN curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm | perl - install -g App::cpm
RUN cpm install -g --without-test --no-test
RUN find /root -type f -not -name '.profile' -delete
RUN apt-get remove -y gnupg curl
RUN apt-get autoremove -y

WORKDIR /opt/mydirt-api
COPY . .
EXPOSE 3000
CMD ./script/run_server prefork
