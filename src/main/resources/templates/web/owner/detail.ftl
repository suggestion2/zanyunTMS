<#include "/common/headerWeb.ftl"/>
<#include "/common/navWeb.ftl"/>
<section class="mian_section">
    <input value="${order.oriLong}" class="oriLong hide">
    <input value="${order.oriLat}" class="oriLat hide">
    <section class="center_section detail_section">
        <div class="container center_body">
            <div class="panel panel_info">
                <div class="panel-heading">
                    <h5 class="panel-title">订单详情</h5>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal detail_form">
                        <div class="row">
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">订单编号：</label>
                                <div class="col-xs-8 ">${order.number} </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">订单状态：</label>
                                <div class="col-xs-8 "><#if order.status==-1>已取消<#elseif order.status==0>待审核<#elseif order.status==1>待接单<#elseif order.status==2>锁定<#elseif order.status==3>待运输<#elseif order.status==4>运输中<#elseif order.status==5>已完成</#if></div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">装货地址：</label>
                                <div class="col-xs-8 ">${order.oriProvince+order.oriCity+order.oriCounty+order.oriAddress}</div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">装货时间：</label>
                                <div class="col-xs-8 ">${order.loadTime?string("yyyy-MM-dd")}</div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">货物类型：</label>
                                <div class="col-xs-8 ">
                                    <span>${order.cargoType}</span><span class="promise">保证发货<i class="fa fa-check-circle"></i></span>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">货物描述：</label>
                                <div class="col-xs-8 ">
                                    <span>${order.cargoDesc}</span>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">卸货地址：</label>
                                <div class="col-xs-8 ">${order.arrProvince+order.arrCity+order.arrCounty}</div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">装货重量：</label>
                                <div class="col-xs-8 ">
                                    <span>${order.ton}吨</span>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">装货体积：</label>
                                <div class="col-xs-8 ">
                                    <span>${order.cube}方</span>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">货值：</label>
                                <div class="col-xs-8 ">
                                    <span>${order.cargoValue}元</span>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">收货公司：</label>
                                <div class="col-xs-8 ">
                                    <span>${order.dischargeCompany?default('')}</span>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">期望到货时间：</label>
                                <div class="col-xs-8 ">
                                    <span>${(landTime?string('yyyy-MM-dd'))?default('未要求')}</span>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">结算酬劳：</label>
                                <div class="col-xs-8 ">${order.driverFreight?string("0.00")}元</div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">实际运费：</label>
                                <div class="col-xs-8 ">
                                    <span>${order.finalFreight}元</span>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">结算方式：</label>
                                <div class="col-xs-8 ">${order.driverPayType!""}</div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="col-xs-4">备注信息：</label>
                                <div class="col-xs-8 ">
                                    <span>${order.remarks?default('未要求')}</span>
                                </div>
                            </div>
                            <#if order.status==1>
                                <div class="form-group col-sm-6">
                                    <label class="col-xs-4">接单时间：</label>
                                    <div class="col-xs-8 ">
                                        <span>${(order.paidTime?string('yyyy-MM-dd'))?default('-')}</span>
                                    </div>
                                </div>
                            <#elseif order.status==3>
                                <div class="form-group col-sm-6">
                                    <label class="col-xs-4">接单时间：</label>
                                    <div class="col-xs-8 ">
                                        <span>${(order.paidTime?string('yyyy-MM-dd'))?default('-')}</span>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <label class="col-xs-4">装货时间：</label>
                                    <div class="col-xs-8 ">
                                        <span>${(order.transportTime?string('yyyy-MM-dd'))?default('-')}</span>
                                    </div>
                                </div>
                            <#elseif order.status==5>
                                <div class="form-group col-sm-6">
                                    <label class="col-xs-4">接单时间：</label>
                                    <div class="col-xs-8 ">
                                        <span>${(order.paidTime?string('yyyy-MM-dd'))?default('-')}</span>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <label class="col-xs-4">装货时间：</label>
                                    <div class="col-xs-8 ">
                                        <span>${(order.transportTime?string('yyyy-MM-dd'))?default('-')}</span>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <label class="col-xs-4">卸货时间：</label>
                                    <div class="col-xs-8 ">
                                        <span>${(order.completeTime?string('yyyy-MM-dd'))?default('-')}</span>
                                    </div>
                                </div>
                            </#if>
                            <div class="item_submit col-sm-12 text-center" style="margin-top: 30px">
                                <a class="btn btn-danger backToList" style="margin: 0 6px" href="/owner/order/list/10">返回列表</a>
                                <a class="btn btn-danger" style="margin: 0 6px" id="relation">联系客服</a>
                                <a class="btn btn-danger" style="margin: 0 6px" id="relationLoad" data-phone="${order.loadPhone}">联系收货方</a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
</section>

<script>
$(function () {
    $('#relation').on('click',function () {
        if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){
            tools.confirm('联系客服：05394395888',function () {
                location.href('tel:05394395888');
            });
        }else{
            tools.confirm('联系客服：05394395888');
        }
    });
    $('#relationLoad').on('click',function () {
        var phone=$(this).data('phone');
        if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){
            tools.confirm('联系收获方：'+phone,function () {
                location.href('tel:'+phone);
            });
        }else{
            tools.confirm('联系收获方：'+phone);
        }
    });
})
</script>
<#include "/common/footerWeb.ftl"/>

