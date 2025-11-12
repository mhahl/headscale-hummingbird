# Headscale

Use project Hummingbird containers for headscale build.

## Build

In OpenShift apply the `Pipeline` to build and push the image to quay.

```  
oc apply -f build-headscale-container.yaml -n sigiant-quay
```

Create a new `PipelineRun` the image should be available at

* `quay.sigaint.au/sigaint/headscale:<tag>`
