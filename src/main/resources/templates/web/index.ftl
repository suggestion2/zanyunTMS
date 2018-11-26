<#include "/common/headerWeb.ftl"/>
<#include "/common/navWeb.ftl"/>
<section class="main_section">
    <section class="hero-unit-slider paddingT90">
        <div id="carousel-hero" class="slick-carousel">
            <div class="carousel-inner" role="listbox">
            <#if bannerList??>
                <#list bannerList as item>
                    <div class="">
                        <a href="${item.linkUrl?default('/login')}">
                            <img src="${item.bannerUrl?default('/images/web/sliders/banner_'+(item_index+1)+'.jpg')}" class="img-responsive" alt="Slider Image">
                        </a>
                    </div>
                </#list>
            </#if>
            </div>
        </div>
    </section>
<#--特色服务-->
    <section class="service_section">
        <div class="container">
            <div class="clearfix">
                <div class="service_item col-sm-3 col-xs-6">
                    <img src="/images/web/service-icon-1.png">
                    <h4>轻松发货</h4>
                    <span>注册货主一键发布最新货源</span>
                </div>
                <div class="service_item col-sm-3 col-xs-6">
                    <img src="/images/web/service-icon-2.png">
                    <h4>在线接单</h4>
                    <span>可在线查看平台最新车源与货源</span>
                </div>
                <div class="service_item col-sm-3 col-xs-6">
                    <img src="/images/web/service-icon-3.png">
                    <h4>安全可靠</h4>
                    <span>司机货主严格把关，真实有效</span>
                </div>
                <div class="service_item col-sm-3 col-xs-6">
                    <img src="/images/web/service-icon-4.png">
                    <h4>操作便捷</h4>
                    <span>无论公众号与pc端都有抢单功能</span>
                </div>
            </div>
        </div>
    </section>
    <section class="source_section">
        <div class="container">
        <#--货源-->
            <h1 class="section_title">货源信息<br><small>Source Information</small></h1>
            <div class="row">
                <div class="col-sm-8">
                    <div class="notice_box">
                        <div class="notice_header clearfix">
                            <a class="notice_title pull-left">最新货源</a>
                            <a class="more pull-right" href="/order/list">查看更多</a>
                        </div>
                        <div class="notice_body">
                            <div class="goodsMessage">
                                <table class="table-fixed table-source goods-table">
                                    <thead>
                                    <tr>
                                        <th width="200px">发货地</th>
                                        <th width="200px"> </th>
                                        <th width="200px">卸货地</th>
                                        <th width="200px">运价</th>
                                        <th width="200px">时间</th>
                                        <th width="200px">详情</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-sm-4">
                    <div class="notice_box">
                        <div class="notice_header clearfix">
                            <a class="notice_title pull-left">公告</a>
                            <a class="more pull-right" href="/notices/list">查看更多</a>
                        </div>
                        <div class="notice_body sou_notice">
                            <#if noticesView.list??&&(noticesView.list?size>0)>
                                <input value="${noticesView.count}" class="NoticeCount hide">
                                <ul class="notice_list">
                                    <#list noticesView.list as item>
                                        <li>
                                            <i></i>
                                            <a href="javascript:;" onclick="openNotice(${item.id})">${item.title}</a>
                                            <span>${item.createTime?string("yyyy-MM-dd")}</span>
                                        </li>
                                    </#list>
                                </ul>
                            <#else>
                                <div class="no_data" style="padding-top: 120px;">
                                    <span href="javascript:;" class="text-center">暂无公告</span>
                                </div>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        <#--车源-->
            <h1 class="section_title">车源信息<br><small>Cars  Information</small></h1>
            <div class="row">
                <div class="col-sm-8">
                    <div class="notice_box">
                        <div class="notice_header clearfix">
                            <a class="notice_title pull-left">最新车源</a>
                            <a class="more pull-right" href="/cars/list">查看更多</a>
                        </div>
                        <div class="notice_body">
                            <div class="goodsMessage">
                                <table class="table-fixed table-source cars-table">
                                    <thead>
                                    <tr>
                                        <th width="200px">司机姓名</th>
                                        <th width="200px">车型</th>
                                        <th width="200px">司机姓名</th>
                                        <th width="200px">所在地址</th>
                                        <th width="200px">驾龄</th>
                                        <th width="200px">详情</th>
                                    </tr>
                                    </thead>
                                    <tbody></tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="notice_box">
                        <div class="notice_header clearfix">
                            <a class="notice_title pull-left">专线信息</a>
                            <a class="more pull-right" href="javascript:;"  data-toggle="modal" data-target="#line_modal">联系专线客服</a>
                        </div>
                        <div class="notice_body line_notice">
                            <ul class="line_list">
                                <li>
                                    <div class="item_line clearfix" onclick="openLine(0)">
                                        <div class="imgBox">
                                            <img src="/images/web/cars/car.jpg">
                                        </div>
                                        <div class="line_info">
                                            <p><label>发货地：</label><a>平邑县地方镇（赵霞物流）</a></p>
                                            <p><label>卸货地：</label><a>临沂金兰物流园F1区113号</a></p>
                                            <p><label>车型：</label>厢式货车</p>
                                        </div>
                                        <label class="tag">
                                            <span>每日发车</span>
                                        </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="item_line clearfix" onclick="openLine(1)">
                                        <div class="imgBox">
                                            <img src="/images/web/cars/car2.jpg">
                                        </div>
                                        <div class="line_info">
                                            <p><label>发货地：</label><a>平邑县地方镇（赵霞物流）</a></p>
                                            <p><label>卸货地：</label><a>东北专线（沈阳、长春、哈尔滨）</a></p>
                                            <p><label>车型：</label>半挂</p>
                                        </div>
                                        <label class="tag">
                                            <span>每日发车</span>
                                        </label>
                                    </div>
                                </li>
                                <li>
                                    <div class="item_line clearfix" onclick="openLine(2)">
                                        <div class="imgBox">
                                            <img src="/images/web/cars/car2.jpg">
                                        </div>
                                        <div class="line_info">
                                            <p><label>发货地：</label><a>平邑县朝霞国际保税物流园</a></p>
                                            <p><label>卸货地：</label><a>青岛、日照、连云港集装箱专线</a></p>
                                            <p><label>车型：</label>半挂</p>
                                        </div>
                                        <label class="tag">
                                            <span>每日发车</span>
                                        </label>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="company_new">
        <div class="container">
            <div class="row">
                <h1 class="section_title">公司新闻<br><small>Company News</small></h1>
                <div class="col-sm-6">
                    <div class="notice_box">
                        <div class="notice_header clearfix">
                            <a class="notice_title pull-left">视频中心</a>
                        <#--<a class="more pull-right" href="javascript:;">更多视频</a>-->
                        </div>
                        <div class="notice_body">
                            <video width="100%" height="100%" controls style="background: #fff" poster="/images/web/video_img.jpg">
                                <source src="http://img.zxotms.com/web/zxvideo.mp4" type="video/mp4">
                                <object data="movie.mp4" width="100%" height="100%">
                                    <embed src="http://img.zxotms.com/web/zxvideo.mp4" width="320" height="240">
                                </object>
                            </video>
                        <#--<embed src="http://video.renmings.com/611d3b09a11f4179be155f63d37f523a/cec52c522c2f4837801c8abf15552f9a-5287d2089db37e62345123a1be272f8b.mp4" width="100%" height="100%" type=""> </embed>-->
                        </div>
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="notice_box">
                        <div class="notice_header clearfix">
                            <a class="notice_title pull-left">新闻中心</a>
                            <a class="more pull-right" href="/news/list">更多新闻</a>
                        </div>
                        <div class="notice_body news_notice">
                            <#if newsView.list??&&(newsView.list?size>0)>
                                <input value="${newsView.count}" class="newsView hide">
                                <ul class="news_list">
                                    <#list newsView.list as item>
                                        <li class="clearfix">
                                            <div class="col-xs-3">
                                                <img src="${item.coverImageUrl}" class="news_img">
                                            </div>
                                            <div class="col-xs-9">
                                                <div class="news_body">
                                                    <h4>${item.title}</h4>
                                                    <p>${item.summary}</p>
                                                </div>
                                                <div class="news_footer clearfix">
                                                    <span class="pull-left">发布时间：${item.createTime?string("yyyy-MM-dd")}</span>
                                                    <a href="javascript:;" class="pull-right" onclick="openNews(${item.id})">>>查看详情</a>
                                                </div>
                                            </div>
                                        </li>
                                    </#list>
                                </ul>
                            <#else>
                                <div class="no_data" style="padding-top: 120px">
                                    <span href="javascript:;" class="text-center">暂无新闻</span>
                                </div>
                            </#if>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</section>
