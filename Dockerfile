FROM perl
WORKDIR /opt/mojo-hello_world
COPY . .
RUN cpanm --installdeps -n .
EXPOSE 3000
CMD ./script/my_app prefork
