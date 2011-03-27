Ajaxdemo::Application.routes.draw do
  resources :tasks do
    member do
      put 'taskname' 
    end  
  end

  root :to  => "tasks#index"
end
