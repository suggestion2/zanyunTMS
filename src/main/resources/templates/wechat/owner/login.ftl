<#include "/common/headerWechat.ftl"/>

<header class="bar bar-nav">
    <h3 class="title">登录货主账号</h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/owner/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="logo text-center">
        <img src="/images/wechat/logo.jpg" >
    </div>
    <div class="content_body resLog_box">
        <p class="reg_tip">输入已注册的货主账号和密码完成登录。货主使用订车服务须从公众号专门菜单进入。</p>
        <form id="login-form" class="reg_form">
            <div class="item">
                <input name="phone" placeholder="请输入手机号码">
            </div>
            <div class="item">
                <input name="password" type="password" placeholder="请输入登录密码">
            </div>
            <div class="item_submit">
                <a href="javascript:;" class="weui-btn weui-btn_primary createAccount" onclick="login()">登录</a>
            </div>
            <div class="item text-right">
                <a href="javascript:;" onclick="forgetPassword()">忘记密码</a>
            </div>
            <div class="item">
                <a href="javascript:;" class="weui-btn weui-btn_primary" onclick="register()">没有货主账号，立即注册</a>
            </div>
        </form>
    </div>
</section>
<script>
    $(function () {
        $("#login-form").validate({
            /*onkeyup: null,*/
            rules:{
                phone:{
                    required:true,
                    isMobile:true
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
                    isMobile:'请填写有效的电话号码'
                },
                password:{
                    required:'请输入密码',
                    minlength:'最少输入6位密码',
                    rangelength:'请填写6-20位密码',
                    password:'密码只能是数字、字母与下划线',
                }
            }
        });
    });
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

    function login() {
        var flag = $("#login-form").valid();
        if(!flag){
            //没有通过验证
            return;
        }else{
            var data=tools.hashToJson($('#login-form').serialize().substring(0).split("&"));
            tools.ajaxPost('/api/owner/login',data,function (json) {
                $.toast("登录成功",1000,function () {
                    tools.navigate("/owner/center");
                });
            })
        }
    }
    /*点击跳转*/
    function forgetPassword() {
        tools.navigate("/owner/resetPassword");
    }
    function register() {
        tools.navigate("/owner/register");
    }
</script>
<#include "/common/footerWechat.ftl"/>

