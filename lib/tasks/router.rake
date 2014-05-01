namespace :router do
  task :router_environment => :environment do
    require 'plek'
    require 'gds_api/router'

    @router_api = GdsApi::Router.new(Plek.current.find('router-api'))
  end

  task :register_backend => :router_environment do
    @router_api.add_backend('hmrc-manuals-frontend', Plek.current.find('hmrc-manuals-frontend', :force_http => true) + "/")
  end

  task :register_routes => :router_environment do
    @router_api.add_route('/guidance/employment-income-manual', 'prefix', 'hmrc-manuals-frontend')
  end

  desc 'Register hmrc-manuals-frontend application and routes with the router'
  task :register => [ :register_backend, :register_routes ]
end
