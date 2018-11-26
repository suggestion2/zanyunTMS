<div class="left_nav">
    <div class="user_header">
        <div class="imgBox">
            <img src="/images/web/header.png">
            <span class="status"><#if driver.status==3>已认证<#elseif driver.status==0>未通过<#else>待审核</#if></span>
        </div>
        <p><#if driver.name??>${driver.name}<#else>${driver.phone}</#if></p>
    </div>
    <ul class="nav_list">
        <li <#if active=='member'>class="active"</#if>><a href="/driver/center"><i></i>会员中心</a></li>
        <li <#if active=='order'>class="active"</#if>><a href="/driver/order/list/3"><i></i>我的订单</a></li>
        <li <#if active=='setting'>class="active"</#if>><a href="/driver/center/setting"><i></i>个人设置</a></li>
        <li><a  onclick="logout()"><i></i>退出登录</a></li>
    </ul>
</div>