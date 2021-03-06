<#include "/common/headerWeb.ftl"/>
<#include "/common/navWeb.ftl"/>
<section class="main_section">
    <section class="hero-unit-slider no-margin">
        <div id="carousel-hero" class="slick-carousel">
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <img src="/images/web/news.jpg" alt="Slider Image" width="100%">
                </div>
            </div>
        </div>
    </section>
    <section class="contact_section center_section news_section">
        <div class="container">
            <div class="row">
                <div class="col-sm-3">
                    <ul class="nav news_nav text-center">
                        <li><a onclick="openList('news')">行业新闻</a></li>
                        <li class="active"><a onclick="openList('notices')">公司公告</a></li>
                    </ul>
                </div>
                <div class="col-sm-9">
                    <div class="tab-content">
                        <div class="blog single full-t  humbnail">
                            <!-- blog post -->
                            <article class="entry-post">
                                <header class="entry-header  text-center">
                                    <h2 class="entry-title">
                                        <a>${noticesView.title}</a>
                                    </h2>
                                    <span>发布时间：${noticesView.createTime?string("yyyy-MM-dd")}</span>
                                </header>
                                <div class="entry-content clearfix">
                                    <div class="excerpt">
                                    ${noticesView.content}
                                    </div>
                                </div>
                            </article>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </section>
</section>
<script>
    function openList(type) {
        tools.navigate('/'+type+'/list');
    }
</script>
<#include "/common/footerWeb.ftl"/>

