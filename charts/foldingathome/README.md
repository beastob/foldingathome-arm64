# Folding@Home arm64

## Prerequisites

- Kubernetes 1.18+
- Helm v3

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm repo add foldingathome https://beastob.github.io/foldingathome-arm64/
$ helm install my-release foldingathome/foldingathome
```

These commands deploy NGINX Open Source on the Kubernetes cluster in the default configuration.

> **Tip**: List all releases using `helm list -A`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

## Parameters
### Folding@Home parameters

| Parameter            | Description                                                            | Default                                                 |
|----------------------|------------------------------------------------------------------------|---------------------------------------------------------|
| `foldAnonymous`      | contribute as anonymous                                                | `true`                                                  |
| `foldTeam`           | team number                                                            | `"0"`                                                   |
| `foldPower`          | 'light',"medium','full' - how much CPU power available to fahclient    | `"full"`                                                |
| `foldAllowIP`        | whitelist IP addresses for accessing the web console                   | `"192.168.1.1/24"`                                      |
| `foldUser`           | user name                                                              | `Anonymous`                                             |
| `foldPassKey`        | passkey for your account                                               | `'""'`                                                  |