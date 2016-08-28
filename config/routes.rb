Refinery::Core::Engine.routes.draw do

  namespace :snippets, :path => '' do
    namespace :admin, :path => Refinery::Core.backend_route do
      resources :snippets do
        collection do
          post :update_positions
        end
        
        resources :snippets_page_parts do
          member do
            get 'add'
            get 'remove'
          end
        end
      end
    end
  end
  
end
