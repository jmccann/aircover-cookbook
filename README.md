# aircover

Cookbook to deploy [aircover](https://aircover.co).

## Supported Platforms

Tested And Validated On
- Ubuntu 15.04

## Usage

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
