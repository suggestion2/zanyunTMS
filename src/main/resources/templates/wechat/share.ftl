<!DOCTYPE html>
<html lang="en" class="js-no-overflow-scrolling">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="cache-control" content="max-age=0">
    <meta http-equiv="cache-control" content="no-cache">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
    <title>赵霞智慧物流</title>
    <style>
        html, body {  margin: 0;  width: 100%;  height: 100%;  font-family: "Microsoft YaHei Bold","Microsoft YaHei Regular","Microsoft YaHei";  text-align: center;  }
        body{max-width: 500px;margin: 0 auto}
        * {  margin:0;  padding: 0;  }
        ul {  list-style: none;  }

        .fullscreenPage{
            position: relative;
        }
        .fullscreenPage .fullPage-wrap{
            width: 100%;
            height: 100%;
            overflow: hidden;
            position: relative;
        }
        .fullscreenPage .fullPage-wrap .item{
            position: absolute;
            top:0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: url("/images/wechat/share.jpg") no-repeat 0 0;
            background-position: center;
            background-size: cover;
            z-index:1;
        }
        .fullscreenPage .fullPage-wrap .item .code{
            width: 200px;
            position: absolute;
            bottom: 50px;
            left: 50%;
            margin-left: -100px;
            text-align: center;
        }
        .fullscreenPage .fullPage-wrap .item .code .codeImg{
            width: 180px;
            margin: 0 auto;
            display: block;
        }
        .fullscreenPage .fullPage-wrap .item .code p{
            font-size: 14px;
            color: #fff;
            margin: 8px 0;
        }
        .fullscreenPage .fullPage-wrap .item .code .fig{
            width: 30px;
        }
        .fullscreenPage .fullPage-wrap .item .btn{
            width: 100px;
            height: 32px;
            line-height: 32px;
            color: #fff;
            background: rgba(255,255,255,.1);
            text-align: center;
            position: absolute;
            left: 50%;
            margin-left: -50px;
            bottom: 10px;
            font-size: 14px;
            border-radius: 6px;
            border: 1px solid #fff;
        }
        .fullscreenPage .model-tip{
            position: absolute;
            top:0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: rgba(0,0,0,.6);
            z-index: 2;
            display: none;
        }
        .fullscreenPage .model-tip .shareTip-text{
            width: 200px;
            position: absolute;
            top: 12px ;
            right: 12px;
        }
        .fullscreenPage .model-tip .shareTip-btn{
            width: 80px;
            position: absolute;
            top: 160px;
            right: 80px;
        }
    </style>
</head>
<body class="fullscreenPage">
    <div class="fullPage-wrap">
        <div class="item">
            <div class="code">
                <img src="/images/wechat/shareCode.png" class="codeImg">
                <p>长按图片，识别二维码关注</p>
                <img src="/images/wechat/shareFingerprint.png" class="fig">
            </div>
            <div class="btn" id="shareBtn">立即分享</div>
        </div>
        <div class="model-tip" id="share-tip">
            <img src="/images/wechat/shareTip-text.png" class="shareTip-text">
            <img src="/images/wechat/shareTip-btn.png" class="shareTip-btn" id="closeBtn">
        </div>
    </div>
    <script src="/lib/jquery/jquery-2.1.4.js"></script>
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
    <script type="text/javascript">
        $(function () {
            $('#shareBtn').on('click',function () {
                $('#share-tip').show();
            });
            $('#closeBtn').on('click',function () {
                $('#share-tip').hide();
            });

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

            window.wx.ready(function() {
                window.wx.onMenuShareTimeline({
                    title: '赵霞智慧物流', // 分享标题
                    desc: '最便捷的物流平台，货源车源早知道。',
                    link: 'http://www.zxotms.com/share', // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
                    imgUrl: 'http://www.zxotms.com/images/wechat/share_img.jpg', // 分享图标
                    success: function () {
                        // 用户确认分享后执行的回调函数
                    },
                    cancel: function () {
                        // 用户取消分享后执行的回调函数
                    }
                });
                window.wx.onMenuShareAppMessage({
                    title: '赵霞智慧物流', // 分享标题
                    desc: '最便捷的物流平台，货源车源早知道。', // 分享描述
                    link: 'http://www.zxotms.com/share', // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
                    imgUrl: 'http://www.zxotms.com/images/wechat/share_img.jpg', // 分享图标
                    type: '', // 分享类型,music、video或link，不填默认为link
                    dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
                    success: function () {
// 用户确认分享后执行的回调函数
                    },
                    cancel: function () {
// 用户取消分享后执行的回调函数
                    }
                });
            });
        });
    </script>
</body>
</html>