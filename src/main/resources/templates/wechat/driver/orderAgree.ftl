<#include "/common/headerWechat.ftl"/>
<section class="content" style="padding-top: 0">
    <div class="content_body no_padding_fr">
        <div class="agreementBox">
            <h4 class="text-center">运输协议书</h4>
            <div class="row">甲方（承运单位）：</div>
            <div class="row">
                <div class="g-col-12"><label>姓名：</label><input value="${driver.name?default('')}" type="text" disabled></div>
                <div class="g-col-12"><label>驾驶证号：</label><input value="${driver.licenseNum?default('')}" type="text" disabled></div>
                <div class="g-col-12"><label>身份证号：</label><input value="" type="text" disabled></div>
                <div class="g-col-12"><label>车牌号：</label><input value="${driver.licensePlate?default('')}" type="text" disabled></div>
                <div class="g-col-12"><label>车架号：</label><input value="${driver.dLicenseNum?default('')}" type="text" disabled></div>
                <div class="g-col-12"><label>发动机号：</label><input value="${driver.engineNum?default('')}" type="text" disabled></div>
                <div class="g-col-12"><label>详细地址： </label><input value="${driver.province?default('')+driver.city?default('')+driver.county?default('')}" type="text" disabled></div>
            </div>
            <div style="margin-top: 20px;" class="row">乙方（托运单位）：</div>
            <div class="row">
                <div class="col-sm-12"><label style="width: 140px;">个体姓名或单位名称： </label><input value="<#if order.type==1>${order.ownerName?default('')}<#elseif order.type==2>${order.companyName?default('')}</#if>" type="text" disabled style="text-align: left;width: 100%"></div>
                <div class="col-sm-6"><label style="width: 130px;">托运人身份证号：</label><input value="${order.ownerIdCardNum?default('')}" type="text" disabled style="text-align: left;width: 100%"></div>
                <div class="col-sm-6"><label style="width: 130px;">企业证件编号：</label><input value="${order.companyLicenseCode?default('')}" type="text" disabled style="text-align: left;width: 100%"></div>
                <div class="col-sm-6"><label style="width: 130px;">发货地址：</label><input value="${order.oriProvince+order.oriCity+order.oriCounty+order.oriAddress}" type="text" disabled style="text-align: left;width: 100%"></div>
            </div>
            <div style="margin-top: 20px;" class="row">
                <div style="text-indent: 2em;">为提高货运效益，明确承运、托运双方的权利、义务及责任，本着平等互利、共同发展的原则，经承运、托运双方协商同意，互相查证无异议后方可签订以下协议：</div>
                <div>1. 货物于<input type="text" <#if order.landTime??>value="${order.landTime?string('yyyy')}"</#if>  disabled style="width:50px">年<input type="text" <#if order.landTime??>value="${order.landTime?string('MM')}"</#if>  disabled style="width:50px">月<input type="text" <#if order.landTime??>value="${order.landTime?string('dd')}" </#if> disabled style="width:50px">日前运抵交付单位<input type="text" value="${order.dischargeCompany?default('')}" disabled style="width:180px">查收由<input type="text" value="甲" disabled style="width:70px">方负责押运。</div>
                <div>2. 托运货物中严禁夹带易燃、易爆、危险品及禁运物资。</div>
                <div>3. 运输途中因承运手续不全，车况不良等原因造成的事故，罚款损失由承运单位负责承担，因货物手续不全，包装缺陷等原因造成的事故罚款、损失由承运单位负责承担。</div>
                <div>4. 本公司只提供为货找车，为车找货的货运信息，不负责其他任何责任。签订协议后，承运托运双方如发生纠纷，可以协商解决，如需发生诉讼的，须在乙方（托运方）所在法院诉讼执行。</div>
                <div>5. 为了保证运输信息的真实性和保密性，凡是签过本协议的承运方。托运方不得直接联系，如有违反，属于偷窃临沂市赵霞货运公司的商业信息，后果自负。</div>
                <div>6. 本协议一式三份，承运方、托运方各持一份，货运公司存档一份，承、托运双方签字后生效。</div>
            </div>
            <div style="margin: 10px 0;" class="row"><table style="width: 100%;">
                <tr><td>货物名称</td><td>货物价值</td><td>装货数量</td><td>合计车费</td><td>运费结算方式</td></tr>
                <tr><td>${order.cargoDesc?default('')}</td><td>${order.cargoValue?default('')}</td><td>${order.pieces?default('')}</td><td>${order.driverFreight?default('')}</td><td>${order.driverPayType?default('')}</td></tr>
            </table></div>
            <div class="row" style="margin-top: 50px;">
                <div class="g-col-6">甲方：</div><div class="g-col-6">乙方：</div>
                <div class="g-col-6">(签字)</div><div class="g-col-6">(签字)</div>
            </div>
            <div class="row">
                <a href="/driver/order/detail/${order.id}" class="weui-btn weui-btn_primary" style="margin-top: 40px;">我已阅读</a>
            </div>
        </div>
    </div>
</section>
<script type="text/javascript">

</script>
<#include "/common/footerWechat.ftl"/>

