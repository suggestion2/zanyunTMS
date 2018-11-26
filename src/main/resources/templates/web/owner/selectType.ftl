<script type="text/html" class="pageBox" id="tpl_home">
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
                <div class="stepIco two">
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
            <div class="panel-body">
                <p class="choose_tip text-center">委托人是与平台签订托运协议主体之一。委托人类型决定了合同主体双方的权利和义务。用户在选择委托人类型后，须提供个人或企业真实信息用于签订托运协议。</p>
                <form id="selectType_form" class="order_type row">
                    <div class="col-xs-6 text-right">
                        <label class="item item_type typeOne text-left" for="type-1">
                            <input type="radio" class="visible hide" name="type" id="type-1" value="2">
                            <div class="type text-center"><i></i>作为企业主委托人</div>
                            <div class="type_tip">
                                <p class="tip_p">提供企业信息和企业授权业务联系人信息用于签约：</p>
                                <ul class="tip_l">
                                    <li>1.营业执照名称</li>
                                    <li>2.统一社会信用代码</li>
                                    <li>3.企业办公地址</li>
                                    <li>4.联系人姓名</li>
                                    <li>5.联系人手机号码</li>
                                </ul>
                            </div>
                        </label>
                    </div>
                    <div class="col-xs-6 text-left">
                        <label class="item item_type typeTwo" for="type-2">
                            <input type="radio" class="visible hide" name="type" id="type-2" value="1">
                            <div class="type text-center"><i></i>作为个体户委托人</div>
                            <div class="type_tip">
                                <p class="tip_p">提供企业授权业务联系人信息用于签约：</p>
                                <ul class="tip_l">
                                    <li>1.真实姓名</li>
                                    <li>2.手机号码</li>
                                    <li>3.身份证号码</li>
                                </ul>
                            </div>
                        </label>
                    </div>
                    <div class="col-xs-12 item_submit text-center">
                        <a href="javascript:;" class="btn btn-danger nextBtn" onclick="firstNext()">下一步</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(function () {

            $(".order_type .item_type").on('click',function () {
                $(this).addClass('active');
                $(this).parent('.col-xs-6').siblings().find('.item_type').removeClass('active');
            });
        });
        function firstNext() {
            var data=tools.hashToJson($('#selectType_form').serialize().substring(0).split("&"));
            if(data.type==2){
                $(".home").hide();
                tools.navigate("#buz");
            }else if(data.type==1){
                $(".home").hide();
                tools.navigate("#individual");
            }else{
                tools.msg("请选择订单类型！");
                return false;
            }
        }
    </script>
</script>







