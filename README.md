# Creating an External Private Docker Registry (self signed cert)

1. Create a certs directory for your domain.crt and domain.key file 

```
openssl req \
  -newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key \
  -addext "subjectAltName = DNS:myregistry.domain.com" \
  -x509 -days 365 -out certs/domain.crt
```

- You'll want to make sure your dns is configured properly with your provider - using netlify and an EC2 instance. Configure terraform script in the future.

2. Start your docker registry:2 private registry

```
docker run -d \
  --restart=always \
  --name registry \
  -v "$(pwd)"/certs:/certs \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  -p 443:443 \
  registry:2
```

3. You'll need to instruct every docker daemon to trust the certificate. This varies for different os. This is for your docker clients that wish to make https push/pull requests to the private registy. 

for mac: https://docs.docker.com/desktop/mac/#add-tls-certificates

for linux: `Linux: Copy the domain.crt file to /etc/docker/certs.d/myregistrydomain.com:5000/ca.crt on every Docker host. You do not need to restart Docker.`


