<#include "/common/headerWeb.ftl"/>
<#include "/common/navWeb.ftl"/>
<section class="main_section">
    <input value="${order.oriLong}" class="oriLong hide">
    <input value="${order.oriLat}" class="oriLat hide">
    <input value="${order.arrLong}" class="arrLong hide">
    <input value="${order.arrLat}" class="arrLat hide">
    <input value="${order.id}" class="orderId hide">
    <section class="center_section detail_section">
        <div class="container center_body">
            <div class="panel panel_info">
                <div class="panel-heading">
                    <h5 class="panel-title">货源详情</h5>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="mapBox">
                                <div id="map"></div>
                                <div class="tipBox">
                                    <div class="tip text-center">
                                        <img src="/images/web/map_ico.png">
                                        <p class="tip_a distant">运输全程约<span></span>公里</p>
                                        <p class="tip_t">支付信息费后查看完整订单信息</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <form class="form-horizontal detail_form" role="form">
                                <div class="form-group">
                                    <label class="col-xs-4">装货时间：</label>
                                    <div class="col-xs-8 ">${order.loadTime?string("yyyy-MM-dd")}</div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4">货物类型：</label>
                                    <div class="col-xs-8 ">
                                        <span>${order.cargoType}</span><span class="promise">保证发货<i class="fa fa-check-circle"></i></span>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4">装货地址：</label>
                                    <div class="col-xs-8 ">${order.oriProvince+order.oriCity+order.oriCounty}</div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4">卸货地址：</label>
                                    <div class="col-xs-8 ">${order.arrProvince+order.arrCity+order.arrCounty}</div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4">结算酬劳：</label>
                                    <div class="col-xs-8 ">${order.driverFreight?string("0.00")}元</div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4">结算方式：</label>
                                    <div class="col-xs-8 ">${order.driverPayType!""}</div>
                                </div>
                                <div class="item_pay">
                                    <a href="javascript:;" id="payClick" class="btn btn-danger" onclick="pay()">支付信息费并接单</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</section>
<div class="modal fade" id="weCodeModal"  role="dialog">
    <div class="modal-dialog" style="width: 400px">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    微信支付
                </h4>
            </div>
            <div class="modal-body">
                <div class="codeBox text-center" id="codeBox"></div>
            </div>
        </div>
    </div>
</div>
<#--百度地图API-->
<script src="http://api.map.baidu.com/api?v=2.0&ak=O0QSY8RvyTGiiOWwZVNkAaqeGS4YfIZC"></script>
<#--微信sdk-->
<script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js" type="text/javascript"></script>
<#--二维码生成-->
<script src="/lib/qrcode/jquery.qrcode.min.js"></script>
<script>
    var pointLong=$(".oriLong").val();
    var pointLat=$(".oriLat").val();
    var arrpointLong=$(".arrLong").val();
    var arrpointLat=$(".arrLat").val();
    var id=$(".orderId").val();
    $(function () {
        // 百度地图API功能
        var map = new BMap.Map("map");    // 创建Map实例
        var point=new BMap.Point(pointLong,pointLat);
        var arrpoint=new BMap.Point(arrpointLong,arrpointLat);
        map.centerAndZoom(point, 6);
        var marker = new BMap.Marker(point);  // 创建标注
        map.addOverlay(marker);               // 将标注添加到地图中
        marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
        map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放


        /*获取两地公里数*/
        var num=(map.getDistance(point,arrpoint)/1000).toFixed(0);
        $('.tipBox .distant span').text(num);
    });
    function pay() {
        $("#codeBox").html('');
        tools.ajaxPut("/api/order/take",{id:id},function (json) {
            $.ajax({
                type: "GET",
                url: "/wechat/native/code/" + json.paymentId,
                dataType: "json",
                success: function(data){
                    $("#codeBox").qrcode(data.code_url);
                    $("#weCodeModal").modal('show');
                    var timer=setInterval(function(){
                        $.ajax({
                            type: "GET",
                            url: "/wechat/payment/status",
                            dataType: "json",
                            success: function(status){
                                if(status.status == 1){
                                    clearTimeout(timer);
                                    tools.navigate("/order/protocol/" + id);
                                }
                            }
                        });
                    },1000)
                }
            });
        });
    }
</script>
<#include "/common/footerWeb.ftl"/>

