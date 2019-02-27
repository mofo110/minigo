FROM golang:latest 
EXPOSE 8080
ADD . /go/
WORKDIR /go
ENV GOPATH=/go
RUN go install ./src/hello/
CMD ["/go/bin/hello"]