Rails.application.routes.draw do
  resources :messages, only: [:index, :new, :create, :edit, :update, :destroy]
  get 'messages/send_message', to: 'messages#send_message'
  get 'messages/receive_messages', to: 'messages#receive_messages'
  root 'messages#index'
end
