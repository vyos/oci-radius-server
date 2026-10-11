# oci-radius-server
OCI used during smoketest to act as RADIUS authentication server

FreeRADIUS on Alpine, multi-arch (amd64, arm64). Mount a `clients.conf` and a
`users` file into `/etc/raddb/`, for example:

```
docker run -d --name radius \
    -v ./clients.conf:/etc/raddb/clients.conf:ro \
    -v ./users:/etc/raddb/users:ro \
    <image>
```

Ports 1812/udp (auth) and 1813/udp (accounting) are exposed. Authentication
attempts are logged to stdout (without passwords).

## Building

```
docker build -t radius-server .
docker buildx build --platform linux/amd64,linux/arm64 -t <registry>/radius-server --push .
```
