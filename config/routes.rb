Arcadia::Application.routes.draw do
  match 'radio_lists/play_stream/:id' => 'radio_lists#play_stream',
        as: 'play_stream'
  match 'radio_lists/stop_stream/:id' => 'radio_lists#stop_stream',
        as: 'stop_stream'
  match 'radio_lists/volume_change' => 'radio_lists#volume_change'
  match 'radio_lists/play_again' => 'radio_lists#play_again'
  match 'radio_lists/reset_all' => 'radio_lists#reset_all'
  resources :radio_lists

  match 'file_player/play_files' => 'file_player#play_files'
  resources :file_player

  root to: 'welcome#home'
end
