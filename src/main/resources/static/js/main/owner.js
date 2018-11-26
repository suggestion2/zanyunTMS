$(function() {
    console.log(location.href.split('#')[0]);

    $.ajax({
        type: "POST",
        url: "/weChatJsConfigParams",
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
});

function pay() {
    $.ajax({
        type: "GET",
        url: "/weChatJsPayParams",
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


