# Release Process

Implementation repositories own their own release process, but follow common principles:

## Release Tagging

- Tag all releases
- Format `vX.Y.Z`
- Adhere to [Semantic Versioning](https://semver.org/spec/v2.0.0.html)
- Release management should be contained entirely to CI through GitHub Actions - no manual deployments.
- Create the release tag as a workflow action **only after** a successful deployment
- CI changes should commit using the `github-actions[bot]` user

## Changelog

- Maintain a `CHANGELOG.md` file
- Changelog format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)

## Containers

- Publish under the `ghcr.io/hem-labs` organization
- Publish multiple versions:
    - `latest`
    - `X.Y`
    - `X.Y.Z`
    - `sha-<commit_hash>`
