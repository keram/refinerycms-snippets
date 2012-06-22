Refinery::Core::Engine.routes.append do

  # Admin routes
  namespace :admin, :path => 'refinery', :as => 'admin' do
    resources :snippets, except: :show do
      collection do
        post :update_positions
      end
    end
    resources :snippets_page_parts do
      member do
        get 'add'
        get 'remove'
      end
    end
  end

end