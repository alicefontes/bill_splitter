Rails.application.routes.draw do
  root :to => "product#show"
  post '/split', to: 'product#new'
  get '/list', to: 'product#list', as: :list
  get '/view/:item', to: 'product#view', as: :view
  post '/new', to: 'product#new', as: :new
  delete '/delete/:item', to: 'product#delete', as: :delete
  get '/edit/:item', to: 'product#edit', as: :edit
  put '/save_edit/:item', to: 'product#save_edit', as: :save_edit
end
