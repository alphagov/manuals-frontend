HmrcManualsFrontend::Application.routes.draw do

  resources :manuals, only: [:show]

  root to: proc { [404, {}, ['Not found']] }

end
