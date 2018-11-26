<#include "/common/headerWeb.ftl"/>
<#include "/common/navWeb.ftl"/>
<section class="main_section">
    <input value="${active}" class="hide type">
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
                        <li <#if active=='news'>class="active"</#if>><a onclick="openList('news')">行业新闻</a></li>
                        <li <#if active=='notices'>class="active"</#if>><a onclick="openList('notices')">公司公告</a></li>
                    </ul>
                </div>
                <div class="col-sm-9">
                    <div class="tab-content">
                    <#if active=='news'>

                            <#if newsView.list??&&(newsView.list?size>0)>
                            <ul class="newsList">
                                <input value="${newsView.count}" class="count hide">
                                <#list newsView.list as item>
                                    <li class="clearfix">
                                        <div class=" col-xs-3"><img src="${item.coverImageUrl?default('/images/web/no_img.png')}" class="news_img">
                                        </div>
                                        <div class=" col-xs-9">
                                            <div class="news_body">
                                                <h4 onclick="openNews(${item.id})">${item.title}</h4>
                                                <p onclick="openNews(${item.id})">${item.summary}</p>
                                            </div>
                                            <div class="news_footer">
                                                <span>发布时间：${item.createTime?string("yyyy-MM-dd")}</span>
                                            </div>
                                        </div>
                                    </li>
                                </#list>
                            </ul>
                            <#else>
                                <div class="clearfix data_none text-center">
                                    <img src="/images/web/no_listData.png">
                                    <p>暂无数据</p>
                                </div>
                            </#if>
                        <nav class="text-center">
                            <ul id="example" ></ul>
                        </nav>
                    <#elseif active=='notices'>
                        <#if noticesView.list??&&(noticesView.list?size>0)>
                            <input value="${noticesView.count}" class="noticeCount hide">
                            <ul class="noticeList">
                                <#list noticesView.list as item>
                                    <li><i></i><a onclick="openNotices(${item.id})">${item.title}</a><span>${item.createTime?string("yyyy-MM-dd")}</span></li>
                                </#list>
                            </ul>
                        <#else>
                            <div class="clearfix data_none text-center">
                                <img src="/images/web/no_listData.png">
                                <p>暂无数据</p>
                            </div>
                        </#if>
                        <nav class="text-center">
                            <ul id="noticeExample" ></ul>
                        </nav>
                    </#if>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </section>
</section>

<script src="/lib/bootstrapPaginator/bootstrap-paginator.min.js"></script>
<script>
    var type=$(".type").val();
    $(function () {
        if(type=='news'){
            /*新闻列表*/
            var count=$(".count").val();
            var totalPages=Math.ceil(count/10);
            if(totalPages==0){
                $('.newsList').next('nav').hide();
            }else{
                page(totalPages);
            }
        }else if (type=='notice'){
            /*公告列表*/
            var noticeCount=$(".noticeCount").val();
            var totalPages=Math.ceil(noticeCount/10);
            if(totalPages==0){
                $('.noticeList').next('nav').hide();
            }else{
                page(totalPages);
            }
        }
    });
    function page(total) {
        var options = {
            bootstrapMajorVersion:3,
            currentPage: 1,//当前页
            totalPages: total,//总页数
            numberOfPages: 5,//显示的页数
            shouldShowPage:function(type, page, current){
                switch(type)
                {
                    default:
                        return true;
                }
            },
            tooltipTitles: function (type, page, current) {
                switch (type) {
                    case "first":
                        return "首页";
                    case "prev":
                        return "上一页";
                    case "next":
                        return "下一页";
                    case "last":
                        return "尾页";
                    case "page":
                        return "第"+page+"页";
                }
            },
            itemTexts: function(type, page, current) { //修改显示文字
                switch (type) {
                    case "first":
                        return "首页";
                    case "prev":
                        return "上一页";
                    case "next":
                        return "下一页";
                    case "last":
                        return "末页";
                    case "page":
                        return page;
                }
            },
            onPageClicked: function (event, originalEvent, type, page) { //异步换页
                if(type=='news'){
                    tools.ajaxPost('/api/article/list',{"pageIndex":page-1,"pageSize":"20"},function (json) {
                        var str='';
                        $.each(json.list,function (idx,val) {
                            str+='<li class="clearfix">' +
                                    '<div class="col-xs-4">' +
                                    '<img src="'+val.coverImageUrl+'" class="news_img">' +
                                    '</div>' +
                                    '<div class="col-xs-8">' +
                                    '<div class="news_body">' +
                                    '<h4 onclick="openNews('+val.id+')">'+val.title+'</h4>' +
                                    '<p onclick="openNews('+val.id+')">'+val.summary+'</p>' +
                                    '</div>' +
                                    '<div class="news_footer">' +
                                    '<span>发布时间：'+val.createTime+'</span>' +
                                    '</div>' +
                                    '</div>' +
                                    '</li>'

                        });
                        $('.newsList').html(str);
                    })
                }else if(type=='notice'){
                    tools.ajaxPost('/api/notice/list',{"pageIndex":page-1,"pageSize":"20"},function (json) {
                        var str='';
                        $.each(json.list,function (idx,val) {
                            str+='<li class="row">'+
                                    '<div class="pull-left">'+
                                    '<div class="news_body">'+
                                    '<h4 onclick="openNotices('+val.id+')">'+val.title+'</h4>'+
                                    '<p onclick="openNotices('+val.id+')">'+val.content+'</p>'+
                                    '</div>'+
                                    '<div class="news_footer">'+
                                    '<span>发布时间：'+val.createTime+'</span>'+
                                    '</div>'+
                                    '</div>'+
                                '</li>'

                        });
                        $('.noticeList').html(str);
                    })
                }

            }
        };
        if(type=='news'){
            $("#example").bootstrapPaginator(options);
        }else if(type=='notice'){
            $("#noticeExample").bootstrapPaginator(options);
        }
    }
    function openList(type) {
        tools.navigate('/'+type+'/list');
    }
    function openNews(index) {
        tools.navigate('/news/detail/'+index);
    }
    function openNotices(index) {
        tools.navigate('/notices/detail/'+index);
    }
</script>
<#include "/common/footerWeb.ftl"/>