<#--公众号引导-->
<div class="we-model">
    <div class="modal-table">
        <div class="model-table-call">
            <div class="att-guide">
                <span class="model-table-close clickNewReg">&times;</span>
                <div class="weCode clearfix">
                    <img src="/images/web/truck.png">
                </div>
            </div>
        </div>
    </div>
</div>
<#--专线联系客服-->
<div class="modal fade" id="line_modal" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title">联系专线客服</h4>
            </div>
            <div class="modal-body">
                <div class="promise">
                    <div class="promise_title text-center">
                        <h4>专线物流承诺</h4>
                    </div>
                    <div class="promise_body text-center">
                        <img src="/images/web/line_car.png">
                        <p>平台承诺，专线物流价格全网最低。</p>
                        <p>查看专线列表信息后，记住该条专线！</p>
                        <a onclick="call()">联系客服，获取报价。</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<#--专线详情-->
<div class="modal fade" id="line_detail" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title">专线详情</h4>
            </div>
            <div class="modal-body lineInfo">
                <div class="item text-center">
                    <img src="" class="carImg" width="80%">
                </div>

                <div class="item arr_item ">
                    <h5>发货地信息</h5>
                    <p class="add clearfix"><label>地址：</label><a></a></p>
                    <p class="num clearfix"><label>联系方式：</label><a></a></p>
                </div>
                <div class="item dis_item ">
                    <h5>收货地信息</h5>
                    <p class="add clearfix"><label>地址：</label><a></a></p>
                    <p class="num clearfix"><label>联系方式：</label><a></a></p>
                </div>
                <div class="item other_item ">
                    <h5>其他信息</h5>
                    <p class="type clearfix"><label>车型：</label><span></span></p>
                    <p class="date clearfix"><label>发车周期：</label><span></span></p>
                </div>
            </div>
        </div>
    </div>
