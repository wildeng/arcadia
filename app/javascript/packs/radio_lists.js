import TurbolinksAdapter from 'vue-turbolinks';
import Vue from 'vue/dist/vue.esm'
import Buttons from './components/buttons'

document.addEventListener('DOMContentLoaded', () => {
  var radio_lists = new Vue({
    el: '#radio_lists',
    props: {
      'radio_lists': {
        default: []
      }
    },
    data: function() {
      return {
        showit: false
      }
    },
    components: {
      Buttons
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
            that.showit = true;
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
            that.showit = false;
          }
        });
      },
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
