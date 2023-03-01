# helm-charts

## Local Development

- Make sure to install the [Helm CLI](https://helm.sh/docs/intro/install/)
- Update or create a new manifest
- Either add a new custom values file, e.g. `values.custom.yaml`, or update `values.yaml`
- Run the updated/new manifest with helm and check the generated output:
    - `helm template . -f values.yaml --debug`
    - `helm template . -f values.yaml -f values.custom.yaml --debug`