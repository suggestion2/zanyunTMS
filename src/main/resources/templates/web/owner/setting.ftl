<#include "/common/ownerCenterHeaderWeb.ftl"/>
    <div class="panel">
        <div class="panel-heading">
            <h5 class="panel-title"><i></i>个人设置</h5>
        </div>
        <div class="panel-body">
            <div class="center_tab setting-panel">
                <ul class="nav nav-tabs">
                    <li class="active" data-tab="tab1"><a>修改密码</a></li>
                    <li data-tab="tab2"><a>修改名称</a></li>
                </ul>
                <div class="tab-content on" data-id="tab1">
                    <form class="form-horizontal resetForm" id="reset_form" role="form">
                        <div class="item clearfix">
                            <label class="label_fix  pull-left">手机号：</label>
                            <div class="pull-left">
                                <input class="form-control" name="phone" id="phone" readonly>
                                <span class="form-control-feedback sendVerCode">获取验证码</span>
                            </div>
                        </div>
                        <div class="item  clearfix">
                            <label class="label_fix pull-left">验证码：</label>
                            <div class="pull-left">
                                <input class="form-control" name="captcha" placeholder="请输入短信验证码">
                                <span class="glyphicon glyphicon-ok form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="item  clearfix">
                            <label class="label_fix pull-left">新密码：</label>
                            <div class="pull-left">
                                <input class="form-control" name="password" placeholder="请输入新的6-20位登录密码">
                                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="item_submit">
                            <a class="btn btn-danger" onclick="resetPassword()">确认修改</a>
                        </div>
                    </form>
                </div>
                <div class="tab-content" data-id="tab2">
                    <form class="form-horizontal resetForm" id="nameForm" role="form">
                        <div class="item  clearfix">
                            <label class="label_fix pull-left">名称：</label>
                            <div class="pull-left">
                                <input class="form-control" name="name" value="<#if owner.name??>${owner.name}<#else>${owner.phone}</#if>" placeholder="请输入少于6位中文姓名">
                                <span class="glyphicon glyphicon-ok form-control-feedback"></span>
                            </div>
                        </div>
                        <div class="item_submit">
                            <a class="btn btn-danger" onclick="resetName()">确认修改</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
<script>
    $(function () {
        $('.setting-panel .nav-tabs li').on('click',function () {
            $(this).addClass('active').siblings().removeClass('active');
            var id=$(this).data('tab');
            $('[data-id='+id+']').addClass('on').siblings('.tab-content').removeClass('on');
        });

        //获取手机号
        tools.ajax({
            type: "GET",
            url: '/api/owner/current',
            contentType: APPLICATION_JSON,
            success:function (json) {
                $("#phone").val(json.phone);
            }
        });

        /*重设密码验证*/
        $("#reset_form").validate({
            rules:{
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
        $("#nameForm").validate({
            rules:{
                name:{
                    required:true,
                    rangelength:[1,6],
                    isChinese:true
                },
            },
            messages:{
                name:{
                    required:'请输入姓名',
                    rangelength:'姓名少于6位字符的中文',
                    isChinese:'请输入中文'
                },
            }
        });

        tools.sendMsgCode($(".sendVerCode"),'/api/captcha/forgetPassword','2');
    });
    function resetPassword() {
        var flag = $("#reset_form").valid();
        if(!flag){
            //没有通过验证
            return;
        }else{
            var data=tools.hashToJson($('#reset_form').serialize().substring(0).split("&"));
            tools.ajaxPut('/api/owner/changePwd',data,function (json) {
                tools.msg("修改成功",function () {
                    logout();
                });
            })
        }
    }
    function resetName() {
        var flag = $("#nameForm").valid();
        if(!flag){
            //没有通过验证
            return;
        }else{
            var data=tools.hashToJson($('#nameForm').serialize().substring(0).split("&"));
            tools.ajaxPut('/api/owner/update',data,function (json) {
                $('.user_header>p').text(data.name);
            })
        }
    }
    /*验证中文字符*/
    jQuery.validator.addMethod("isChinese", function(value, element) {
        return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);
    }, "只能包含中文字符。");
    // 密码验证
    jQuery.validator.addMethod("password", function(value, element) {
        return this.optional(element) || /^\w+$/.test(value);
    }, "密码只能是数字、字母与下划线");

</script>
<#include "/common/centerFooterWeb.ftl"/>

