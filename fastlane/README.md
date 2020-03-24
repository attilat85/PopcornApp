fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios dependencies
```
fastlane ios dependencies
```
Install dependencies
### ios test
```
fastlane ios test
```
Runs all the tests
### ios metrics
```
fastlane ios metrics
```
Collect metrics information about the project

Also uploads it to SonarQube
### ios distribute_staging
```
fastlane ios distribute_staging
```
Staging build distribution

options

  - nightly: bool
### ios distribute_production
```
fastlane ios distribute_production
```
Production build distribution

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
