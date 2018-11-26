<#include "/common/headerWeb.ftl"/>
<div id="large-header" class="large-header">
    <h2 class="login_title" onclick="location.href='/'">赵霞智慧物流</h2>
    <div class="login_box">
        <ul id="myTab" class="nav nav-tabs">
            <li class="col-xs-6 active"><a href="#driver" data-toggle="tab">司机登录</a></li>
            <li class="col-xs-6"><a href="#owner" data-toggle="tab">货主登录</a></li>
        </ul>
        <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade in active" id="driver">
                <form class="form-horizontal" role="form" id="driver-login-form">
                    <div class="item form-group">
                        <input class="form-control" name="phone" placeholder="请输入司机账号" type="text">
                        <span class="glyphicon glyphicon-earphone form-control-feedback"></span>
                    </div>
                    <div class="item form-group">
                        <input class="form-control" name="password" placeholder="请输入密码" type="password">
                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                    </div>
                    <div class="item_submit form-group">
                        <div class="checkbox clearfix">
                            <label class="pull-left">
                                <input type="checkbox">记住密码
                            </label>
                            <span class="pull-right" onclick="location='/driver/resetPassword'">忘记密码</span>
                        </div>
                        <button type="button" class="btn btn-danger resLogBtn" onclick="driverLogin()">登录</button>
                        <div class="social-auth-links text-center" style="margin: 8px 0">
                            <p>- OR -</p>
                        </div>
                        <button type="button" class="btn btn-danger resLogBtn"  onclick="location.href='/driver/register'">还没有司机账号，立即注册</button>
                        <div class="row text-center" style="margin-top: 10px;">
                            <a href="/" style="color: #fff"><span class="glyphicon glyphicon-share-alt"></span> 返回首页</a>
                        </div>
                    </div>
                </form>

            </div>
            <div class="tab-pane fade in" id="owner">
                <form class="form-horizontal" role="form" id="owner-login-form">
                    <div class="item form-group">
                        <input class="form-control" name="phone" placeholder="请输入货主账号" type="text">
                        <span class="glyphicon glyphicon-earphone form-control-feedback"></span>
                    </div>
                    <div class="item form-group">
                        <input class="form-control" name="password" placeholder="请输入密码" type="password">
                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                    </div>
                    <div class="item_submit form-group">
                        <div class="checkbox clearfix">
                            <label class="pull-left">
                                <input type="checkbox">记住密码
                            </label>
                            <span class="pull-right" onclick="location='/owner/resetPassword'">忘记密码</span>
                        </div>
                        <button type="button" class="btn btn-danger resLogBtn" onclick="ownerLogin()">登录</button>
                        <div class="social-auth-links text-center" style="margin: 8px 0">
                            <p>- OR -</p>
                        </div>
                        <button type="button" class="btn btn-danger resLogBtn"  onclick="location='/owner/register'">还没有货主账号，立即注册</button>
                        <div class="row text-center" style="margin-top: 10px;">
                            <a href="/" style="color: #fff"><span class="glyphicon glyphicon-share-alt"></span> 返回首页</a>
                        </div>
                    </div>
                </form>

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
        /*司机验证*/
        $("#driver-login-form").validate({
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
                    isMobile:'请填写一个有效的电话号码',
                },
                password:{
                    required:'请输入密码',
                    minlength:'最少输入6位密码',
                    rangelength:'请填写6-20位密码',
                    password:'密码只能是数字、字母与下划线',
                }
            }
        });
        /*货主验证*/
        $("#owner-login-form").validate({
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
                    isMobile:'请填写一个有效的电话号码',
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
    /*司机登录*/
    function driverLogin() {
        var flag = $("#driver-login-form").valid();
        if(!flag){
            //没有通过验证
            return;
        }else{
            var data=tools.hashToJson($('#driver-login-form').serialize().substring(0).split("&"));
            tools.ajaxPost('/api/driver/login',data,function (json) {
                tools.msg('登录成功',function () {
                    tools.navigate("/driver/center");
                })
            })
        }
    }
    /*货主登录*/
    function ownerLogin() {
        var flag = $("#owner-login-form").valid();
        if(!flag){
            //没有通过验证
            return;
        }else{
            var data=tools.hashToJson($('#owner-login-form').serialize().substring(0).split("&"));
            tools.ajaxPost('/api/owner/login',data,function (json) {
                tools.msg('登录成功',function () {
                    tools.navigate("/owner/center");
                })
            })
        }
    }
</script>
</body>
</html>