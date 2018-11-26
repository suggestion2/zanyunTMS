<#include "/common/headerWechat.ftl"/>

<header class="bar bar-nav">
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <h3 class="title">司机个人中心</h3>
    <a href="/driver/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body centerBox">
        <div class="weui-cells">
            <div class="weui-cell center_h">
                <div class="weui-cell__bd">
                    <#if driver.name??>
                        <h5>${driver.name}</h5>
                    <#else>
                        <h5>${driver.phone}</h5>
                    </#if>
                    <#if driver.status==3>
                        <p>认证已通过</p>
                    <#elseif driver.status==0>
                        <p>认证未通过，请<a href="/driver/completeInfo">重新填写认证信息</a></p>
                    <#else>
                        <p>认证申请已提交，待审核</p>
                    </#if>
                </div>
                <div class="weui-cell__ft">
                    <div class="h_img">
                        <img src="${driver.wechatHeadImg!"/images/wechat/header.png"}">
                    </div>
                </div>
            </div>
            <#if driver.status == 3>
            <div class="weui-cell" onclick="openList(3)">
                <div class="weui-cell__bd">待运输</div>
                <div class="weui-cell__ft">${count.accept}</div>
            </div>
            <div class="weui-cell" onclick="openList(2)">
                <div class="weui-cell__bd">待支付</div>
                <div class="weui-cell__ft">${count.unpaid}</div>
            </div>
            <div class="weui-cell" onclick="openList(4)">
                <div class="weui-cell__bd">运输中</div>
                <div class="weui-cell__ft">${count.transport}</div>
            </div>
            <div class="weui-cell" onclick="openList(-1)">
                <div class="weui-cell__bd">已取消</div>
                <div class="weui-cell__ft">${count.cancel}</div>
            </div>
            <div class="weui-cell" onclick="openList(5)">
                <div class="weui-cell__bd">已完成</div>
                <div class="weui-cell__ft">${count.complete}</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd"><a href="/driver/resetAddress">修改专线信息</a></div>
            </div>
            </#if>
            <div class="weui-cell">
                <div class="weui-cell__bd"><a href="/driver/resetPassword">重设密码</a></div>
            </div>
        </div>
        <div class="relation text-center">
            <a href="tel:05394395888">联系客服</a>
        </div>
    </div>
</section>
<script>
    function openList(status) {
        tools.navigate('/driver/order/list/'+status);
    }
</script>
<#include "/common/footerWechat.ftl"/>

