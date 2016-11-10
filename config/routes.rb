Rails.application.routes.draw do
  root :to => "split#show"
  post '/split', to: 'split#new'
  get '/list', to: 'split#list'
  get '/view/:item', to: 'split#view', as: :view
  post '/new', to: 'split#new'
  delete '/delete/:item', to: 'split#delete', as: :delete
  get '/edit/:item', to: 'split#edit', as: :edit
  put '/save_edit/:item', to: 'split#save_edit', as: :save_edit
end
