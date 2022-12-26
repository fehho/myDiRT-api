FROM perl:slim AS builder

WORKDIR /opt/mydirt-api
RUN apt-get update
RUN apt-get install -y curl gnupg
RUN curl -sSL https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl -sSL https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql18 unixodbc-dev libdbix-class-perl
RUN apt-get autoremove -y

COPY cpanfile .
RUN curl -fsSL https://raw.githubusercontent.com/skaji/cpm/main/cpm | perl - install -g App::cpm
RUN cpm install --global

FROM builder AS runner
WORKDIR /opt/mydirt-api
COPY . .
EXPOSE 3000
CMD ./script/run_server prefork
