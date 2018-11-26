<#--个人-->
<script type="text/html" class="pageBox" id="tpl_individual">
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
                    <p><span>4</span><em>完成订车</em>
                    </p>
                </div>
            </div>
        </div>
        <div class="panel">
            <div class="panel-body text-center">
                <p class="choose_tip text-center">填写企业授权业务联系人信息<br>为确保托运协议具备法律效力，托运业务顺利执行，请如实填写以下信息。</p>
                <form class="form-horizontal order_form" id="individual_form"  role="form">
                    <div class="res_title text-center">
                        <h5>企业授权业务联系人信息</h5>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 control-label"><b>*</b>本人真实姓名：</label>
                        <div class="col-xs-8">
                            <input class="form-control" name="ownerName" type="text" placeholder="姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 control-label"><b>*</b>本人电话号码：</label>
                        <div class="col-xs-8">
                            <input class="form-control" id="phone" readonly type="text" placeholder="电话">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-4 control-label"><b>*</b>本人身份证号码：</label>
                        <div class="col-xs-8">
                            <input class="form-control" name="ownerIdCardNum" type="text" placeholder="身份证">
                        </div>
                    </div>
                    <div class="item_submit">
                        <a href="javascript:;" class="btn btn-danger secStepBtn" onclick="indiNext()">继续</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
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
        });
        function indiNext() {
            var flag = $("#individual_form").valid();
            if(!flag){
                //没有通过验证
                return;
            }else{
                var indData=tools.hashToJson($('#individual_form').serialize().substring(0).split("&"));
                indData.ownerType=1;
                secData=indData;
                $.cookie('secCookie',JSON.stringify(secData),{expires:7});
                $(".individual").hide();
                tools.navigate("#carDemand");
            }
        }

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