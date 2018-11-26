<#include "/common/headerWeb.ftl"/>
<div id="large-header" class="large-header">
    <h2 class="login_title" onclick="location.href='/'">赵霞智慧物流</h2>
    <div class="login_box" style="height: 420px">
        <ul id="myTab" class="nav nav-tabs">
            <li class="col-xs-12 active"><a href="#register" data-toggle="tab" style="color: #333">司机注册</a>
        </ul>
        <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade in active" id="register">
                <form class="form-horizontal" role="form" id="register_form">
                    <div class="item form-group">
                        <input class="form-control" name="phone" placeholder="请输入手机号" type="text">
                        <span class=" form-control-feedback sendVerCode">获取验证码</span>
                    </div>
                    <div class="item form-group">
                        <input class="form-control" name="captcha" placeholder="请输入短信验证码" type="text">
                        <span class="glyphicon glyphicon-ok form-control-feedback"></span>
                    </div>
                    <div class="item form-group">
                        <input class="form-control" name="password" placeholder="请输入6-20位的登录密码" type="password">
                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                    </div>
                    <div class="item_submit form-group" style="margin-top: 16px;margin-bottom: 0">
                        <button type="button" class="btn btn-danger resLogBtn" onclick="addAccount()">创建账号</button>
                        <p class="register-tip">点击“创建账号”即表示同意赵霞智慧物流园<a href="javascript:;"  data-toggle="modal" data-target="#userAgree">用户服务条款</a></p>
                    </div>
                    <div class="item_band form-group" style="margin-bottom: 0">
                        <a href="javascript:;" class="btn btn-danger resLogBtn" onclick="location.href='/login'">已有司机账号，立即登录</a>
                    </div>
                </form>
                <div class="row text-center">
                    <a href="/" style="color: #fff"><span class="glyphicon glyphicon-share-alt"></span> 返回首页</a>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<div class="modal fade" id="userAgree" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    用户服务条款
                </h4>
            </div>
            <div class="modal-body userAgreeBox">
                <article class="article">
                    <p class="first">请仔细阅读本《用户服务条款》，其中包含了关于您的法定权利和义务的重要信息。访问或使用赵霞物流信息平台表示您同意遵守本《用户服务条款》并受其约束。</p>
                    <p class="second">本《用户服务条款》（“《服务条款》”）构成您与赵霞智慧物流园（定义见下）之间具有法律约束力的协议（“协议”），适用于您访问和使用赵霞智慧物流园网站（包括其中任何子域名）以及赵霞智慧物流园借以提供服务的任何其他网站（合称“网站”）、我们的手机、平板电脑及其他智能设备应用及应用程序界面（合称“应用”）和所有相关服务（合称“赵霞物流服务”）。网站、应用和赵霞物流服务在本协议下文中统称“赵霞物流信息平台”。</p>
                    <section>
                        <h5 class="title">1.账户注册</h5>
                        <p>1.1 您必须注册账户（“赵霞物流账户”）才能访问和使用赵霞物流信息平台的特定功能，例如发布或预订服务项目。如果您为公司或其他法人实体注册赵霞物流账户，您陈述并保证您有权在法律上约束该实体，并授予我们本《服务条款》规定的所有准许和许可。</p>
                    </section>
                </article>
                <footer class="text-center">
                    <a href="javascript:;" class="btn btn-danger close-popup" data-dismiss="modal" aria-hidden="true">同意并继续</a>
                </footer>
            </div>
        </div>
    </div>
</div>
<script>
    var width,height,target;
    $(function () {
        /*背景图片 */
        initHeader();
        $(window).resize(function() {
            initHeader();
        });
        /*重设密码验证*/
        $("#register_form").validate({
            rules:{
                phone:{
                    required:true,
                    isMobile:true
                },
                captcha:{
                    required:true,
                    minlength:6
                },
                password:{
                    required:true,
                    minlength: 6,
                    rangelength: [6, 20],
                    password:true
                }
            },
            messages:{
                phone:{
                    required:'请输入手机号码',
                    isMobile:'请填写一个有效的电话号码',
                },
                captcha:{
                    required:'请输入验证码',
                    minlength:'验证码为6位数字'
                },
                password:{
                    required:'请输入密码',
                    minlength:'最少输入6位密码',
                    rangelength:'请填写6-20位密码',
                    password:'密码只能是数字、字母与下划线',
                }
            },
        });

        /*发送验证码*/
        tools.sendMsgCode($(".sendVerCode"),'/api/captcha/register','1');


    });

    /*修改密码*/
    function addAccount() {
        var flag = $("#register_form").valid();
        if(!flag){
            //没有通过验证
            return;
        }else{
            var data=tools.hashToJson($('#register_form').serialize().substring(0).split("&"));
            tools.ajaxPost('/api/driver/register',data,function (json) {
                tools.msg("注册成功",function () {
                    tools.navigate("/driver/completeInfo");
                });
            })
        }
    }

    function initHeader() {
        width=$(window).innerWidth();
        height=$(window).innerHeight();
        target={x:width/2,y:height/2}
        $(".large-header").css({'height':height+'px'});
    }

    // 手机号码验证
    jQuery.validator.addMethod("isMobile", function(value, element) {
        var length = value.length;
        var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
        return this.optional(element) || (length == 11 && mobile.test(value));
    }, "请正确填写您的手机号码");
    // 密码验证
    jQuery.validator.addMethod("password", function(value, element) {
        return this.optional(element) || /^\w+$/.test(value);
    }, "密码只能是数字、字母与下划线");

</script>
</body>
</html>