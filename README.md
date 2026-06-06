# Productivity Guardian

Productivity Guardian is a Linux daemon written in Bash that automatically detects and suppresses unwanted software, files and processes.

The project started as a joke script that deleted Dota 2 whenever it appeared on the system. It has since evolved into a long-term DevOps learning project focused on Linux automation, service management, infrastructure and observability.

Current version: **v1.3.0**

---

## Features

### File Monitoring

Periodically scans configured files and directories.

Detected targets can be removed automatically.

### Process Monitoring

Monitors configured processes independently from file detection.

Depending on the selected mode, processes can be:

* terminated gracefully
* forcefully killed
* ignored in dry-run mode

### Configuration Reload

Configuration is reloaded during every scan cycle.

Changes are applied without restarting the daemon.

### Logging

The daemon writes logs to journald using the `productivity-guardian` tag.

Available log levels:

* INFO
* WARN
* ERROR
* CRITICAL
* DRY-RUN

### Safe Defaults

If configuration validation fails during startup:

* the daemon does not crash
* safe default settings are used

### Dependency Validation

Required system utilities are checked during startup.

### systemd Integration

Designed to run as a persistent Linux user service.

---

## Operating Modes

### dry-run

Recommended default mode.

* Detect targets
* Log actions
* Do not delete files
* Do not kill processes

### soft

* Remove forbidden files
* Send SIGTERM to processes
* Show notifications

### aggressive

* Remove forbidden files
* Send SIGTERM
* Escalate to SIGKILL if necessary
* Show notifications

### silent

* Remove forbidden files
* Kill processes
* Disable desktop notifications

---

## Configuration

Example:

* scan interval
* monitored paths
* monitored processes
* operating mode

Configuration file:

configs/guardian.conf

Safe example configuration:

configs/guardian.conf.example

---

## Project Structure

linux-productivity-guardian/

├── configs/

├── scripts/

├── systemd/

├── CHANGELOG.md

├── README.md

└── install.sh

---

## Running Manually

The daemon can be started directly from the terminal for testing purposes.

Dry-run mode is recommended during initial setup.

---

## Running as a Service

The project is intended to be used as a systemd user service.

The service automatically starts the guardian in the background and can be configured to launch on login.

---

## Logs

Logs are written through journald.

Useful events include:

* configuration validation
* target detection
* file deletion
* process termination
* dry-run actions
* security warnings

---

## Security Features

The daemon contains several safety mechanisms:

* configuration validation
* critical path protection
* home directory restriction
* dangerous path detection
* safe startup defaults

Protected paths include:

* /
* /etc
* /usr
* /var
* /proc
* /sys
* /dev
* /home

---

## Known Limitations

* Linux only
* Bash implementation
* Pattern-based process matching
* No central event storage
* No metrics endpoint

---

## Roadmap

### v2.0.0

* Docker support
* Containerized deployment
* Multi-service architecture

### v3.0.0

* Python rewrite
* Telegram notifications
* REST API

### v4.0.0

* Kubernetes deployment
* GitLab CI/CD
* Automated releases

### v5.0.0

* Prometheus metrics
* Grafana dashboards
* Monitoring stack

---

## Learning Goals

This project is used to practice:

* Linux
* Bash
* systemd
* Docker
* CI/CD
* Kubernetes
* Monitoring
* Infrastructure as Code

while continuously evolving a single real-world codebase.
