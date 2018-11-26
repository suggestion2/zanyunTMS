<#--个人-->
<script type="text/html" class="pageBox" id="tpl_individual">
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
                <p class="reg_tip">为确保托运协议具备法律效力，托运业务顺利执行，请如实填写以下信息。</p>
                <form id="individual_form" class="reg_form">
                    <div class="res_title text-center">
                        <h5>企业授权业务联系人信息</h5>
                    </div>
                    <div class="row">
                        <div class="item g-col-5">
                            <input name="ownerName" type="text" placeholder="本人真实姓名">
                        </div>
                        <div class="item g-col-7">
                            <input id="phone" type="text" placeholder="本人电话号码" readonly>
                        </div>
                    </div>
                    <div class="item">
                        <input name="ownerIdCardNum" type="text" placeholder="请输入本人身份证号码">
                    </div>
                    <div class="item_submit">
                        <a href="javascript:;" class="weui-btn weui-btn_primary secStepBtn">继续</a>
                    </div>
                </form>
            </div>
        </section>
    </div>
    <script type="text/javascript">
        $(function(){
            $("#individual_form").validate({
                rules:{
                    ownerName:{
                        required:true,
                        isChinese:true
                    },
                    ownerIdCardNum:{
                        required:true,
                        idCard:true
                    }
                },
                messages:{
                    ownerName:{
                        required:'请输入本人姓名',
                        isChinese:'请输入中文名称'
                    },
                    ownerIdCardNum:{
                        required:'请输入身份证号码',
                        idCard:'请输入正确的身份证号码'
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
            //选择继续
            $('.secStepBtn').on('click',function () {
                var flag = $("#individual_form").valid();
                if(!flag){
                    //没有通过验证
                    return;
                }else{
                    var indData=tools.hashToJson($('#individual_form').serialize().substring(0).split("&"));
                    indData.ownerType=1;
                    secData=indData;
                    $.cookie('secCookie',JSON.stringify(secData),{expires:7});
                    tools.navigate("#carDemand");
                }

            });
        });

        /*验证中文字符*/
        jQuery.validator.addMethod("isChinese", function(value, element) {
            return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);
        }, "只能包含中文字符");
        // 身份证号码验证
        jQuery.validator.addMethod("idCard", function(value, element) {
            return this.optional(element) || /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/.test(value);
        }, "请输入正确的身份证号码。");
    </script>
</script>