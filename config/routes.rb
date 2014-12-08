ManualsFrontend::Application.routes.draw do
  with_options(constraints: { prefix: /(guidance|hmrc-internal-manuals)/ }) do |r|
    r.get '/:prefix/:manual_id', to: 'manuals#index'
    r.get '/:prefix/:manual_id/updates', to: 'manuals#updates'
    r.get '/:prefix/:manual_id/:section_id', to: 'manuals#show'
  end

  root to: proc { [404, {}, ['Not found']] }
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails::Engine)
end