</div>
<#--广告位-->
<#if advertisementList??>
    <#list advertisementList as item>
        <div id="${'advert'+item_index}" class="advert" style="position: absolute;z-index: 100;display: none">
            <a href="${item.redirectUrl?default('/')}" class="adBox">
                <img src="${item.imageUrl?default('')}">
                <div class="content">${item.content?default(' ')}</div>
            </a>
            <div class="closeBtn">&times;</div>
        </div>
    <#if item_index==1><#break ><#break ></#if>
    </#list>
</#if>
<script type="text/javascript">
    $(function () {
        $(".navbar").addClass("navbar-fixed-top");

        if($.cookie('weCookie')==null){
            $(".we-model").show();
        }
        $(".we-model .model-table-close").on('click',function () {
            $(".we-model").hide();
            var weStatus=1;
            $.cookie('weCookie',weStatus,{expires: 1});
        });

        /*货源*/
        var goodsData={"pageIndex":"0","pageSize":"10"};
        tools.ajaxPost('/api/order/list/public',goodsData,function (json) {
            var str='';
            var scLength=json.list.length;
            if(scLength==0){
                str='<tr class="text-center no_data">' +
                    '<td colspan="6" width="1200px"><i class="warning"></i>暂时没有货源！</td>' +
                    '</tr>'
            }else{
                $.each(json.list,function (idx,val) {
                    str+='<tr>'+
                            '<td width="200px">'+val.oriProvince+val.oriCity+'</td>'+
                            '<td width="200px"><img src="/images/web/rote_line.png"></td>'+
                            '<td width="200px">'+val.arrProvince+val.arrCity+'</td>'+
                            '<td width="200px">'+val.driverFreight+'元</td>'+
                            '<td width="200px">'+val.loadTime+'</td>'+
                            '<td width="200px"><a class="detail_btn" onclick="goodsDetail('+val.id+')">货源详情</a></td>'+
                            '</tr>';
                });
            }

            var scrollObj=$(".goods-table tbody");
            scrollFn(scrollObj,str,scLength);
        });


        /*车源*/
        var carsData={"pageIndex":"0","pageSize":"10"};
        tools.ajaxPost('/api/driver/truckView/list/public',carsData,function (json) {
            var carStr='';
            var scLength=json.list.length;
            if(scLength==0){
                carStr='<tr class="text-center no_data">' +
                        '<td colspan="6" width="1200px"><i class="warning"></i>暂时没有车源！</td>' +
                        '</tr>'
            }else{
                $.each(json.list,function (idx,val) {
                    carStr+='<tr>' +
                            '<td width="200px"><img src="'+(val.dLicenseUrl ? val.dLicenseUrl : '/images/web/no_img.png')+'" width="30px" height="30px"></td>' +
                            '<td width="150px">'+val.model+'</td>' +
                            '<td width="200px">'+val.name+'</td>' +
                            '<td width="200px">'+val.province+val.city+'</td>' +
                            '<td width="200px">'+val.drivingExp+'</td>' +
                            '<td width="200px"><a class="detail_btn" onclick="carsDetail('+val.id+')">车源详情</a></td>' +
                            '</tr>';
                });
            }
            var scrollObj=$(".cars-table tbody");
            scrollFn(scrollObj,carStr,scLength);
        });

        /*广告位*/
        var ad0 = new FloatAd({
            floatObj : "advert0",
            x : 0,
            y : 250,
            locate : "left"
        });
        var ad1 = new FloatAd({
            floatObj : "advert1",
            x : 0,
            y : 250,
            locate : "right"
        });

        ad0.play();
        ad1.play();

        $(".advert .closeBtn").on('click',function () {
            $(this).closest('.advert').hide();
        })
    });

    //货源详细
    function goodsDetail(index) {
        tools.navigate('/order/take/'+index)
    }
    //车源详细
    function carsDetail(index) {
        tools.navigate('/cars/detail/'+index);
    }
    //公告详情
    function openNotice(index) {
        tools.navigate('/notices/detail/'+index);
    }
    //新闻详情
    function openNews(index) {
        tools.navigate('/news/detail/'+index);
    }
    /*滚动*/
    function scrollFn(obj,htm,length) {
        if(length<6){
            obj.html(htm);
        }else{
            htm+=htm;
            obj.html(htm);
            var speed=2000,timer=null;
            var scroll=0;
            timer=setInterval(fn,speed);
            obj.mouseover(function () {
                clearInterval(timer)   
            });
            obj.mouseout(function () {
                timer=setInterval(fn,speed);
            });
            function fn() {
                scroll=scroll+43;
                obj.animate({scrollTop:scroll+'px'},800);
                if(scroll>=(43*length)){
                    obj.animate({scrollTop:-scroll+'px'},0);
                    scroll=0;
                }
            }
        }
    }
    /*拨打电话*/
    function call() {
        if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){
            tools.confirm('联系客服：05394395888',function () {
                location.href('tel:05394395888');
            });
        }else{
            tools.confirm('联系客服：05394395888');
        }
    }

    /*专线详情*/
    function openLine(index) {
        var lineIndex=index;
        $('#line_detail').on('show.bs.modal', function () {
            if(lineIndex==0){
                $('#line_detail .carImg').attr('src','/images/web/cars/car.jpg');
                $('.arr_item .add a').html('平邑县地方镇（赵霞物流）');
                $('.arr_item .num a').html('0539-4395888 &nbsp;  0539-4391162  <br/> 13608992028 &nbsp;  13165286769');
                $('.dis_item .add a').html('临沂金兰物流园F1区113号');
                $('.dis_item .num a').html('0539-2772791 &nbsp; 0539-2772792<br> 15806929888');
                $('.other_item .type span').html('厢式货车');
                $('.other_item .date span').html('每日发车');
            }else if(lineIndex==1){
                $('#line_detail .carImg').attr('src','/images/web/cars/car2.jpg');
                $('.arr_item .add a').html('平邑县地方镇（赵霞物流）');
                $('.arr_item .num a').html('0539-4395888  &nbsp;  0539-4391162  <br/>  13608992028')
                $('.dis_item .add a').html('东北专线（沈阳、长春、哈尔滨）');
                $('.dis_item .num a').html('15806929888  &nbsp;  13165286769 <br/>  15866991917');
                $('.other_item .type span').html('半挂');
                $('.other_item .date span').html('每日发车');
            }else if(lineIndex==2){
                $('#line_detail .carImg').attr('src','/images/web/cars/car2.jpg');
                $('.arr_item .add a').html('平邑县朝霞国际保税物流园');
                $('.arr_item .num a').html('0539-4395888 &nbsp;  13608992028');
                $('.dis_item .add a').html('青岛、日照、连云港集装箱专线');
                $('.dis_item .num a').html('15806929888  &nbsp;  15854918866');
                $('.other_item .type span').html('半挂');
                $('.other_item .date span').html('每日发车');
            }
        });
        $('#line_detail').modal('show');
    }

</script>
<#include "/common/footerWeb.ftl"/>

