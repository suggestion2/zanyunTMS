<#include "/common/headerWechat.ftl"/>
<header class="bar bar-nav">
    <h3 class="title">新闻详情</h3>
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
                        <h1>${newsView.title}</h1>
                        <span class="article_time">发布时间：${newsView.createTime?string("yyyy-MM-dd")} 阅读人数：${newsView.readCount+'人'}</span>
                    </div>
                    <section class="article_b">
                        ${newsView.content}
                    </section>
                </article>
            </div>
        </div>
    </div>
</section>
<#include "/common/footerWechat.ftl"/>

