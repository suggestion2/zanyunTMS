<#--企业-->
<script type="text/html" class="pageBox" id="tpl_buz">
    <div class="page">
        <div class="step1 step2">
            <div class="stepInfo">
                <ul>
                    <li class="active"></li>
                    <li></li>
                    <li></li>
                </ul>
                <div class="stepIco first active">
                    <p><span>1</span><em style="margin-left: -12px">选择委托人类型</em></p>
                </div>
                <div class="stepIco two active">
                    <p><span>2</span><em style="margin-left: -5px">填写相关信息</em></p>
                </div>
                <div class="stepIco three">
                    <p><span>3</span><em>订车需求</em></p>
                </div>
                <div class="stepIco last">
                    <p><span>4</span><em>完成订车</em></p>
                </div>
            </div>
        </div>
        <div class="panel">
            <div class="panel-body text-center">
                <p class="choose_tip text-center">填写企业信息和企业授权业务联系人信息<br>企业信息将仅用于托运协议的签署，不对第三方公开。为确保托运协议具备法律效力 ，托运业务顺利执行，请如实填写以下信息。</p>
                <form class="form-horizontal order_form" id="buz_form" role="form">
                    <div class="res_title text-center">
                        <h5>企业信息</h5>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 control-label"><b>*</b>企业名称：</label>
                        <div class="col-xs-8">
                            <input class="form-control" name="companyName" type="text" placeholder="请输入企业名称">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 control-label"><b>*</b>社会信用代码：</label>
                        <div class="col-xs-8">
                            <input class="form-control" name="companyLicenseCode" type="text" placeholder="18位社会信用代码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 control-label"><b>*</b>公司地址：</label>
                        <div class="col-xs-8 addressBox" id="companyAddress">
                            <div class="col-xs-4">
                                <select class="form-control" id="companyProvince" name="companyProvince"></select>
                            </div>
                            <div class="col-xs-4">
                                <select class="form-control" id="companyCity" name="companyCity"></select>
                            </div>
                            <div class="col-xs-4">
                                <select class="form-control" id="companyCounty" name="companyCounty"></select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 control-label"><b>*</b>详细地址：</label>
                        <div class="col-xs-8">
                            <input class="form-control" name="companyAddr" type="text" placeholder="详细地址">
                        </div>
                    </div>
                    <div class="res_title text-center">
                        <h5>企业授权业务联系人信息</h5>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 control-label"><b>*</b>本人真实姓名：</label>
                        <div class="col-xs-8">
                            <input class="form-control" name="ownerName" type="text" placeholder="本人真实姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 control-label"><b>*</b>本人电话号码：</label>
                        <div class="col-xs-8">
                            <input class="form-control" id="phone" readonly type="text" placeholder="本人电话号码">
                        </div>
                    </div>
                    <div class="item_submit">
                        <a href="javascript:;" class="btn btn-danger secStepBtn" onclick="buzNext()">继续</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            /*城市选择*/
            $("#companyAddress").distpicker({
                placeholder: false,
                autoSelect: false
            });
            $("#buz_form").validate({
                rules:{
                    companyName:{
                        required:true
                    },
                    companyLicenseCode:{
                        required:true,
                        isLicenseCode:true
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
        });
        /*继续*/
        function buzNext() {
            var flag = $("#buz_form").valid();
            if(!flag){
                //没有通过验证
                return;
            }else{
                var buzData=tools.hashToJson($('#buz_form').serialize().substring(0).split("&"));

                buzData.companyProvince=$("#companyProvince option:selected").text();
                buzData.companyCity=$("#companyCity option:selected").text();
                buzData.companyCounty=$("#companyCounty option:selected").text();
                buzData.ownerType=2;
                delete buzData.address;
                secData=buzData;
                $.cookie('secCookie',JSON.stringify(secData),{expires:7});
                $(".buz").hide();
                tools.navigate("#carDemand");
            }
        }
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
