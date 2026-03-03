# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Local Development

Render a chart locally to inspect generated manifests:
```bash
helm template . -f values.yaml --debug
helm template . -f values.yaml -f values.custom.yaml --debug
```

### Validation

Run kubeval against all stable charts (mirrors CI):
```bash
.github/kubeval.sh
```

Lint a specific chart using helm's built-in linter:
```bash
helm lint stable/<chart-name>
```

### CI Pipeline

The CI pipeline (`.github/workflows/ci.yaml`) runs on PRs touching `stable/**`:
1. **Lint** – `helm/chart-testing-action` with config in `.github/ct.yaml`
2. **Kubeval** – validates against Kubernetes 1.21.1, skipping CRD-only resources (Alertmanager, EnvoyFilter, Prometheus, PrometheusRule, ServiceMonitor, VirtualService, etc.)
3. **Install** – spins up a Kind cluster and does a full install test

### Chart Release

Charts are published to GitHub Pages automatically when changes merge to `main`. Each chart has its own workflow (`.github/workflows/release-<chart>.yaml`) that calls the `.github/actions/helm-gh-pages` custom action using `secrets.CR_TOKEN`.

To release, bump the `version` field in `Chart.yaml` and merge to `main`.

## Architecture

### Repository Layout

```
stable/         All Helm charts
  microservice/ Primary generic chart for all service types
  argo-cd/      ArgoCD deployment (upstream argoproj/argo-helm)
  argocd-apps/  Wrapper for ArgoCD Application/Project/ApplicationSet resources
  istio-*/      Istio service mesh components (multiple versions)
  ...           Third-party charts (airbyte, airflow, akhq, grafana, etc.)
```

### The `microservice` Chart (v1.21.0)

The central, most-used chart. It is a generic chart that can generate nearly any Kubernetes resource combination from a single `values.yaml` override file. All resource types are gated by an `enabled` boolean.

**Supported resource types** (each toggled independently):
- `deployment` / `statefulSet` – application workloads
- `service` – ClusterIP/NodePort/LoadBalancer
- `configMap` / `secret` – configuration and credentials
- `persistentVolumeClaims` – storage
- `jobs` / `cronjobs` – batch and scheduled work
- `virtualService` / `authorizationPolicy` / `destinationRule` – Istio networking and security
- `serviceMonitor` / `prometheusRule` / `alertmanagerConfig` / `scrapeConfigs` – observability
- `autoscaling` (HPA) / `keda` (ScaledObject + TriggerAuthentication) – autoscaling
- `rbac` (Role/ClusterRole + Bindings + ServiceAccount) – access control
- `argoRollouts` – canary deployments via Argo Rollouts
- `kafkaTopics` – Kafka topic management
- `datadogMonitors` – Datadog alert definitions
- `securityGroupPolicy` – AWS security group integration
- `vault` – HashiCorp Vault agent injection via pod annotations

**Key helpers** (`templates/_helpers.tpl`):
- `application.name` – resolves from `applicationName` or `Chart.Name`
- `application.labels.chart` – standard labels: `environment`, `owner`, `application`, `chain`, `provider`
- `application.namespace` – respects `namespaceOverride`
- `vault.annotations` – generates all Vault agent sidecar annotations from a structured `vault.secrets[]` list

**Label conventions**: All resources carry `environment`, `owner`, `application`, `chain` (defaults to `shared`), and `provider: unevenlabs`.

### The `argocd-apps` Chart (v0.0.9)

A thin wrapper that generates ArgoCD `Application`, `AppProject`, `ApplicationSet`, and UI extension resources. Values are straightforward lists: `applications[]`, `projects[]`, `applicationsets[]`, `extensions[]`.

### The `argo-cd` Chart (v7.8.27-1)

Upstream ArgoCD chart from argoproj/argo-helm, with a `redis-ha` dependency. Requires Kubernetes 1.25+.
