FROM node:8.4.0

RUN mkdir /hello-node-private

VOLUME ["/hello-node-volume"]

EXPOSE 8080

COPY server.js .
COPY data/README.md /hello-node-private/

CMD node server.js
