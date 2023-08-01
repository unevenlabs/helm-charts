# Changelog

All notable changes to this module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.1] - 2023-08-01
### Changed
- Make names functions of release name

## [2.0.0] - 2023-08-01
### Changed
- Bump elasticsearch version

## [1.7.0] - 2023-07-31
### Changed
- Remove eck-operator from chart

## [1.6.0] - 2023-06-23
### Changed
- Add support for DatadogMonitor

## [1.5.0] - 2023-06-14
### Changed
- AWS IAM role

## [1.4.0] - 2023-06-12
### Changed
- Change config section

## [1.3.0] - 2023-05-11
### Changed
- Add internalIPs whitelisting

## [1.2.0] - 2023-04-21
### Changed
- Add metricbeat

## [1.1.0] - 2023-04-21
### Changed
- Bump operator version
- Bump elastic version

## [1.0.2] - 2023-04-21
### Changed
- Adjust authorization policy match labels selector

## [1.0.1] - 2023-04-20
### Changed
- Added additionalPodAnnotations

## [1.0.0] - 2023-04-20
### Changed
- no new functionality, just fixing the way PDBs template is working
- Add PodDisruptionBudget to Elasticsearch and set defaults
- Add Elasticsearch to virtualService block
- Remove Helm install hooks from templates
- Add processors to Filebeat and their necessary resources
- Adjust helm install weight for Kibana and Beats
- Disable authentication in Elasticsearch
- Disable self-signed certificates in Kibana.
- Fix Kibana virtual service destination.
- Support for disabling TLS for Kibana, APM Server, Enterprise Search and the HTTP layer of Elasticsearch.
- Add environment label to custom resources.
- Fix Elasticsearch podTemplate
- Add default values for Kibana virtual service.
- Simplify Elasticsearch template and add support for Elasticsearch node roles.
- Add support for Elasticsearch resources limits and requests.
- Add support for Service Account creation for accessing AWS resources (e.g. Cloudwatch logs) through IAM role for Service Account.
- Add authorization policy and virtual service templates
- Add template to deploy Kibana
- Add template to deploy Beats
- Add template to deploy Elasticsearch
- Initial version of a Helm chart that deploys the ECK operator
