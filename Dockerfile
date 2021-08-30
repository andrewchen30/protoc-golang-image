FROM golang:alpine3.14

RUN apk update && apk upgrade
RUN apk add unzip && apk add git && apk add --update coreutils
RUN wget -q -O protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v3.12.0/protoc-3.12.0-linux-x86_64.zip && unzip protoc.zip
# RUN mv /go/bin/protoc /usr/local/bin/protoc && rm protoc.zip

# RUN git config --global url."ssh://git@github.com/".insteadOf "https://github.com/"
# RUN echo "Host github.com\n\tStrictHostKeyChecking no\n\tControlMaster auto\n\tControlPersist 600\n\tControlPath /tmp/ssh-%r@%h:%p" >> $HOME/.ssh/config
RUN echo "[url \"git@github.com:\"]\n\tinsteadOf = https://github.com/" >> /root/.gitconfig
RUN mkdir /root/.ssh && echo "StrictHostKeyChecking no " > /root/.ssh/config

ENV PATH="$PATH:$(go env GOPATH)/bin"

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

ENV SSH_PRIVATE_KEY ""
ENV GO111MODULE=on
ENV GOPRIVATE "github.com/AmazingTalker/*"