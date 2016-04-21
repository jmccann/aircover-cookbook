# aircover

Cookbook to deploy [Aircover](https://aircover.co).

## Supported Platforms

Tested And Validated On
- Ubuntu 15.04

## Attributes
* `['aircover']['version']` (default: `'latest'`) - The version of aircover to use
* `['aircover']['vault']` (default: `'vault_aircover'`) - The vault name for aircover secrets
* `['aircover']['docker']['version']` (default: `'1.9.1'`) - The version of Docker to install and use

### Aircover Config
You can drive the configuration of aircover itself through docker ENV that can be set by
adding key/value pairs to `['aircover']['config']`.  The default database config does this.

* `['aircover']['config']['database_driver']` (default: `'sqlite3'`) - Database Driver
* `['aircover']['config']['database_config']` (default: `'/var/lib/drone/drone.sqlite'`) - Database Config

## Recipes

### aircover::default

This installs aircover fronted by http directly from the container.

Include `aircover::default` in your run_list.

```json
{
  "run_list": [
    "recipe[aircover::default]"
  ]
}
```

### aircover::reverse_proxy

This installs aircover, deploys certificates, installs NGINX and configures it
to do reverse proxy to the aircover container.  This allows https to aircover.

Include `aircover::reverse_proxy` in your run_list.

```json
{
  "run_list": [
    "recipe[aircover::reverse_proxy]"
  ]
}
```

## Testing

* Linting - Rubocop and Foodcritic
* Spec - ChefSpec
* Integration - Test Kitchen

Testing requires [ChefDK](https://downloads.chef.io/chef-dk/) be installed using it's native gems.

```
gem install docker-api
foodcritic -f any -X spec .
rubocop
rspec --color --format progress
```

If you run into issues testing please first remove any additional gems you may
have installed into your ChefDK environment.  Extra gems can be found and removed
at `~/.chefdk/gem`.

## License and Authors

Author:: Jacob McCann (<jacob.mccann2@target.com>)

```text
Copyright (c) 2016 Jacob McCann, All Rights Reserved.
```
