<#include "/common/headerWechat.ftl"/>
<header class="bar bar-nav">
    <h3 class="title">重设密码</h3>
    <a href="javascript:;" onClick="javascript :history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/owner/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body resLog_box">
        <h4>重设登录密码</h4>
        <p class="reg_tip">重新设置登录密码后，原有的登录密码即作废。</p>
        <form id="reset_form" class="reg_form">
            <div class="item">
                <input name="phone" type="number" placeholder="请输入手机号码">
                <a class="sendVerCode">获取验证码</a>
            </div>
            <div class="item">
                <input name="captcha" placeholder="请输入短信验证码">
            </div>
            <div class="item">
                <input name="password" type="password" placeholder="请输入新的6-20位登录密码">
                <a class="showHideBtn">显示</a>
            </div>
            <div class="item_submit">
                <a href="javascript:;" class="weui-btn weui-btn_primary resetPassword">确认重设</a>
            </div>
        </form>
    </div>
</section>
<script>
    $(function () {
        $("#reset_form").validate({
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
                    isMobile:'请填写一个有效的电话号码'
                },
                captcha:{
                    required:'请输入验证码',
                    rangelength:'验证码为6位数字'
                },
                password:{
                    required:'请输入密码',
                    minlength:'最少输入6位密码',
                    rangelength:'请填写6-20位密码',
                    password:'密码只能是数字、字母与下划线'
                }
            },
        });
        //发送验证码
        tools.sendMsgCode($(".sendVerCode"),'/api/captcha/forgetPassword','2');
        //显示隐藏
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
        //修改密码
        $(".resetPassword").on('click',function () {
            var flag = $("#reset_form").valid();
            if(!flag){
                //没有通过验证
                return;
            }else{
                var data=tools.hashToJson($('#reset_form').serialize().substring(0).split("&"));
                console.log(data);
                tools.ajaxPut('/api/owner/changePwd',data,function (json) {
                    $.toast("修改成功",1000,function () {
                        tools.navigate("/owner/login");
                    });
                })
            }
        })
    })
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
<#include "/common/footerWechat.ftl"/>
