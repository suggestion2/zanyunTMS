<#include "/common/headerWechat.ftl"/>
<header class="bar bar-nav">
    <h3 class="title">公告详情</h3>
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
            <div class="weui-panel__bd">
                <article class="weui-article">
                    <div class="article_h text-center">
                        <h1>${noticesView.title}</h1>
                        <span class="article_time">发布时间：${noticesView.createTime?string("yyyy-MM-dd")}</span>
                    </div>
                    <section class="article_b">
                        ${noticesView.content}
                    </section>
                </article>
            </div>
        </div>
    </div>
</section>
<#include "/common/footerWechat.ftl"/>

