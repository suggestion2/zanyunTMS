<#include "/common/headerWechat.ftl"/>
<header class="bar bar-nav">
    <h3 class="title">新闻中心</h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/owner/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body news_body">
        <div class="weui-panel weui-panel_access">
            <div class="weui-tab">
                <div class="weui-navbar">
                    <a class="weui-navbar__item <#if active=='news'>weui-bar__item--on</#if>" onclick="openList('news')">行业新闻</a>
                    <a class="weui-navbar__item <#if active=='notices'>weui-bar__item--on</#if>" onclick="openList('notices')">公司公告</a>
                </div>
                <div class="weui-tab__bd">
                    <div id="news" class="weui-tab__bd-item <#if active=='news'>weui-tab__bd-item--active</#if>">
                        <div class="weui-panel__hd">赵霞最新资讯</div>
                        <div class="weui-panel__bd">
                            <#if active=='news'>
                                <#if newsView.list??&&(newsView.list?size>0)>
                                    <input value="${newsView.count}" class="count hide">
                                    <#list newsView.list as item>
                                        <a  class="weui-media-box weui-media-box_appmsg" onclick="openNews(${item.id})">
                                            <div class="weui-media-box__hd">
                                                <img class="weui-media-box__thumb" src="${item.coverImageUrl?default('/images/web/no_img.png')}" alt="">
                                            </div>
                                            <div class="weui-media-box__bd">
                                                <h4 class="weui-media-box__title">${item.title}</h4>
                                                <p class="weui-media-box__desc">${item.summary}</p>
                                                <p class="weui-media-box__time">${item.createTime?string("yyyy-MM-dd")}</p>
                                            </div>
                                        </a>
                                    </#list>
                                <#else>
                                    <div class="no_data text-center">
                                        <img src="/images/wechat/no_order.png">
                                        <div>
                                            <p class="tip">暂无新闻！</p>
                                        </div>
                                    </div>
                                </#if>
                            </#if>
                        </div>
                    </div>
                    <div id="notices" class="weui-tab__bd-item <#if active=='notices'>weui-tab__bd-item--active</#if>">
                        <div class="weui-panel__hd">公司公告</div>
                        <div class="weui-panel__bd">
                            <#if active=='notices'>
                                <#if noticesView.list??&&(noticesView.list?size>0)>
                                    <input value="${noticesView.count}" class="noticeCount hide">
                                    <#list noticesView.list as item>
                                        <a  class="weui-media-box weui-media-box_appmsg" onclick="openNotices(${item.id})">
                                            <div class="weui-media-box__bd">
                                                <h4 class="weui-media-box__title">${item.title}</h4>
                                                <p class="weui-media-box__time">${item.createTime?string("yyyy-MM-dd")}</p>
                                            </div>
                                        </a>
                                    </#list>
                                <#else>
                                    <div class="no_data text-center">
                                        <img src="/images/wechat/no_order.png">
                                        <div>
                                            <p class="tip">暂无公告！</p>
                                        </div>
                                    </div>
                                </#if>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    function openList(status) {
        tools.navigate('/'+status+'/list');
    }
    function openNews(index) {
        tools.navigate('/news/detail/'+index);
    }
    function openNotices(index){
        tools.navigate('/notices/detail/'+index);
    }
</script>
<#include "/common/footerWechat.ftl"/>

