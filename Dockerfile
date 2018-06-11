FROM ubuntu:xenial

RUN apt-get update
RUN apt-get install -y curl git

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

COPY ./ /orbit-db/
WORKDIR /orbit-db/
RUN ls
RUN npm install -g webpack
RUN npm install -g babel-cli

RUN apt-get install make
RUN make clean
RUN make deps
RUN make build

RUN npm install http-server -g

EXPOSE 3000
WORKDIR examples/browser/browser-webpack-example
CMD ["http-server", "-a", "0.0.0.0", "-p", "3000"]
