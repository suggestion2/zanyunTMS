<#include "/common/headerWeb.ftl"/>
<#include "/common/navWeb.ftl"/>
<section class="hero-unit-slider paddingT90">
    <div id="carousel-hero" class="slick-carousel">
        <div class="carousel-inner" role="listbox">
            <div class="item active">
                <img src="/images/web/sliders/banner_1.jpg" class="img-responsive" alt="Slider Image">
            </div>
            <div class="item">
                <img src="/images/web/sliders/banner_2.jpg" class="img-responsive" alt="Slider Image">
            </div>
            <div class="item">
                <img src="/images/web/sliders/banner_3.jpg" class="img-responsive" alt="Slider Image">
            </div>
        </div>
    </div>
</section>
<#--特色服务-->
<section class="service_section">
    <div class="container">
        <div class="clearfix">
            <div class="service_item col-sm-3 col-xs-6">
                <img src="/images/web/service-icon-1.png">
                <h4>特色服务</h4>
                <span>运费便宜30%</span>
            </div>
            <div class="service_item col-sm-3 col-xs-6">
                <img src="/images/web/service-icon-1.png">
                <h4>特色服务</h4>
                <span>运费便宜30%</span>
            </div>
            <div class="service_item col-sm-3 col-xs-6">
                <img src="/images/web/service-icon-1.png">
                <h4>特色服务</h4>
                <span>运费便宜30%</span>
            </div>
            <div class="service_item col-sm-3 col-xs-6">
                <img src="/images/web/service-icon-1.png">
                <h4>公众号</h4>
                <span>运费便宜30%</span>
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
                        <a class="more pull-right" href="javascript:;">查看更多</a>
                    </div>
                    <div class="notice_body">
                        <div class="goodsMessage">
                            <table class="table-fixed table-source goods-table">
                                <thead>
                                <tr>
                                    <th width="200px">发货地</th>
                                    <th width="200px"></th>
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
                        <a class="more pull-right" href="javascript:;">查看更多</a>
                    </div>
                    <div class="notice_body sou_notice">
                        <ul class="notice_list">
                            <li><i></i><a href="javascript:;">直击互联网大会五大战略选择助力物流企业互联网转型</a><span>2017-10-1</span></li>
                            <li><i></i><a href="javascript:;">有活干了！2016-2018年全国重大工程项目都在这儿了，共4.7万亿！（附项目清单）</a><span>2017-10-1</span></li>
                            <li><i></i><a href="javascript:;">2017工程机械行业运行状况与趋势分析，必看！</a><span>2017-10-1</span></li>
                            <li><i></i><a href="javascript:;">2017年对大件运输影响重大的5项政策！再忙都要看</a><span>2017-10-1</span></li>
                            <li><i></i><a href="javascript:;">七省市跨省大件运输许可联网</a><span>2017-10-1</span></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    <#--车源-->
        <h1 class="section_title">车源信息<br><small>Car  Information</small></h1>
        <div class="row">
            <div class="col-sm-8">
                <div class="notice_box">
                    <div class="notice_header clearfix">
                        <a class="notice_title pull-left">最新车源</a>
                        <a class="more pull-right" href="javascript:;">查看更多</a>
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
                                <div class="item_line clearfix">
                                    <div class="imgBox">
                                        <img src="/images/web/cars/car.jpg">
                                    </div>
                                    <div class="line_info">
                                        <h5>福建厦门  <i>--></i>  福建福州</h5>
                                        <p><label>车型：</label>厢式/板式货车（东风）</p>
                                        <p><label>载重：</label>80吨<label style="margin-left: 8px">司机：</label>李司机</p>
                                    </div>
                                    <label class="tag">
                                        <span>每日发车</span>
                                    </label>
                                </div>
                            </li>
                            <li>
                                <div class="item_line clearfix">
                                    <div class="imgBox">
                                        <img src="/images/web/cars/car.jpg">
                                    </div>
                                    <div class="line_info">
                                        <h5>福建厦门  <i>--></i>  福建福州</h5>
                                        <p><label>车型：</label>厢式/板式货车（东风）</p>
                                        <p><label>载重：</label>80吨<label style="margin-left: 8px">司机：</label>李司机</p>
                                    </div>
                                    <label class="tag">
                                        <span>每日发车</span>
                                    </label>
                                </div>
                            </li>
                            <li>
                                <div class="item_line clearfix">
                                    <div class="imgBox">
                                        <img src="/images/web/cars/car.jpg">
                                    </div>
                                    <div class="line_info">
                                        <h5>福建厦门  <i>--></i>  福建福州</h5>
                                        <p><label>车型：</label>厢式/板式货车（东风）</p>
                                        <p><label>载重：</label>80吨<label style="margin-left: 8px">司机：</label>李司机</p>
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
                        <a class="more pull-right" href="javascript:;">更多视频</a>
                    </div>
                    <div class="notice_body">
                        <video width="100%" height="100%" controls style="background: #000">
                            <source src="http://video.renmings.com/611d3b09a11f4179be155f63d37f523a/cec52c522c2f4837801c8abf15552f9a-5287d2089db37e62345123a1be272f8b.mp4" type="video/mp4">
                            <object data="movie.mp4" width="100%" height="100%">
                                <embed src="http://video.renmings.com/611d3b09a11f4179be155f63d37f523a/cec52c522c2f4837801c8abf15552f9a-5287d2089db37e62345123a1be272f8b.mp4" width="320" height="240">
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
                        <a class="more pull-right" href="javascript:;">更多新闻</a>
                    </div>
                    <div class="notice_body news_notice">
                        <ul class="news_list">
                            <li class="clearfix">
                                <div class="col-xs-3">
                                    <img src="/images/web/new.jpg" class="news_img">
                                </div>
                                <div class="col-xs-9">
                                    <div class="news_body">
                                        <h4>我司XXX董事长出席十九大人民代表大会</h4>
                                        <p>这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容</p>
                                    </div>
                                    <div class="news_footer clearfix">
                                        <span class="pull-left">发布时间：2010-10-2</span>
                                        <a href="javascript:;" class="pull-right">>>查看详情</a>
                                    </div>
                                </div>
                            </li>
                            <li class="clearfix">
                                <div class="col-xs-3">
                                    <img src="/images/web/new.jpg" class="news_img">
                                </div>
                                <div class="col-xs-9">
                                    <div class="news_body">
                                        <h4>我司XXX董事长出席十九大人民代表大会</h4>
                                        <p>这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容这是内容</p>
                                    </div>
                                    <div class="news_footer clearfix">
                                        <span class="pull-left">发布时间：2010-10-2</span>
                                        <a href="javascript:;" class="pull-right">>>查看详情</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
