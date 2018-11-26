<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">

    <title>赵霞智慧物流园</title>
    <style type="text/css">
        *{margin:0;padding:0;}
        html{height: 100%}
        body{font-family: "Microsoft YaHei Bold","Microsoft YaHei Regular","Microsoft YaHei";color:#484848;font-size: 14px;overflow: hidden;height: 100%;}
        body section{width: 100%;height: 100%;}
        #errorBody{width: 90%;margin: 0 auto;text-align: center;padding: 16px;max-width: 500px;}
        #errorBody img{width: 70%;margin-top: 25%}
        .err-tip{color:#045684}
        .weui-btn{position: relative;display: block;margin-left: auto;margin-right: auto;padding-left: 14px;padding-right: 14px;box-sizing: border-box;font-size: 18px;text-align: center;text-decoration: none;color: #fff;line-height: 2.55555556;border-radius: 5px;-webkit-tap-highlight-color: rgba(0,0,0,0);overflow: hidden;}
        .weui-btn_primary{background-color: #045684;}
        .weui-btn_danger{background-color: #eb3030}
        .backToIndex{width: 140px;font-size: 14px;border-radius: 18px;margin-top: 20px}
    </style>
    <script src="/lib/jquery/jquery-2.1.4.js"></script>
</head>
<body>
<section>
    <div id="errorBody">
        <img src="/images/wechat/404.png;">
        <p class="err-tip" style="font-size: 18px; margin-top: 50px; ">哎呀，页面出现错误！ </p>
        <p style="font-size: 12px; margin-top: 20px;">您搜索的页面不存在或已被删除，您可以选择：</p>
        <a class="backToIndex weui-btn weui-btn_primary" href="javascript:;" onclick="javascript:history.back(-1);">返回</a>
    </div>
</section>

<script>
    function is_weixin() {
        var ua = window.navigator.userAgent.toLowerCase();
        if (ua.match(/MicroMessenger/i) != 'micromessenger') {
            $('#errorBody img').attr('src','/images/web/404.png');
            $('.err-tip').css({color:'#eb3030'})
            $('.weui-btn').addClass('weui-btn_danger');
        }
    }
    is_weixin();
</script>
</body>
</html>

