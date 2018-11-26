<#include "/common/headerWechat.ftl"/>
<div class="container" id="container"></div>
<#--选择类型-->
<#include "/wechat/owner/selectType.ftl"/>
<#--企业-->
<#include "/wechat/owner/buzContractInfo.ftl"/>
<#--个人-->
<#include "/wechat/owner/individualContractInfo.ftl"/>
<#--创建订车需求-->
<#include "/wechat/owner/carDemand.ftl"/>
<#--城市选择-->
<script src="/lib/wechat/city-picker.js"></script>
<#--页面跳转-->
<script src="/lib/wechat/page.js"></script>
<#--百度地图API-->
<script src="http://api.map.baidu.com/api?v=2.0&ak=O0QSY8RvyTGiiOWwZVNkAaqeGS4YfIZC"></script>
<script type="text/javascript">
    /*创建全局变量*/
    var secData=null;   //第二页数据
</script>
<#include "/common/footerWechat.ftl"/>

