Rails.application.routes.draw do
  root to: 'public/homes#top'

  get 'admin' => 'admin/homes#top'

  namespace :admin do
    resources :blogs, only:[:index, :new, :create, :show, :edit, :update]
  end

  # UserとAdminのログインページ
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    registrations: "publics/registrations",
    sessions: "publics/sessions",
    passwords: "publics/passwords",
    ragistrations: "publics/registrations"
  }
end
