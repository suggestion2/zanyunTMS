<script type="text/html" class="pageBox" id="tpl_carSuc">
    <div class="page">
        <div class="step1 step2">
            <div class="stepInfo">
                <ul>
                    <li class="active"></li>
                    <li class="active"></li>
                    <li class="active"></li>
                </ul>
                <div class="stepIco first active">
                    <p><span>1</span><em style="margin-left: -12px">选择委托人类型</em></p>
                </div>
                <div class="stepIco two active">
                    <p><span>2</span><em style="margin-left: -5px">填写相关信息</em></p>
                </div>
                <div class="stepIco three active">
                    <p><span>3</span><em>订车需求</em></p>
                </div>
                <div class="stepIco last active">
                    <p><span>4</span><em>完成订车</em>
                    </p>
                </div>
            </div>
        </div>
        <div class="panel">
            <div class="panel-body">
                <div class="sucBox text-center">
                    <img src="/images/web/orderSuc.png">
                    <p>您的订车需求已经创建成功了！请等待后台客服审核通过！</p>
                    <a href="javascript:;" class="btn btn-danger viewOrder">查看订单详情</a>
                    <a href="javascript:;" class="btn btn-danger relation">联系客服</a>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            /*判断是否页面刷新或者直接跳转进来的*/
            if(orderId==null){
                //刷新了,读取上一页存储的cookie
                if($.cookie('orderIdCookie')==null){
                    tools.msg('订单id丢失,请去列表中查看',function () {
                    });
                }else{
                    orderId=$.cookie('orderIdCookie');
                    console.log(orderId);
                }
            }
            $(".viewOrder").on("click",function () {
                tools.navigate("/owner/order/detail/"+orderId);
            });
            /*联系客服*/
            $(".relation").on("click",function () {
                if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){
                    tools.confirm('联系客服：05394395888',function () {
                        location.href('tel:05394395888');
                    });
                }else{
                    tools.confirm('联系客服：05394395888');
                }
            })
        });
    </script>
</script>
