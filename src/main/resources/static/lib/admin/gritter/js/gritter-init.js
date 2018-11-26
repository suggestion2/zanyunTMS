var Gritter = function () {

    $('#add-sticky').click(function(){

        var unique_id = $.gritter.add({
            // (string | mandatory) the heading of the notification
            title: '这是一个固定不消失的通知。',
            // (string | mandatory) the text inside the notification
            text: '并且提示内容和原网页是分离的，查看gritter-init.js可以看到分离后的调用编辑格式。',
            // (string | optional) the image to display on the left
            image: 'images/avatar-mini.jpg',
            // (bool | optional) if you want it to fade out on its own or just sit there
            sticky: true,
            // (int | optional) the time you want it to be alive for before fading out
            time: '',
            // (string | optional) the class name you want to apply to that specific message
            class_name: 'my-sticky-class'
        });

        // You can have it return a unique id, this can be used to manually remove it later using
        /*
         setTimeout(function(){

         $.gritter.remove(unique_id, {
         fade: true,
         speed: 'slow'
         });

         }, 6000)
         */

        return false;

    });

    $('#add-regular').click(function(){

        $.gritter.add({
            // (string | mandatory) the heading of the notification
            title: '这是一个定期通知!',
            // (string | mandatory) the text inside the notification
            text: '这个通知在稍后会消失。 并且提示内容和原网页是分离的，查看gritter-init.js可以看到分离后的调用编辑格式。',
            // (string | optional) the image to display on the left
            image: 'images/avatar-mini.jpg',
            // (bool | optional) if you want it to fade out on its own or just sit there
            sticky: false,
            // (int | optional) the time you want it to be alive for before fading out
            time: ''
        });

        return false;

    });

    $('#add-max').click(function(){

        $.gritter.add({
            // (string | mandatory) the heading of the notification
            title: '这个消息在屏幕上最多显示三次',
            // (string | mandatory) the text inside the notification
            text: '稍后将会消失。这个消息提示最大为3。请注意。',
            // (string | optional) the image to display on the left
            image: 'images/avatar-mini.jpg',
            // (bool | optional) if you want it to fade out on its own or just sit there
            sticky: false,
            // (function) before the gritter notice is opened
            before_open: function(){
                if($('.gritter-item-wrapper').length == 3)
                {
                    // Returning false prevents a new gritter from opening
                    return false;
                }
            }
        });

        return false;

    });

    $('#add-without-image').click(function(){

        $.gritter.add({
            // (string | mandatory) the heading of the notification
            title: '这是不带图片的消息框!',
            // (string | mandatory) the text inside the notification
            text: '稍后消失，和第一个没有太大区别，只是没有头像图片'
        });

        return false;
    });

    $('#add-gritter-light').click(function(){

        $.gritter.add({
            // (string | mandatory) the heading of the notification
            title: '这是一个白色半透明底的信息提示',
            // (string | mandatory) the text inside the notification
            text: '在gritter-init.js里面的相关代码添加class_name:"gritter-light"就可以实现。',
            class_name: 'gritter-light'
        });

        return false;
    });

    $("#remove-all").click(function(){

        $.gritter.removeAll();
        return false;

    });



}();