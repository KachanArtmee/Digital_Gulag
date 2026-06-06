# Changelog

All notable changes to this project will be documented in this file.

---

## [1.1.0] - Configuration Support

### Added

* External configuration file
* Configurable monitoring interval
* Configurable forbidden paths
* Configurable forbidden processes
* Multiple operating modes
* Runtime configuration reload

### Changed

* Removed hardcoded Dota 2 paths from the script
* Removed hardcoded process names from the script
* Moved behavior customization into configuration

### Notes

This release transforms the project from a single-purpose Dota 2 remover into a configurable productivity enforcement tool.

---

## [1.0.0] - Initial Release

### Added

* Bash monitoring daemon
* Dota 2 detection
* Automatic file removal
* Steam process termination
* Desktop notifications
* systemd service support

### Notes

Initial proof-of-concept version created as a Linux and Bash practice project.
