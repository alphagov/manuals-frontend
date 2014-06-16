ManualsFrontend::Application.routes.draw do

  get '/guidance/:manual_id', to: 'manuals#index'
  get '/guidance/:manual_id/updates', to: 'manuals#updates'
  get '/guidance/:manual_id/:section_id', to: 'manuals#show'

  root to: proc { [404, {}, ['Not found']] }
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails::Engine)
end
