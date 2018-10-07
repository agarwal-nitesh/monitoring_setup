# Build executable binary
FROM golang:latest as builder
WORKDIR $GOPATH/src/
# Get dependancies
RUN go get github.com/prometheus/node_exporter
RUN cd github.com/prometheus/node_exporter; make; cp node_exporter /go/bin
# Build a small image
FROM scratch
# Copy static executable
COPY --from=builder /go/bin/node_exporter /bin/node_exporter
EXPOSE 9100
ENTRYPOINT ["/bin/node_exporter"]