<div class="modal fade" id="line_modal"role="dialog">
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
                        <a>联系客服，获取报价。</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>

    $(function () {
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
            var scrollObj=$(".goods-table tbody");
            scrollFn(scrollObj,str,scLength);
        });


        /*车源*/
        var carsData={"pageIndex":"0","pageSize":"10"};
        tools.ajaxPost('/api/driver/truckView/list/public',carsData,function (json) {
            var carStr='';
            var scLength=json.list.length;
            $.each(json.list,function (idx,val) {
                carStr+='<tr>' +
                        '<td width="200px"><img src="'+val.dLicenseUrl+'" width="30px" height="30px"></td>' +
                        '<td width="200px">'+val.model+'</td>' +
                        '<td width="200px">'+val.name+'</td>' +
                        '<td width="200px">'+val.province+val.city+'</td>' +
                        '<td width="200px">'+val.drivingExp+'</td>' +
                        '<td width="200px"><a class="detail_btn" onclick="carsDetail('+val.id+')">车源详情</a></td>' +
                        '</tr>';
            });
            var scrollObj=$(".cars-table tbody");
            scrollFn(scrollObj,carStr,scLength);
        })
    });

    //货源详细
    function goodsDetail(index) {
        alert(index);
    }
    //车源详细
    function carsDetail(index) {
        alert(index)
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
</script>
<#include "/common/footerWeb.ftl"/>

