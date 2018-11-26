<#include "/common/headerWeb.ftl"/>
<div id="large-header" class="large-header">
    <h2 class="login_title">赵霞智慧物流</h2>
    <div class="login_box">
        <ul id="myTab" class="nav nav-tabs">
            <li class="col-xs-12 active"><a href="#reset" data-toggle="tab" style="color: #333">重设司机登录密码</a>
        </ul>
        <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade in active" id="reset">
                <form class="form-horizontal" role="form" id="reset_form">
                    <div class="item form-group">
                        <input class="form-control" name="phone" placeholder="请输入手机号" type="text">
                        <span class=" form-control-feedback sendVerCode">获取验证码</span>
                    </div>
                    <div class="item form-group">
                        <input class="form-control" name="captcha" placeholder="请输入短信验证码" type="text">
                        <span class="glyphicon glyphicon-ok form-control-feedback"></span>
                    </div>
                    <div class="item form-group">
                        <input class="form-control" name="password" placeholder="请输入新的6-20位登录密码" type="text">
                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                    </div>
                    <div class="item_submit form-group" style="margin-top: 16px">
                        <button type="button" class="btn btn-danger resLogBtn" onclick="resetPassword()">确认重设</button>
                    </div>
                </form>
                <div class="row">
                    <div class="col-xs-6 text-left"><a href="/" style="color: #fff"><span class="glyphicon glyphicon-share-alt"></span> 返回首页</a></div>
                    <div class="col-xs-6 text-right"><a href="/login" style="color: #fff"><span class="glyphicon glyphicon-user"></span> 返回登录</a></div>
                </div>
            </div>
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
                    isMobile:'请填写一个有效的电话号码',
                    checkRepeat:'该号码未注册'
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
            }
        });

        /*发送验证码*/
        tools.sendMsgCode($(".sendVerCode"),'/api/captcha/forgetPassword','1');

    });

    /*修改密码*/
    function resetPassword() {
        var flag = $("#reset_form").valid();
        if(!flag){
            //没有通过验证
            return;
        }else{
            var data=tools.hashToJson($('#reset_form').serialize().substring(0).split("&"));
            tools.ajaxPut('/api/driver/changePwd',data,function (json) {
                tools.msg("修改成功",function () {
                    tools.navigate("/login");
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