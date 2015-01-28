# JockeyCli

An API Wrapper and CLI for Jockey

## Installation

```
gem install jockey_cli
```

You'll need to generate an OAuth token for your [Github account](https://github.com/settings/applications) to use with Jockey. The CLI uses ENV for all of its settings. If you hate typing in ENV variables all the time, do yourself a solid and make a yaml with your settings at ~/.jockeyrc

```
#### Sample .jockeyrc
github_oauth_token: 65766572797468696e6720697320617765736f6d
jockey_url: https://jockey.example.com
```

## CLI Usage

```
Commands:
  jockey config (get|set)   # Get or set app configuration
  jockey connect [COMMAND]  # Run a command within the context of an app
  jockey deploy             # Deploy an app
  jockey help [COMMAND]     # Describe available commands or one specific command
  jockey reconcile          # Reconcile an app
  jockey scale (get|set)    # Get or set the scale settings for an app
  jockey version            # Shows the Jockey version number

Options:
  [--app=APP]
  [--environment=ENVIRONMENT]
```

`jockey` will attempt to automatically assign `APP` based on the git repo name of your CWD, so if you are in the folder for the `bite-service` and don't pass in a `--app` flag, it will default to `bite-service`. `ENVIRONMENT` is assumed **production** unless assigned as well.

### jockey config

**get**

```
jockey config --app=bite-service --environment=development
```

**set**

```
jockey config set HEADER_PASSWORD=NOT_REALLY_REAL --app=bite-service --environment=development
```

### jockey connect

```
jockey connect /bin/bash --app=bite-service --environment=production
```

### jockey deploy

```
jockey deploy --app=bite-service --environment=production
```
If the deploy is failing for some reason, pass in the `--interactive` flag for an alternative deploy process.


### jockey scale

**get**

```
jockey scale --app=bite-service --environment=production
```
Pass in the `--verbose` option to get back host, ip, sha and ports of running containers.

**set**

```
jockey scale set sidekiq 2 --app=bite-service --environment=production
```
