var configSuccess = 0;

$(function() {
    console.log(location.href.split('#')[0]);

    $.ajax({
        type: "POST",
        url: "/wechat/js/configParams",
        dataType: "json",
        contentType: "application/json",
        data: JSON.stringify({
            "url": location.href.split('#')[0]
        }),
        success: function (data) {
            window.wx.config({
                debug: true,
                appId: data.appId,
                timestamp: data.timestamp,
                nonceStr: data.nonceStr,
                signature: data.signature,
                jsApiList: data.jsApiList
            });
        },
        error: function (data) {
            console.log(data);
        }
    });


    wx.ready(function(){
        configSuccess = 1
    });
});

function pay() {

    if(configSuccess === 0){
        alert("wait for config");
        return false;
    }

    $.ajax({
        type: "GET",
        url: "/wechat/js/payParams/" + $("#paymentId").val(),
        success: function (data) {
            wx.chooseWXPay({
                timestamp: data.timestamp,
                nonceStr: data.nonceStr,
                package: data.package,
                signType: data.signType,
                paySign: data.paySign,
                success: function (data) {
                    console.log("js支付调用接口成功:");
                    console.log(data);
                }
            });
        },
        error: function (data) {
            console.log(data);
        }
    });
}


