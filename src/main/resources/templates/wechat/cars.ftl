<#include "/common/headerWechat.ftl"/>
<header class="bar bar-nav">
    <h3 class="title">车源大厅</h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/owner/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body driver_box">
        <#if carsView.list??&&(carsView.list?size>0)>
            <input value="${carsView.count}" class="count hide">
            <ul class="driverList">
                <#list carsView.list as item>
                    <li class="weui-flex" onclick="openDetail(${item.id})">
                        <div class="car_img ">
                            <img src="${item.dLicenseUrl?default('/images/web/no_img.png')}">
                        </div>
                        <div class="driver_info weui-flex__item">
                            <h4>${item.name?default('信息不完整')}</h4>
                            <p>#${(item.province+item.city+item.county)?default('信息不完整')}发车 </p>
                            <p>${item.model?default('信息不完整')} #驾龄${item.drivingExp?default('信息不完整')} </p>
                        </div>
                    </li>
                </#list>
            </ul>
        <#else>
            <div class="no_data text-center">
                <img src="/images/wechat/no_order.png">
                <div>
                    <p class="tip">暂无车源数据！</p>
                </div>
            </div>
        </#if>
    </div>
</section>
<#--查看车辆图片-->
<div id="driver_detail" class="weui-popup__container">
    <div class="weui-popup__overlay"></div>
    <div class="weui-popup__modal">
        <i class="closeBtn close-popup"></i>
        <div class="viewImgBox">
            <div class="view_title text-center">
                <h5>车辆实景图</h5>
            </div>
            <div class="view_body">
                <img src="" class="carImg">
                <p class="driver_text"></p>
                <p>该司机已通过平台验证，您可放心订车。</p>
            </div>
        </div>
    </div>
</div>
<script>
    function openDetail(index) {
        var url='/api/driver/truckView/'+index;
        tools.ajax({
            type: "GET",
            url: url,
            contentType: APPLICATION_JSON,
            success:function (json) {
                var driver=json;
                $("#driver_detail .carImg").attr('src',driver.dLicenseUrl);
                if(!driver.taskAddress1){
                    driver.taskAddress1=='未填写'
                }
                if(!driver.taskAddress2){
                    driver.taskAddress2=='未填写'
                }
                if(!driver.taskAddress3){
                    driver.taskAddress3=='未填写'
                }
                if(!driver.taskAddress4){
                    driver.taskAddress4=='未填写'
                }
                var str='司机'+driver.name+'驾龄'+driver.drivingExp+'，持有'+driver.model+'，长期往返'+driver.city+'至全国各地。专线1：'+driver.taskAddress1+'--'+driver.taskAddress2+'，专线2：'+driver.taskAddress3+'--'+driver.taskAddress4+'。';
                $("#driver_detail .driver_text").text(str);
                $("#driver_detail").popup();
            }
        })
    }
</script>
<#include "/common/footerWechat.ftl"/>

