include_recipe 'aircover::default'

url = chef_vault_item(node['aircover']['vault'], 'github')['url']
client = chef_vault_item(node['aircover']['vault'], 'github')['client']
secret = chef_vault_item(node['aircover']['vault'], 'github')['secret']

# Change host port to bind 8000 so webserver can start on port 80
r = resources('docker_container[aircover]')
r.env r.env.push("GITHUB_URL=#{url}")
r.env r.env.push("GITHUB_CLIENT=#{client}")
r.env r.env.push("GITHUB_SECRET=#{secret}")
