<#include "/common/driverCenterHeaderWeb.ftl"/>
    <div class="panel">
        <div class="panel-heading">
            <h5 class="panel-title"><i></i>个人设置</h5>
        </div>
        <div class="panel-body">
            <div class="center_tab setting-panel">
                <ul class="nav nav-tabs">
                    <li class="active" data-tab="tab1"><a>修改密码</a></li>
                    <li data-tab="tab2"><a>修改专线信息</a></li>
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
                    <form class="form-horizontal resetForm taskFrom" id="address_form" role="form">
                        <div class="title text-center">专线1</div>
                        <div class="item clearfix">
                            <label class="label_fix  pull-left">起点：</label>
                            <div class="inputBox pull-left addressBox" id="startAddress">
                                <select class="form-control" id="taskProvince1" name="taskProvince1" <#if driver.taskProvince1??&&driver.taskProvince1!=''>data-province="${driver.taskProvince1}"<#else>data-province="—— 省 ——"</#if>></select>
                                <select class="form-control" id="taskCity1" name="taskCity1" <#if driver.taskCity1??&&driver.taskCity1!=''>data-city="${driver.taskCity1}"<#else>data-city="—— 市 ——"</#if>></select>
                                <select class="form-control" id="taskCounty1" name="taskCounty1" <#if driver.taskCounty1??&&driver.taskCounty1!=''>data-district="${driver.taskCounty1}"<#else>data-district="—— 区 ——"</#if>></select>
                            </div>
                        </div>
                        <div class="item clearfix">
                            <label class="label_fix  pull-left">终点：</label>
                            <div class="inputBox pull-left addressBox" id="endAddress">
                                <select class="form-control" id="taskProvince2" name="taskProvince2" <#if driver.taskProvince2??&&driver.taskProvince2!=''>data-province="${driver.taskProvince2}"<#else>data-province="—— 省 ——"</#if>></select>
                                <select class="form-control" id="taskCity2" name="taskCity2" <#if driver.taskCity2??&&driver.taskCity2!=''>data-city="${driver.taskCity2}"<#else>data-city="—— 市 ——"</#if>></select>
                                <select class="form-control" id="taskCounty2" name="taskCounty2" <#if driver.taskCounty2??&&driver.taskCounty2!=''>data-district="${driver.taskCounty2}"<#else>data-district="—— 区 ——"</#if>></select>
                            </div>
                        </div>
                        <div class="title text-center">专线2</div>
                        <div class="item clearfix">
                            <label class="label_fix  pull-left">起点：</label>
                            <div class="inputBox pull-left addressBox" id="startAddress1">
                                <select class="form-control" id="taskProvince3" name="taskProvince3" <#if driver.taskProvince3??&&driver.taskProvince3!=''>data-province="${driver.taskProvince3}"<#else>data-province="—— 省 ——"</#if>></select>
                                <select class="form-control" id="taskCity3" name="taskCity3" <#if driver.taskCity3??&&driver.taskCity3!=''>data-city="${driver.taskCity3}<#else>data-city="—— 市 ——"</#if>"></select>
                                <select class="form-control" id="taskCounty3" name="taskCounty3" <#if driver.taskCounty3??&&driver.taskCounty3!=''>data-district="${driver.taskCounty3}"<#else>data-district="—— 区 ——"</#if> ></select>
                            </div>
                        </div>
                        <div class="item clearfix">
                            <label class="label_fix  pull-left">终点：</label>
                            <div class="inputBox pull-left addressBox" id="endAddress1">
                                <select class="form-control" id="taskProvince4" name="taskProvince4" <#if driver.taskProvince4??&&driver.taskProvince4!=''>data-province="${driver.taskProvince4}"<#else>data-province="—— 省 ——"</#if>></select>
                                <select class="form-control" id="taskCity4" name="taskCity4" <#if driver.taskCity4??&&driver.taskCity4!=''>data-city="${driver.taskCity4}"<#else>data-city="—— 市 ——"</#if>></select>
                                <select class="form-control" id="taskCounty4" name="taskCounty4" <#if driver.taskCounty4??&&driver.taskCounty4!=''>data-district="${driver.taskCounty4}"<#else>data-district="—— 区 ——"</#if>></select>
                            </div>
                        </div>
                        <div class="item_submit">
                            <a class="btn btn-danger" onclick="resetAddress()">确认修改</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
<#--地址选择器 -->
<script src="/lib/citypicker/distpicker.data.js"></script>
<script src="/lib/citypicker/distpicker.js"></script>
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
            url: '/api/driver/current',
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
        tools.sendMsgCode($(".sendVerCode"),'/api/captcha/forgetPassword','1');
        /*地址*/
        $('#startAddress').distpicker({
            placeholder: true,
            autoSelect: false
        });
        $('#endAddress').distpicker({
            placeholder: true,
            autoSelect: false
        });
        $('#startAddress1').distpicker({
            placeholder: true,
            autoSelect: false
        });
        $('#endAddress1').distpicker({
            placeholder: true,
            autoSelect: false
        });
    });
    function resetPassword() {
        var flag = $("#reset_form").valid();
        if(!flag){
            //没有通过验证
            return;
        }else{
            var data=tools.hashToJson($('#reset_form').serialize().substring(0).split("&"));
            tools.ajaxPut('/api/driver/changePwd',data,function (json) {
                tools.msg("修改成功",function () {
                    logout();
                });
            })
        }
    }

    function resetAddress() {
        var data=tools.hashToJson($('#address_form').serialize().substring(0).split("&"));
        tools.ajaxPut('/api/driver/updateInfo',data,function (json) {
            tools.msg("修改成功",function () {
                tools.navigate('');
            });
        })
    }
    // 密码验证
    jQuery.validator.addMethod("password", function(value, element) {
        return this.optional(element) || /^\w+$/.test(value);
    }, "密码只能是数字、字母与下划线");

</script>
<#include "/common/centerFooterWeb.ftl"/>

