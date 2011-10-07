Refinery::Application.routes.draw do

  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
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
