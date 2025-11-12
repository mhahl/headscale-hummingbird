# Build stage: use builder variant to install dependencies and compile
FROM quay.io/hummingbird/go:latest-builder AS builder
RUN dnf install -y less jq sqlite3 bind-utils git
RUN git clone https://github.com/juanfont/headscale -b v0.27.1 /src/
WORKDIR /src
RUN mkdir -p /var/run/headscale /etc/headscale
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /headscale ./cmd/headscale

# Runtime stage: use minimal base image for the compiled binary
FROM quay.io/hummingbird/core-runtime:latest
COPY --from=builder /headscale /bin/headscale
COPY --from=builder /var/run/headscale /var/run/headscale

USER 1001:1001
RUN mkdir /var/run/headscale
EXPOSE 8080/tcp 40000/tcp
ENTRYPOINT ["/bin/headscale"]
CMD ["serve"]
