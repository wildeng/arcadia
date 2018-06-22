<template>
  <div v-if="showit == true" >
    <h3 id="volumeVal">
      {{ volume }}
    </h3>
    <input type="button" value="+" v-on:click="volumeUp(10);" />
    <input type="button" value="-" v-on:click="volumeUp(-10);" />
  </div>
</template>
<script>
  export default {
    props: {
      'showit': {
        default: false
      },
      'volume': {
        default: 0
      }
    },
    methods: {
      volumeUp: function volumeUp(volValue){
        var that;
        that = this;
        $.ajax({
            type: "post",
            dataType: "json",
            url: "/radio_lists/volume_change",
            data: {volValue:volValue},
            success: function(data){
                that.volume;
            }
        });
      }
    }
  }
</script>
