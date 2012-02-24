Refinery::Core::Engine.routes.draw do
  namespace :admin, :path => 'refinery' do
    resources :snippets do
      post :update_positions, :on => :collection

      resources :snippets_page_parts do
        member do
          get 'add'
          get 'remove'
        end
      end
    end
  end
end
