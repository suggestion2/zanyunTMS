<#include "/common/headerWechat.ftl"/>
<input value="${order.oriLong}" class="oriLong hide">
<input value="${order.oriLat}" class="oriLat hide">
<input value="${order.arrLong}" class="arrLong hide">
<input value="${order.arrLat}" class="arrLat hide">
<input value="${order.id}" class="orderId hide">
<header class="bar bar-nav">
    <h3 class="title">订单详情</h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/driver/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body no_padding_fr">
        <div class="mapBox">
            <div id="map"></div>
            <div class="tipBox">
                <div class="tip text-center">
                    <img src="/images/wechat/map_ico.png">
                    <#--<p>${order.oriProvince+order.oriCity+order.oriCounty}</p>-->
                    <p class="distant" style="margin-bottom: 16px">运输全程约<span></span>公里</p>
                    <#if order.status==2>
                        <a class="navigation">支付完成后查看路线</a>
                    <#else>
                        <a class="navigation" target="_blank" href="${"http://api.map.baidu.com/direction?origin=latlng:"+order.oriLat+","+order.oriLong+"|name:发货地&destination=latlng:"+order.arrLat+","+order.arrLong+"|卸货地&mode=driving&origin_region="+order.oriCounty+"&destination_region="+order.arrCounty+"&output=html"}">开始导航</a>
                    </#if>

                </div>
            </div>
        </div>
        <div class="weui-cells recruit_info">
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>订单编号</p>
                </div>
                <div class="weui-cell__ft">${order.number}</div>
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
            <a class="weui-cell" href="${"http://api.map.baidu.com/direction?origin=latlng:"+order.oriLat+","+order.oriLong+"|name:发货地&destination=latlng:"+order.arrLat+","+order.arrLong+"|卸货地&mode=driving&origin_region="+order.oriCounty+"&destination_region="+order.arrCounty+"&output=html"}">
                <div class="weui-cell__bd">
                    <p style="color:#484848">装货地址</p>
                </div>
                <div class="weui-cell__ft">${order.oriProvince+order.oriCity+order.oriCounty+order.oriAddress}</div>
            </a>
            <a class="weui-cell" href="${"http://api.map.baidu.com/direction?origin=latlng:"+order.oriLat+","+order.oriLong+"|name:发货地&destination=latlng:"+order.arrLat+","+order.arrLong+"|卸货地&mode=driving&origin_region="+order.oriCounty+"&destination_region="+order.arrCounty+"&output=html"}">
                <div class="weui-cell__bd">
                    <p style="color:#484848">卸货地址</p>
                </div>
                <div class="weui-cell__ft">${order.arrProvince+order.arrCity+order.arrCounty+order.arrAddress}</div>
            </a>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>结算酬劳</p>
                </div>
                <div class="weui-cell__ft">${order.driverFreight?string("0.00")}元</div>
            </div>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <p>结算方式</p>
                </div>
                <div class="weui-cell__ft">${order.driverPayType!""}</div>
            </div>
            <#if order.status==2>
                <div class="item_pay">
                    <a href="javascript:;" id="payClick" class="weui-btn weui-btn_primary" onclick="pay()" disabled="true">继续支付</a>
                </div>
            </#if>
        </div>
        <div class="relation text-center">
            <a href="tel:05394395888">联系客服</a>
        </div>
    </div>
</section>
<#--百度地图API-->
<script src="http://api.map.baidu.com/api?v=2.0&ak=O0QSY8RvyTGiiOWwZVNkAaqeGS4YfIZC"></script>

<#--微信sdk-->
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>

<script type="text/javascript">
    var oriLong=$(".oriLong").val();
    var oriLat=$(".oriLat").val();
    var arrLong=$(".arrLong").val();
    var arrLat=$(".arrLat").val();
    var id=$(".orderId").val();
    $(function () {
        // 百度地图API功能
        var map = new BMap.Map("map");    // 创建Map实例
        var point=new BMap.Point(oriLong,oriLat);
        var arrpoint=new BMap.Point(arrLong,arrLat);
        map.centerAndZoom(point, 6);
        var marker = new BMap.Marker(point);  // 创建标注
        map.addOverlay(marker);               // 将标注添加到地图中
        marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
        map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放

        /*获取两地公里数*/
        var num=(map.getDistance(point,arrpoint)/1000).toFixed(0);
        $('.tipBox .distant span').text(num);

       /* $(".navigation").on('click',function () {
            tools.navigate('http://api.map.baidu.com/direction?origin=latlng:'+oriLat+','+oriLong+'&destination=latlng:'+arrLat+','+arrLong+'&mode=driving&region=null&output=html')
        })*/

        /*支付*/
        $.ajax({
            type: "POST",
            url: "/wechat/js/configParams",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({
                "url": location.href.split('#')[0]
            }),
            success: function (data) {
                window.wx.config({
                    appId: data.appId,
                    timestamp: data.timestamp,
                    nonceStr: data.nonceStr,
                    signature: data.signature,
                    jsApiList: data.jsApiList
                });
            },
            error: function (data) {
                console.log(data);
            }
        });

        window.wx.ready(function(){
            $("#payClick").attr("disabled",false);
        });
    });

    function pay() {

        $.ajax({
            type: "PUT",
            url: "/api/order/take",
            dataType: "json",
            contentType: "application/json",
            data: JSON.stringify({
                "id": id
            }),
            success: function (data) {
                var orderId = data.orderId;
                $.ajax({
                    type: "GET",
                    url: "/wechat/js/payParams/" + data.paymentId,
                    success: function (data) {
                        window.wx.chooseWXPay({
                            timestamp: data.timestamp,
                            nonceStr: data.nonceStr,
                            package: data.package,
                            signType: data.signType,
                            paySign: data.paySign,
                            success: function () {
                                tools.navigate("/order/protocol/" + orderId);
                            },
                            fail:function(){
                                $.toast("支付失败,请联系客服","forbidden");
                            }
                        });
                    },
                    error: function () {
                        $.toast("系统错误","forbidden");
                    }
                });
            },
            error: function (data) {
                var resJson = tools.toJson(data.responseText);
                if(resJson.message==null){
                    $.toast(resJson.fieldError.message, "forbidden");
                }else{
                    $.toast(resJson.message, "forbidden");
                }
            }
        });
    }
</script>
<#include "/common/footerWechat.ftl"/>

