<div class="left_nav">
    <div class="user_header">
        <div class="imgBox">
            <img src="/images/web/header.png">
            <span class="status">个体货主</span>
        </div>
        <p><#if owner.name??>${owner.name}<#else>${owner.phone}</#if></p>
    </div>
    <ul class="nav_list">
        <li <#if active=='member'>class="active"</#if>><a href="/owner/center"><i></i>会员中心</a></li>
        <li><a href="/order/create"><i></i>创建运单</a></li>
        <li <#if active=='order'>class="active"</#if>><a href="/owner/order/list/10"><i></i>我的订单</a></li>
        <li <#if active=='address'>class="active"</#if>><a href="/address/list"><i></i>地址簿</a></li>
        <li <#if active=='setting'>class="active"</#if>><a href="/owner/center/setting"><i></i>个人设置</a></li>
        <li><a  onclick="logout()"><i></i>退出登录</a></li>
    </ul>
</div>