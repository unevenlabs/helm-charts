# Changelog

All notable changes to this module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.1.3-7] - 2024-05-23
### Changed
- Fix service.

## [1.1.3-6] - 2024-05-23
### Changed
- Add nginx reverse proxy as a workaround for istio RBAC.

## [1.1.3-5] - 2024-01-05
### Changed
- Fix AuthorizationPolicy match label

## [1.1.3-4] - 2023-11-13
### Changed
- Changed local state path to be persisted

## [1.1.3-3] - 2023-11-02
### Changed
- Add DestinationRule to support TLS

## [1.1.3-2] - 2023-10-17
### Changed
- Get OIDC credentials from secrets env variable

## [1.1.3-1] - 2023-10-17
### Changed
- Fork of nifi helm. Downloaded https://cetic.github.io/helm-charts/nifi/nifi-1.1.3.tgz
- Added virtualservice
- Added AuthorizationPolicy
