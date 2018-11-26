var path = "/api/driver";

function register() {
    var params = {
        type: "POST",
        url: path + "/register",
        data: JSON.stringify({
            "phone": $("#phone").val(),
            "captcha": $("#captcha").val(),
            "password": $("#password").val()
        }),
        success: function (data) {
            console.log("success");
        },
        error: function (data) {
            console.log(data);
        }
    };

    sendAjax(params);
}

function login() {
    var params = {
        type: "POST",
        url: path + "/login",
        data: JSON.stringify({
            "phone": $("#phone").val(),
            "password": $("#password").val()
        }),
        success: function (data) {
            console.log("success");
        },
        error: function (data) {
            console.log(data);
        }
    };

    sendAjax(params);
}


