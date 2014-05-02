HmrcManualsFrontend::Application.routes.draw do

  get '/guidance/employment-income-manual', to: 'manuals#index'
  get '/guidance/employment-income-manual/:section_id', to: 'manuals#show'

  root to: proc { [404, {}, ['Not found']] }
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails::Engine)
end
