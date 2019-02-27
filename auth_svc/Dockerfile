FROM golang:latest 
EXPOSE 3000
ADD . /go/
WORKDIR /go
ENV GOPATH=/go
RUN go install ./src/auth/
CMD ["/go/bin/auth"]