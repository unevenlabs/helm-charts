# Changelog

All notable changes to this module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.3.0] - 2022-11-21
### Added
- Add .argoRollouts in templates to support Argo-rollouts

## [1.2.0] - 2022-11-21
### Added
- Add .protocol in VirtualService templates to support tcp

## [1.1.33] - 2022-10-27
### Added
- Add .spec.activeDeadlineSeconds in Job templates

## [1.1.32] - 2022-08-26
### Added
- INFRA-653 - add confighash to helm microservice

## [1.1.31] - 2022-08-26
### Added
- Support using hostNetwork on deployment
- Support using hostNetwork on statefulSet

## [1.1.30] - 2022-08-05
### Added
- Updated statefulset to have storageClassName so we can provision EBS storage classes.

## [1.1.29] - 2022-07-13
### Added
- keda: add support for TriggerAuthentication and ClusterTriggerAuthentication for triggers

## [1.1.28] - 2022-06-28
### Added
- Support Security Group Policy for Security Groups for pods.

## [1.1.27] - 2022-06-27
### Added
- Support multiple VolumeClaimTemplates and VolumeMounts in the StatefulSet template.

## [1.1.26] - 2022-06-27
### Added
- Fix statefulset template

## [1.1.25] - 2022-06-15
### Added
- Add destination rule resource

## [1.1.24] - 2022-06-14
### Added
- Add keda support

## [1.1.23] - 2022-06-01
### Changed
- Add common lables for pod and deployment

## [1.1.22] - 2022-05-16
### Changed
- Add parallelism and completions to Job template

## [1.1.21] - 2022-04-14
### Changed
- Add custom overwrite field for Istio Authorization Policy

## [1.1.20] - 2022-04-11
### Changed
- Disable statefulSet by default

## [1.1.19] - 2022-04-04
### Changed
- Add first version of statefulSet template for service local persistence

## [1.1.18] - 2022-03-30
### Changed
- Fix job command to print array instead of just string

## [1.1.17] - 2022-03-29
### Changed
- Fix ConfigMap labels and annotations to set it separately for each ConfigMap

## [1.1.16] - 2022-03-28
### Changed
- Fix ttlSecondsAfterFinished to work with job and cronjob

## [1.1.15] - 2022-03-25
### Changed
- Fix OPA injection label

## [1.1.14] - 2022-03-25
### Changed
- Add OPA injection enabled by default

## [1.1.13] - 2022-03-18
### Changed
- Fix Authorization policy values

## [1.1.12] - 2022-03-18
### Changed
- Fix Authorization policy when condition

## [1.1.11] - 2022-03-17
### Changed
- Add support for IP whitelisting based on XFF header

## [1.1.10] - 2022-03-16
### Changed
- Change HPA metrics order so ArgoCD does not complain about differences. https://github.com/kubernetes/kubernetes/issues/74099

## [1.1.9] - 2022-03-14
### Changed
- Add support of ClusterRole and ClusterRoleBinding

## [1.1.8] - 2022-03-10
### Changed
- Fix typo in request and response headers customization

## [1.1.7] - 2022-03-07
### Changed
- Change some CronJob parameters to optional

## [1.1.6] - 2022-02-25
### Changed
- Add request and response headers customization support

## [1.1.5] - 2022-02-24
### Changed
- Replace ipBlocks in Istio Authorization Policy in favor of remoteIpBlocks in microservice chart

## [1.1.4] - 2022-02-23
### Added
- Support for Isto Authorization Policy configuration

## [1.1.3] - 2022-02-18
### Fixed
- Namespace addition for CronJob and Job objects
- Service account configuration
- Secret with type configuration

## [1.1.2] - 2022-02-17
### Changed
- Add support for CorsPolicy in Istio VirtualServices

## [1.1.1] - 2022-02-15
### Added
- Support for Job objects

## [1.1.0] - 2022-02-11
### Changed
- Fix support for vault in jobs

## [1.0.11] - 2022-02-10
### Changed
- Add support for vault in jobs

## [1.0.10] - 2022-02-08
### Changed
- Add support for vault secret files

## [1.0.9] - 2022-02-08
### Changed
- Added config map and secret ref to Cron Job template

## [1.0.8] - 2022-02-01
### Changed
- Added support for rewrite uri for VirtualService

## [1.0.7] - 2021-12-22
### Changed
- Add vault injection annotations

## [1.0.6] - 2021-12-22
### Changed
- Properly disable serviceAccounts in deployment template when not configured

## [1.0.5] - 2021-12-22
### Changed
- Added RBAC back to the charts, this includes Roles, Rolebinding and ServiceAccounts

## [1.0.4] - 2021-12-20
### Changed
- Add cleanup job option after job is completed. Feature from Kubernetes v1.21 [beta].
https://kubernetes.io/docs/concepts/workloads/controllers/job/#ttl-mechanism-for-finished-jobs

## [1.0.3] - 2021-12-20
### Changed
- Add toogle flag to deployment and service

## [1.0.2] - 2021-12-20
### Changed
- Fix template for CronJobs.

## [1.0.1] - 2021-11-25
### Changed
- Add VirtualService advancedMatch.

## [1.0.0] - 2021-11-25
### Changed
- Fork of https://github.com/stakater-charts/application release 0.0.71.
