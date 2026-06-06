# Productivity Guardian

Productivity Guardian is a Linux daemon written in Bash that automatically detects and removes unwanted software from the system.

The project started as a simple script that deleted Dota 2 whenever it appeared on the machine and is gradually evolving into a full DevOps learning project.

Current version: **v1.1.0**

---

## Features

### File and Directory Monitoring

The daemon periodically scans configured paths and removes detected files or directories.

### Process Monitoring

Configured processes can be automatically terminated when forbidden software is detected.

### Configuration File

Behavior is controlled through an external configuration file.

No script modifications are required to:

* change monitored paths
* change monitored processes
* change scan interval
* change operating mode

### Runtime Configuration Reload

The configuration file is reloaded during every scan cycle.

Changes take effect without restarting the service.

### Desktop Notifications

The daemon can notify the user when a violation is detected.

### systemd Integration

Designed to run as a persistent Linux service.

---

## Operating Modes

### aggressive

* Remove forbidden files and directories
* Kill forbidden processes
* Show notifications

### silent

* Remove forbidden files and directories
* Skip notifications

---

## Example Use Cases

* Block Steam games
* Prevent installation of distracting software
* Automatically remove unwanted files
* Practice Linux and Bash automation

---

## Project Structure

project/

├── config/

│   └── guardian.conf

├── scripts/

│   └── guardian.sh

├── systemd/

│   └── productivity-guardian.service

├── CHANGELOG.md

└── README.md

---

## Technologies Used

* Bash
* Linux
* systemd

---

## Roadmap

### v1.2.0

* Logging
* Dry-run mode
* Safer deletion logic
* Configuration validation

### v2.0.0

* Docker support
* Event collection

### v3.0.0

* Python implementation
* Telegram notifications
* REST API

### v4.0.0

* Kubernetes deployment
* Monitoring stack

---

## Motivation

The primary goal of this project is educational.

Each new version introduces additional DevOps concepts and technologies while keeping a single evolving codebase.

This allows the project to grow from a small Bash daemon into a complete infrastructure platform.
