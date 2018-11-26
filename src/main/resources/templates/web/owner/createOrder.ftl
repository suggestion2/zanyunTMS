<#include "/common/headerWeb.ftl"/>
<#include "/common/navWeb.ftl"/>
<section class="main_section">
    <section class="center_section">
        <div class="container center_body orderBody" id="container"></div>
    <#--选择类型-->
    <#include "/web/owner/selectType.ftl"/>
    <#--个人 -->
    <#include "/web/owner/individualContractInfo.ftl"/>
    <#--企业-->
    <#include "/web/owner/buzContractInfo.ftl"/>
    <#--创建订车需求-->
    <#include "/web/owner/carDemand.ftl"/>
    <#--创建成功-->
    <#include "/web/owner/carSuc.ftl"/>
    </section>
</section>

<#--时间插件-->
<script src="/lib/laydate/laydate.js"></script>
<script src="/lib/web/page/page.js"></script>
<#--地址选择器 -->
<script src="/lib/citypicker/distpicker.data.js"></script>
<script src="/lib/citypicker/distpicker.js"></script>
<#--百度地图API-->
<script src="http://api.map.baidu.com/api?v=2.0&ak=O0QSY8RvyTGiiOWwZVNkAaqeGS4YfIZC"></script>
<script>
    var secData=null;   //第二页数据
    var orderId=null;     //创建后的订单id

</script>
<#include "/common/footerWeb.ftl"/>








