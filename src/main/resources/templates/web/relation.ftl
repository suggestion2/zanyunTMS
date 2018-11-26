<#include "/common/headerWeb.ftl"/>
<#include "/common/navWeb.ftl"/>
<section class="main_section">
    <section class="hero-unit-slider">
        <div id="carousel-hero" class="slick-carousel">
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <img src="/images/web/relation_bg.jpg" class="img-responsive" alt="Slider Image">
                </div>
            </div>
        </div>
    </section>
    <section class="relation_section center_section">
        <div class="container">
            <div class="row">
                <div class="panel panel_info">
                    <div class="panel-heading">
                        <h5 class="panel-title">联系我们</h5>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="companyMapBox">
                                    <div class="companyMap" id="companyMap"></div>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <address class="relation-info">
                                    <h4>山东赵霞物流有限公司</h4>
                                    <ul class="list-unstyled">
                                        <li><label>电话 ：</label>0539-4395888 &nbsp;&nbsp; 15806929888</li>
                                        <li><label>邮箱 ：</label>15806929888@163.com</li>
                                        <li><label>网址 ：</label>www.zxotms.com   /   www.zosoonblc.com</li>
                                        <li><label>地址 ：</label>临沂市平邑县地方镇</li>
                                        <li style="padding-left: 40px;"><img style="width: 170px;" src="/images/web/wechat-platform-code.jpg"><br><p style="padding-left: 26px;font-size: 12px;">微信扫一扫，立刻关注</p></li>
                                    </ul>
                                </address>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</section>

<script src="http://api.map.baidu.com/api?v=2.0&ak=O0QSY8RvyTGiiOWwZVNkAaqeGS4YfIZC"></script>
<script>


    $(function () {
        // 百度地图API功能
        var sContent =
                "<h4 style='margin:0 0 5px 0;font-size: 16px;color: #333'>山东赵霞物流有限公司</h4>" +
                "<p style='margin:0;line-height:1.5;font-size:14px;margin-top: 16px;color:#666'>山东省临沂市平邑县地方镇</p>" +
                "</div>";
        var map = new BMap.Map("companyMap");
        var point = new BMap.Point(117.87393,35.3414429);
        var marker = new BMap.Marker(point);
        marker.setAnimation(BMAP_ANIMATION_BOUNCE);
        var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
        var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
        map.addControl(top_left_control);
        map.addControl(top_left_navigation);
        var infoWindow = new BMap.InfoWindow(sContent);  // 创建信息窗口对象
        map.centerAndZoom(point, 10);
        map.addOverlay(marker);
        map.enableScrollWheelZoom(true);
        marker.addEventListener("click", function(){
            this.openInfoWindow(infoWindow);
        });
    });
</script>
<#include "/common/footerWeb.ftl"/>

