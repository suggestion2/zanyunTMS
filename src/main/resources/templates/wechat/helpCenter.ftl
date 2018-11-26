<#include "/common/headerWechat.ftl"/>
<header class="bar bar-nav">
    <h3 class="title">帮助中心</h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/owner/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body news_body">
        <div class="weui-panel weui-panel_access ">
            <div class="weui-panel__hd kefu">
                <div class="weui-media-box weui-media-box_appmsg">
                    <div class="weui-media-box__hd">
                        <img class="weui-media-box__thumb" src="/images/wechat/kefu.png" alt="">
                    </div>
                    <div class="weui-media-box__bd">
                        <div class="kefu_text"><p>您好，我是赵霞物流的客服，竭诚为您服务！</div>
                    </div>
                </div>
            </div>
            <div class="weui-panel__hd problem_t">常见问题</div>
            <div class="weui-panel__bd problem_b">
                <div class="item_problem">
                    <a class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="/images/wechat/problem_ico.png" alt="" style="width:16px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd weui-cell_primary">
                            <p>如果司机对运费有疑虑，怎么办？</p>
                        </div>
                        <span class="weui-cell__ft"></span>
                    </a>
                    <p class="ans">赵霞智慧物流平台为货少的货主提供拼车服务，专车的速度，零担的价格，省心省时省钱！</p>
                </div>
                <div class="item_problem">
                    <a class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="/images/wechat/problem_ico.png" alt="" style="width:16px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd weui-cell_primary">
                            <p>为什么要认证车辆？认证车辆有什么好处？</p>
                        </div>
                        <span class="weui-cell__ft"></span>
                    </a>
                    <p class="ans">完成车辆认证，货主就能在给您下单前，通过查看您车辆照片判断您的车型、车长是否符合他的运输需求，免得您接了单，但是您的车又不符合他的运输需求而白跑一趟。</p>
                </div>
                <div class="item_problem">
                    <a class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="/images/wechat/problem_ico.png" alt="" style="width:16px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd weui-cell_primary">
                            <p>为什么我认证车辆，总是不通过？</p>
                        </div>
                        <span class="weui-cell__ft"></span>
                    </a>
                    <p class="ans">请严格按照示例图要求拍摄照片并上传。如遇其他问题请及时致电0539-4395888联系赵霞智慧物流平台客服。</p>
                </div>
                <div class="item_problem">
                    <a class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="/images/wechat/problem_ico.png" alt="" style="width:16px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd weui-cell_primary">
                            <p>接单后如何联系货主？</p>
                        </div>
                        <span class="weui-cell__ft"></span>
                    </a>
                    <p class="ans">在支付完信息费后，可查看货源全部详情，如有疑问可致电客服帮助联系货主。</p>
                </div>
                <div class="item_problem">
                    <a class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="/images/wechat/problem_ico.png" alt="" style="width:16px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd weui-cell_primary">
                            <p>微信公众号上抢单和电脑上是一样的吗？</p>
                        </div>
                        <span class="weui-cell__ft"></span>
                    </a>
                    <p class="ans">微信公众号上所呈现的数据是和平台同步的。</p>
                </div>
                <div class="item_problem">
                    <a class="weui-cell weui-cell_access" href="javascript:;">
                        <div class="weui-cell__hd"><img src="/images/wechat/problem_ico.png" alt="" style="width:16px;margin-right:5px;display:block"></div>
                        <div class="weui-cell__bd weui-cell_primary">
                            <p>专线和货源大厅运单有什么区别？</p>
                        </div>
                        <span class="weui-cell__ft"></span>
                    </a>
                    <p class="ans">专线：物流定时发车，时间统一。您如果选择专线，可联系客服获取联系方式。货源大厅：由赵霞物流注册司机选择接单。</p>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    $(function () {
        $(".item_problem .weui-cell").on('click',function () {
            $(this).parent().siblings().removeClass('current');
            $(this).parent().siblings().find('.ans').slideUp(200);
            $(this).parent().toggleClass('current');
            $(this).next('.ans').slideToggle(200);
        })
    })
</script>
<#include "/common/footerWechat.ftl"/>

