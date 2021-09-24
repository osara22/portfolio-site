Rails.application.routes.draw do
  root to: 'public/homes#top'

  get 'admin' => 'admin/homes#top'


  namespace :admin do
    resources :blogs, only:[:index, :new, :create, :show, :edit, :update]
  end

  scope module: :public do
    resources :questions, only:[:index, :new, :create ,:show, :update] do
      collection do
        get 'unsolved'
        get 'solved'
        get 'my_question'
        post 'check'
      end
      member do
        # ベストアンサーを選ぶ画面
        get 'best_select' => 'questions#best_select'
        resources :answers, only:[:new, :create] do
          post 'check'
        end
      end
    end

    resources :blogs, only:[:index, :show, :my_favorite] do
      resources :blog_comments, only: [:create]
      resource :blog_favorites, only: [:create, :destroy]
    end
    get 'my_favorite_blogs' => 'blogs#my_favorite'

    resource :contacts, only: [:new, :create] do
      get 'thank'
    end
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
