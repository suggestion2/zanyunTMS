<#--企业-->
<script type="text/html" class="pageBox" id="tpl_buz">
    <div class="page">
        <header class="bar bar-nav">
            <h3 class="title">填写相关信息</h3>
            <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
                <i class="fa fa-angle-left"></i>
            </a>
            <a href="/owner/center" class="userBtn">
                <i class="fa fa-user-circle-o"></i>
            </a>
        </header>
        <section class="content">
            <div class="content_body resLog_box">
                <h4>第二步 填写企业信息和企业授权业务联系人信息</h4>
                <p class="reg_tip">企业信息将仅用于托运协议的签署，不对第三方公开。为确保托运协议具备法律效力 ，托运业务顺利执行，请如实填写以下信息。</p>
                <form id="buz_form" class="reg_form">
                    <div class="res_title text-center">
                        <h5>企业信息</h5>
                    </div>
                    <div class="item">
                        <input name="companyName" type="text" placeholder="请输入企业名称">
                    </div>
                    <div class="item">
                        <input name="companyLicenseCode" type="text" placeholder="请输入18位统一社会信用代码">
                    </div>
                    <div class="item">
                        <input type="text" name="address" placeholder="请选择省/市/区" id="address" readonly class="picker">
                        <label class="arrow_ico" for="address" style="right: 12px"><i class="fa fa-angle-down"></i></label>
                    </div>
                    <div class="item">
                        <input type="text" name="companyAddr" placeholder="请输入详细地址">
                    </div>
                    <div class="res_title text-center">
                        <h5>企业授权业务联系人信息</h5>
                    </div>
                    <div class="row">
                        <div class="item g-col-5">
                            <input name="ownerName" type="text" placeholder="本人真实姓名">
                        </div>
                        <div class="item g-col-7">
                            <input id="phone" type="text" readonly placeholder="本人电话号码">
                        </div>
                    </div>
                    <div class="item_submit">
                        <a href="javascript:;" class="weui-btn weui-btn_primary secStepBtn">继续</a>
                    </div>
                </form>
            </div>
        </section>
    </div>
    <script type="text/javascript">
        $(function () {
            $("#buz_form").validate({
                rules:{
                    companyName:{
                        required:true
                    },
                    companyLicenseCode:{
                        required:true,
                        isLicenseCode:true
                    },
                    address:{
                        required:true
                    },
                    companyAddr:{
                        required:true
                    },
                    ownerName:{
                        required:true,
                        isChinese:true
                    }
                },
                messages:{
                    companyName:{
                        required:'请填写公司名称'
                    },
                    companyLicenseCode:{
                        required:'请输入统一社会信用代码',
                        isLicenseCode:'请输入正确的社会信用代码'
                    },
                    address:{
                        required:'请选择公司地址'
                    },
                    companyAddr:{
                        required:'请填写公司详细地址'
                    },
                    ownerName:{
                        required:'请填写本人姓名',
                        isChinese:'请输入中文名称'
                    }
                }
            });
            //获取登录的电话号码
            tools.ajax({
                type: "GET",
                url: '/api/owner/current',
                contentType: APPLICATION_JSON,
                success:function (json) {
                    $("#phone").val(json.phone);
                }
            });
            //选择省市
            var province='',city='',county='';
            $("#address").cityPicker({
                title:"选择企业地址",
                onChange:function (p,v,d) {
                    province=d[0];
                    city=d[1];
                    county=d[2];
                    $("#address-error").hide();
                }
            });
            //选择继续
            $('.secStepBtn').on('click',function () {
                var flag = $("#buz_form").valid();
                if(!flag){
                    //没有通过验证
                    return;
                }else{
                    var buzData=tools.hashToJson($('#buz_form').serialize().substring(0).split("&"));
                    buzData.companyProvince=province;
                    buzData.companyCity=city;
                    buzData.companyCounty=county;
                    buzData.ownerType=2;
                    delete buzData.address;
                    secData=buzData;
                    $.cookie('secCookie',JSON.stringify(secData),{expires:7});
                    tools.navigate("#carDemand");
                }

            });
        });

        jQuery.validator.addMethod("isLicenseCode", function(value, element) {
            var length = value.length;
            var licenseCode =/[0-9A-HJ-NPQRTUWXY]{2}\d{6}[0-9A-HJ-NPQRTUWXY]{10}/;
            return this.optional(element) || (length == 18 && licenseCode.test(value));
        }, "请正确填写18位社会信用代码");
        /*验证中文字符*/
        jQuery.validator.addMethod("isChinese", function(value, element) {
            return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);
        }, "只能包含中文字符");
    </script>
</script>
