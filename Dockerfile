FROM perl
WORKDIR /opt/mojo-hello_world
COPY . .
RUN cpm install
EXPOSE 3000
CMD ./script/my_app prefork
