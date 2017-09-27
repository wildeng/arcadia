Arcadia::Application.routes.draw do
  match 'radio_lists/play_stream/:id' => 'radio_lists#play_stream',
        as: 'play_stream', via: %i[get post]
  match 'radio_lists/stop_stream/:id' => 'radio_lists#stop_stream',
        as: 'stop_stream', via: %i[get post]
  match 'radio_lists/volume_change' => 'radio_lists#volume_change',
        via: %i[get post]
  match 'radio_lists/play_again' => 'radio_lists#play_again',
        via: %i[get post]
  match 'radio_lists/reset_all' => 'radio_lists#reset_all', via: %i[get post]
  resources :radio_lists

  match 'file_player/play_files' => 'file_player#play_files', via: %i[get post]
  resources :file_player

  root to: 'welcome#home'

  # api
  namespace :api do
    namespace :v1 do
      resources :radio_lists, only: %i[index create destroy update show new]
    end
  end
end
