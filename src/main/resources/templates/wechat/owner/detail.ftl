<#include "/common/headerWechat.ftl"/>
<input value="${order.oriLong}" class="oriLong hide">
<input value="${order.oriLat}" class="oriLat hide">
<header class="bar bar-nav">
    <h3 class="title">订单详情</h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/owner/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body no_padding_fr">
        <#--
        <div class="mapBox">
            <div id="map"></div>
            <div class="tipBox">
                <div class="tip text-center">
                    <img src="/images/wechat/map_ico.png">
                    <p>${order.oriProvince+order.oriCity+order.oriCounty}</p>
                    <p class="oriAddress">${order.oriAddress}</p>
                    <a class="navigation" href="${"http://api.map.baidu.com/direction?origin=latlng:"+order.oriLat+","+order.oriLong+"|name:发货地&destination=latlng:"+order.arrLat+","+order.arrLong+"|卸货地&mode=driving&origin_region="+order.oriCounty+"&destination_region="+order.arrCounty+"&output=html"}">开始导航</a>
                </div>
            </div>
        </div>-->

        <div class="weui-cells recruit_info">
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>订单编号</p>
                </div>
                <div class="weui-cell__ft">${order.number} <#if order.status==-1>已取消<#elseif order.status==0>待审核<#elseif order.status==1>待接单<#elseif order.status==2>锁定<#elseif order.status==3>待运输<#elseif order.status==4>运输中<#elseif order.status==5>已完成</#if></div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>装货地址</p>
                </div>
                <div class="weui-cell__ft">${order.oriProvince+order.oriCity+order.oriCounty+order.oriAddress}</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>装货时间</p>
                </div>
                <div class="weui-cell__ft">${order.loadTime?string("yyyy-MM-dd")}</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>货物类型</p>
                </div>
                <div class="weui-cell__ft"><span>${order.cargoType}</span><span class="promise">保证发货<i class="fa fa-check-circle"></i></span></div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>货物描述</p>
                </div>
                <div class="weui-cell__ft"><span>${order.cargoDesc}</span></div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>卸货地址</p>
                </div>
                <div class="weui-cell__ft">${order.arrProvince+order.arrCity+order.arrCounty+order.arrAddress}</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>装货重量</p>
                </div>
                <div class="weui-cell__ft">${order.ton}吨</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>装货体积</p>
                </div>
                <div class="weui-cell__ft">${order.cube}方</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>货值</p>
                </div>
                <div class="weui-cell__ft">${order.cargoValue}元</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>收货公司</p>
                </div>
                <div class="weui-cell__ft">${order.dischargeCompany?default('')}</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>期望到货时间</p>
                </div>
                <div class="weui-cell__ft">${(landTime?string('yyyy-MM-dd'))?default('未要求')}</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>结算酬劳</p>
                </div>
                <div class="weui-cell__ft">${order.driverFreight?string("0.00")}元</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>实际运费</p>
                </div>
                <div class="weui-cell__ft">${order.finalFreight}元</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>结算方式</p>
                </div>
                <div class="weui-cell__ft">${order.driverPayType!""}</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>备注信息</p>
                </div>
                <div class="weui-cell__ft">${order.remarks?default('未要求')}</div>
            </div>
            <#if order.status==1>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>接单时间</p>
                    </div>
                    <div class="weui-cell__ft">${(order.paidTime?string('yyyy-MM-dd'))?default('-')}</div>
                </div>
            <#elseif order.status==3>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>接单时间</p>
                    </div>
                    <div class="weui-cell__ft">${(order.paidTime?string('yyyy-MM-dd'))?default('-')}</div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>装货时间</p>
                    </div>
                    <div class="weui-cell__ft">${(order.transportTime?string('yyyy-MM-dd'))?default('-')}</div>
                </div>
            <#elseif order.status==5>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>接单时间</p>
                    </div>
                    <div class="weui-cell__ft">${(order.paidTime?string('yyyy-MM-dd'))?default('-')}</div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>装货时间</p>
                    </div>
                    <div class="weui-cell__ft">${(order.transportTime?string('yyyy-MM-dd'))?default('-')}</div>
                </div>
                <div class="weui-cell">
                    <div class="weui-cell__bd">
                        <p>卸货时间</p>
                    </div>
                    <div class="weui-cell__ft">${(order.completeTime?string('yyyy-MM-dd'))?default('-')}</div>
                </div>
            </#if>
        </div>
        <#--<div class="relation text-center">
            <a href="tel:05394395888">联系客服</a>
        </div>-->
    </div>
</section>
<div class="weui-tabbar clearfix relation">
    <a class="g-col-6" href="tel:05394395888">联系客服</a>
    <a class="g-col-6" href="tel:${order.loadPhone}">联系收货方</a>
</div>

<script type="text/javascript">
    /*var pointLong=$(".oriLong").val();
    var pointLat=$(".oriLat").val();
    $(function () {
        // 百度地图API功能
        var map = new BMap.Map("map");    // 创建Map实例
        var point=new BMap.Point(pointLong,pointLat);
        map.centerAndZoom(point, 6);
        var marker = new BMap.Marker(point);  // 创建标注
        map.addOverlay(marker);               // 将标注添加到地图中
        marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
        map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
    });*/
</script>
<#include "/common/footerWechat.ftl"/>

