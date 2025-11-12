# Headscale

Use project Hummingbird containers for headscale build.

## Build

In OpenShift apply the `Pipeline` to build and push the image to quay.

```  
oc apply -f build-headscale-container.yaml -n sigiant-quay
```

Create a new `PipelineRun` the image should be available at

* `quay.sigaint.au/sigaint/headscale:v0.27.1-hummingbird`

# Notes
* You must mount in:
  * /var/lib/headscale
  * /etc/headscale
* The container runs with user `65532:root`

For example in your `compose.yaml`
```
---
version: "3.0"
services:
  headscale:
    image:  quay.sigaint.au/sigaint/headscale:v0.27.1-hummingbird
    container_name: headscale
    network_mode: host
    pull_policy: always
    command: "serve"
    environment:
      - "TZ=Australia/Sydney"
    ports:
      - 8070:8070
    volumes:
      - /data/containers/headscale/data:/var/lib/headscale:z
      - /data/containers/headscale/config:/etc/headscale:z
    restart: unless-stopped
```

