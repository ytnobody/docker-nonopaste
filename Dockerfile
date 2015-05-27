FROM ytnobody/base
MAINTAINER ytnobody <ytnobody@gmail.com>

RUN mkdir /app
RUN git clone https://github.com/kazeburo/NoNoPaste.git /app/nonopaste

WORKDIR /app/nonopaste
RUN cpanm -n Module::Install
RUN cpanm -n --installdeps . || cat /root/.cpanm/*/build.log
RUN cpanm -n Starlet Server::Starter Plack::Builder::Conditionals Scope::Container::DBI DBIx::Sunny::Schema Plack::Middleware::Scope::Container

EXPOSE 7721

CMD ["start_server", "--port=7721", "--", "plackup", "-Ilib", "-s", "Starlet", "nonopaste.psgi"]
