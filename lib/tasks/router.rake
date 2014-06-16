namespace :router do
  task :router_environment => :environment do
    require 'plek'
    require 'gds_api/router'

    @router_api = GdsApi::Router.new(Plek.current.find('router-api'))
  end

  task :register_backend => :router_environment do
    @router_api.add_backend('manuals-frontend', Plek.current.find('manuals-frontend', :force_http => true) + "/")
  end

  task :register_routes => :router_environment do
    @router_api.add_route('/guidance/employment-income-manual', 'prefix', 'manuals-frontend')
    @router_api.add_redirect_route('/guidance', 'exact', '/government/publications', 'temporary')
  end

  desc 'Register manuals-frontend application and routes with the router'
  task :register => [ :register_backend, :register_routes ]
end
