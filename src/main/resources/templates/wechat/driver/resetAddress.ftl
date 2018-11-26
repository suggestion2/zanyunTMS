<#include "/common/headerWechat.ftl"/>
<header class="bar bar-nav">
    <h3 class="title">重设往返地址</h3>
    <a href="javascript:;" onClick="javascript :history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/driver/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body resLog_box">
        <h4>重设专线地址</h4>
        <form id="address_form" class="reg_form reset_form" data-id="${driver.id}">
            <div class="title text-center" style="margin-bottom: 16px">专线1</div>
            <div class="item">
                <input name="startPlace" id="startPlace" readonly placeholder="请选择专线1起点" <#if (driver.taskCity1??&&driver.taskProvince1??&&driver.taskCounty1??)&&((driver.taskCity1!='')&&(driver.taskProvince1!='')&&(driver.taskCounty1!=''))>value="${driver.taskProvince1+' '+driver.taskCity1+' '+driver.taskCounty1}"</#if> style="width: 100%">
                <label class="arrow_ico" for="startPlace" style="right: 13px"><i class="fa fa-angle-down"></i></label>
            </div>
            <div class="item">
                <input name="endPlace" id="endPlace" readonly placeholder="请选择专线1终点" <#if (driver.taskCity2??&&driver.taskProvince2??&&driver.taskCounty2??)&&((driver.taskCity2!='')&&(driver.taskProvince2!='')&&(driver.taskCounty2!=''))>value="${driver.taskProvince2+' '+driver.taskCity2+' '+driver.taskCounty2}"</#if> style="width: 100%">
                <label class="arrow_ico" for="endPlace" style="right: 13px"><i class="fa fa-angle-down"></i></label>
            </div>
            <div class="title text-center" style="margin-bottom: 16px">专线2</div>
            <div class="item">
                <input name="startPlace1" id="startPlace1" readonly placeholder="请选择专线2起点" <#if (driver.taskCity3??&&driver.taskProvince3??&&driver.taskCounty3??)&&((driver.taskCity3!='')&&(driver.taskProvince3!='')&&(driver.taskCounty3!=''))>value="${driver.taskProvince3+' '+driver.taskCity3+' '+driver.taskCounty3}"</#if> style="width: 100%">
                <label class="arrow_ico" for="startPlace1" style="right: 13px"><i class="fa fa-angle-down"></i></label>
            </div>
            <div class="item">
                <input name="endPlace1" id="endPlace1" readonly placeholder="请选择专线2终点" <#if (driver.taskCity4??&&driver.taskProvince4??&&driver.taskCounty4??)&&((driver.taskCity4!='')&&(driver.taskProvince4!='')&&(driver.taskCounty4!=''))>value="${driver.taskProvince4+' '+driver.taskCity4+' '+driver.taskCounty4}"</#if> style="width: 100%">
                <label class="arrow_ico" for="endPlace1" style="right: 13px"><i class="fa fa-angle-down"></i></label>
            </div>
            <div class="item_submit" style="margin-top: 16px">
                <a href="javascript:;" class="weui-btn weui-btn_primary resetAddress">确认重设</a>
            </div>
        </form>
    </div>
</section>
<#--城市选择-->
<script src="/lib/wechat/city-picker.js"></script>
<script>
    $(function () {

        $("#startPlace").cityPicker({
            title:"选择专线1的起始地址",
        });
        $("#endPlace").cityPicker({
            title:"选择专线1的终点地址",
        });
        $("#startPlace1").cityPicker({
            title:"选择专线2的起始地址",
        });
        $("#endPlace1").cityPicker({
            title:"选择专线2的终点地址",
        });
        //修改密码
        $(".resetAddress").on('click',function () {
            var flag = $("#address_form").valid();
            if(!flag){
                //没有通过验证
                return;
            }else{
                var data=tools.hashToJson($('#address_form').serialize().substring(0).split("&"));
                var start=data.startPlace.split("+");
                var end=data.endPlace.split("+");
                var start1=data.startPlace1.split("+");
                var end1=data.endPlace1.split("+");
                data.taskProvince1=start[0];
                data.taskCity1=start[1];
                data.taskCounty1=start[2];
                data.taskProvince2=end[0];
                data.taskCity2=end[1];
                data.taskCounty2=end[2];

                data.taskProvince3=start1[0];
                data.taskCity3=start1[1];
                data.taskCounty3=start1[2];
                data.taskProvince4=end1[0];
                data.taskCity4=end1[1];
                data.taskCounty4=end1[2];

                delete data.startPlace;
                delete data.endPlace;
                delete data.startPlace1;
                delete data.endPlace1;
                tools.ajaxPut('/api/driver/updateInfo',data,function (json) {
                    $.toast("修改成功",1000,function () {
                        tools.navigate("/driver/center");
                    });
                })
            }
        })

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
</script>
<#include "/common/footerWechat.ftl"/>
