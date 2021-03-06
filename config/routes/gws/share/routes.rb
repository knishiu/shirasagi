SS::Application.routes.draw do
  Gws::Share::Initializer

  concern :deletion do
    get :delete, on: :member
    delete action: :destroy_all, :on => :collection
  end

  gws "share" do
    resources :files, concerns: [:deletion] do
      get :view, on: :member
      get :thumb, on: :member
      get :download, on: :member
    end
  end
end
