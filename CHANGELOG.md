# Changelog

All notable changes to this project will be documented in this file.

---

## [1.2.0] - Safety and Reliability

### Added

* Dry-run mode
* Configuration validation before reload
* Journald logging through `logger`
* Path expansion support for `~`
* Safe path validation before deletion
* Soft process termination mode
* Aggressive process termination mode
* Warning logs for invalid configuration
* Critical logs for unsafe deletion attempts

### Changed

* Removed unsafe path expansion logic
* Configuration is now validated before being applied
* Invalid configurations no longer overwrite active settings
* Process handling now depends on selected operating mode
* Deletion actions are now logged

### Security

* Added protection against deleting dangerous paths
* Added protection against empty paths
* Added protection against deleting the user's home directory
* Added path length validation

### Notes

This release focuses on safety, observability and reliability.

The project evolved from a simple Bash script into a configurable daemon with logging, configuration validation and basic protection against destructive misconfiguration.


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
