import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm'
import App from '../app.vue'

document.addEventListener('DOMContentLoaded', () => {
  var radio_lists = new Vue({
    el: '#radio_lists',
    data: {
      radio_lists: []
    },
    methods: {
      play: function(id){
        var that;
        that = this;
        $.ajax({
          url: '/radio_lists/play_stream/' + id,
          contentType: 'application/json',
          type: 'get',
          success: function(response) {
            console.log('stream Playing')
          }
        });
      },
      stop: function(id){
        var that;
        that = this;
        $.ajax({
          url: '/radio_lists/stop_stream/' + id,
          contentType: 'application/json',
          type: 'get',
          success: function(response) {
            console.log('stop Playing')
          }
        });
      },
      volumeUp: function volumeUp(volValue){
        $.ajax({
            type: "post",
            dataType: "json",
            url: "/radio_lists/volume_change",
            data: {volValue:volValue},
            success: function(data){
                $('#volumeVal').html(data.volume);
            }
        });
      }
    },
    mounted: function() {
     var that;
     that = this;
     $.ajax({
       url: '/radio_lists.json',
       success: function(response) {
         that.radio_lists = response;
       }
     });
   }
  })
})
