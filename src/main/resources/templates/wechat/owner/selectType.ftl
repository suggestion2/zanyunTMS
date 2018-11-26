
<script type="text/html" class="pageBox" id="tpl_home">
    <div class="page">
        <header class="bar bar-nav">
            <h3 class="title">选择委托人类型</h3>
            <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
                <i class="fa fa-angle-left"></i>
            </a>
            <a href="/owner/center" class="userBtn">
                <i class="fa fa-user-circle-o"></i>
            </a>
        </header>
        <section class="content">
            <div class="content_body resLog_box">
                <h4>第一步 选择委托人类型</h4>
                <p class="reg_tip">委托人是与平台签订托运协议主体之一。委托人类型决定了合同主体双方的权利和义务。用户在选择委托人类型后，须提供个人或企业真实信息用于签订托运协议。</p>
                <form id="selectType_form" class="type_box">
                    <label class="item item_type typeOne" for="type-1">
                        <input type="radio" class="visible hide" name="type" id="type-1" value="2">
                        <div class="type"><i></i>作为企业主委托人</div>
                        <div class="type_tip">
                            <p class="tip_p"><i></i>提供企业信息和企业授权业务联系人信息用于签约：</p>
                            <ul class="tip_l">
                                <li>1.营业执照名称</li>
                                <li>2.统一社会信用代码</li>
                                <li>3.企业办公地址</li>
                                <li>4.联系人姓名</li>
                                <li>5.联系人手机号码</li>
                            </ul>
                        </div>
                    </label>
                    <label class="item item_type typeTwo" for="type-2">
                        <input type="radio" class="visible hide" name="type" id="type-2" value="1">
                        <div class="type"><i></i>作为个体户委托人</div>
                        <div class="type_tip">
                            <p class="tip_p"><i></i>提供企业授权业务联系人信息用于签约：</p>
                            <ul class="tip_l">
                                <li>1.真实姓名</li>
                                <li>2.手机号码</li>
                                <li>3.身份证号码</li>
                            </ul>
                        </div>
                    </label>
                    <div class="item_submit">
                        <a href="javascript:;" class="weui-btn weui-btn_primary firstStepBtn">继续</a>
                    </div>
                </form>
            </div>
        </section>
    </div>
    <script type="text/javascript">
        $(function () {
            $(".item_type").on('click',function () {
                $(this).addClass('active').siblings().removeClass('active');
            });
            $(".firstStepBtn").on('click',function () {
                var data=tools.hashToJson($('#selectType_form').serialize().substring(0).split("&"));
                if(data.type==2){
                    tools.navigate("#buz");
                }else if(data.type==1){
                    tools.navigate("#individual");
                }else{
                    $.toast("请选择订单类型！","text",1000);
                    return false;
                }
            });
        });
    </script>
</script>

