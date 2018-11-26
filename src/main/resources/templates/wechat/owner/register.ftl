<#include "/common/headerWechat.ftl"/>
<header class="bar bar-nav">
    <h3 class="title">创建货主账号</h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/owner/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body resLog_box">
        <h4>创建货主账号</h4>
        <p class="reg_tip">使用您的手机号码创建账号并开启货主账户。</p>
        <form id="register_form" class="reg_form">
            <div class="item">
                <input name="phone" placeholder="请输入手机号码">
                <a class="sendVerCode">获取验证码</a>
            </div>
            <div class="item">
                <input name="captcha" placeholder="请输入短信验证码">
            </div>
            <div class="item">
                <input name="password" type="password" placeholder="请输入6-20位字符作为登录密码">
                <a class="showHideBtn">显示</a>
            </div>
            <div class="item_submit">
                <a href="javascript:;" class="weui-btn weui-btn_primary createAccount" onclick="addAccount()">创建账号</a>
            </div>
            <p class="weui-agree__text">点击“创建账号”或“继续”即表示同意赵霞智慧物流园的<a href="javascript:;" class="open-popup" data-target="#userAgree">用户服务条款</a></p>
            <div class="item_band">
                <a href="javascript:;" class="weui-btn weui-btn_primary" onclick="goToLogin()">已有货主账号，立即登录</a>
            </div>
        </form>
    </div>
</section>
<div id="userAgree" class="weui-popup__container userAgree">
    <div class="weui-popup__overlay"></div>
    <div class="weui-popup__modal">
        <header>
            <h4>用户服务条款</h4>
        </header>
        <article class="weui-article">
            <p class="first">请仔细阅读本《用户服务条款》，其中包含了关于您的法定权利和义务的重要信息。访问或使用赵霞物流信息平台表示您同意遵守本《用户服务条款》并受其约束。</p>
            <p class="second">本《用户服务条款》（“《服务条款》”）构成您与赵霞智慧物流园（定义见下）之间具有法律约束力的协议（“协议”），适用于您访问和使用赵霞智慧物流园网站（包括其中任何子域名）以及赵霞智慧物流园借以提供服务的任何其他网站（合称“网站”）、我们的手机、平板电脑及其他智能设备应用及应用程序界面（合称“应用”）和所有相关服务（合称“赵霞物流服务”）。网站、应用和赵霞物流服务在本协议下文中统称“赵霞物流信息平台”。</p>
            <section>
                <h5 class="title">1.账户注册</h5>
                <p>1.1 您必须注册账户（“赵霞物流账户”）才能访问和使用赵霞物流信息平台的特定功能，例如发布或预订服务项目。如果您为公司或其他法人实体注册赵霞物流账户，您陈述并保证您有权在法律上约束该实体，并授予我们本《服务条款》规定的所有准许和许可。</p>
            </section>
        </article>
        <footer>
            <a href="javascript:;" class="weui-btn weui-btn_primary close-popup">同意并继续</a>
        </footer>
    </div>
</div>
<script>
    $(function () {
        $("#register_form").validate({
            rules:{
                phone:{
                    required:true,
                    isMobile:true
                },
                captcha:{
                    required:true,
                    rangelength:[6,6]
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
                    rangelength:'验证码为6位数字'
                },
                password:{
                    required:'请输入密码',
                    minlength:'最少输入6位密码',
                    rangelength:'请填写6-20位密码',
                    password:'密码只能是数字、字母与下划线',
                }
            },
        });

//        显示隐藏
        $(".showHideBtn").on('click',function () {
            console.log($(this).text());
            if($(this).text()=='显示'){
                $(this).parent().find('[name=password]').attr('type','text');
                $(this).text('隐藏');
            }else{
                $(this).parent().find('[name=password]').attr('type','password');
                $(this).text('显示');
            }
        });
//        发送验证码
        tools.sendMsgCode($(".sendVerCode"),'/api/captcha/register','2');
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

    function addAccount() {
        var flag = $("#register_form").valid();
        if(!flag){
            //没有通过验证
            return;
        }else{
            var data=tools.hashToJson($('#register_form').serialize().substring(0).split("&"));
            console.log(data);
            tools.ajaxPost('/api/owner/register',data,function (json) {
                $.toast("注册成功",1000,function () {
                    tools.navigate("/owner/center");
                });
            })
        }
    }
    function goToLogin() {
        tools.navigate("/owner/login");
    }
</script>
<#include "/common/footerWechat.ftl"/>
