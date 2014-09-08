ManualsFrontend::Application.routes.draw do

  # Holding page for /guidance/employment-income-manual
  get '/guidance/employment-income-manual', to: 'static_pages#employment_income_manual'
  get '/guidance/employment-income-manual/*section', to: redirect('/guidance/employment-income-manual')

  get '/guidance/:manual_id', to: 'manuals#index'
  get '/guidance/:manual_id/updates', to: 'manuals#updates'
  get '/guidance/:manual_id/:section_id', to: 'manuals#show'

  root to: proc { [404, {}, ['Not found']] }
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails::Engine)
end
