Rails.application.routes.draw do
  root :to => "split#show"
  post '/split', to: 'split#new'
  get '/list', to: 'split#list'
  get '/view', to: 'split#view'
  post '/new', to: 'split#new'
  delete '/delete', to: 'split#delete'
end
