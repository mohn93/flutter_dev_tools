## 0.0.9

* `httpLoggerProvider` is a plain `Provider` again. Watching it no longer rebuilds dependents on every logged request or response. The logger screen still updates live.
* If you relied on 0.0.8's rebuilds (e.g. `ref.watch(httpLoggerProvider)` for live data, or `httpLoggerProvider.notifier`), listen to the logger directly instead, e.g. with `ListenableBuilder(listenable: ref.watch(httpLoggerProvider), ...)`.

## 0.0.8

* Remove the Firebase Dynamic Links diagnostics API and native plugin dependency.
* Keep the HTTP logger screen in sync with new requests and responses.
* Refresh the example and tests for the supported HTTP logger functionality.

## 0.0.7

* remove Dynamic links

## 0.0.5

* pump up intl version to 0.19.0

## 0.0.4

* Get down the intl version to 0.18.1

## 0.0.3

* Pump dependencies to latest versions

## 0.0.2

* Refactor and add an example

## 0.0.1

* initial release, currently contains ui http logger
