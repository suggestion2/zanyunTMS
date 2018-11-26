$(function() {
    $.ajaxSetup({
        statusCode: {
            401: function(data) {
                console.log(data);
            }
        }
    });
});

function sendAjax(params) {
    $.ajax({
        type: params.type,
        url: params.url,
        data: params.data,
        dataType: "json",
        contentType: "application/json",
        success: function (data) {
            params.success(data);
        },
        error: function (data) {
            params.error(data);
        }
    });
}

function getCaptcha() {
    var params = {
        type: "POST",
        url: "/api/captcha",
        data: JSON.stringify({
            "phone": $("#sms-phone").val()
        }),
        success: function (data) {
            $("#captcha").val(data.captcha);
        },
        error: function (data) {
            console.log(data);
        }
    };

    sendAjax(params);
}


