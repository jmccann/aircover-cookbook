module ChefAircover
  # Methods for generating drone container ENV from node attributes
  module Env
    def aircover_env
      node['aircover']['config'].map { |k, v| "#{k.upcase}=#{v}" }
    end
  end
end

Chef::Recipe.send(:include, ChefAircover::Env)
DockerCookbook::DockerContainer.send(:include, ChefAircover::Env)
