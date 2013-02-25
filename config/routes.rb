Killthebugs::Application.routes.draw do

  get 'fragments/shared' => 'fragments#shared', :as => "shared_fragments"

  get 'share_fragment/:fragment_id/to/:user_id' => 'fragments#share', :as => "share_fragment"

  get 'unshare_fragment/:fragment_id/to/:user_id' => 'fragments#unshare', :as => "unshare_fragment"

  resources :fragments

  resource :settings, only: [:edit, :update]

  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :fragments, only: [:create]
    end
  end

  get "welcome/index"

  get "/f/:hashie" => "fragments#hashie", :as => "fragment_by_hashie"

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root to: 'fragments#new'
end
