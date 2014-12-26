$(document).ready(function(){

});

function volumeUp(volValue){
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