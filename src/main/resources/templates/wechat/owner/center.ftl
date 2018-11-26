<#include "/common/headerWechat.ftl"/>

<header class="bar bar-nav">
    <h3 class="title">货主个人中心</h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/owner/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body centerBox">
        <div class="weui-cells">
            <div class="weui-cell center_h" onclick="editName()">
                <div class="weui-cell__bd">
                    <#if  owner.name??>
                        <h5>${owner.name}</h5>
                    <#else>
                        <h5>${owner.phone}</h5>
                    </#if>
                    <p>个体货主</p>
                </div>
                <div class="weui-cell__ft">
                    <div class="h_img">
                        <img src="${owner.wechatHeadImg!"/images/wechat/header.png"}">
                    </div>
                </div>
            </div>
            <div class="weui-cell" onclick="openList(1)">
                <div class="weui-cell__bd">待接单</div>
                <div class="weui-cell__ft">${count.created}</div>
            </div>
            <div class="weui-cell" onclick="openList(3)">
                <div class="weui-cell__bd">待运输</div>
                <div class="weui-cell__ft">${count.accept}</div>
            </div>
            <div class="weui-cell" onclick="openList(4)">
                <div class="weui-cell__bd">运输中</div>
                <div class="weui-cell__ft">${count.transport}</div>
            </div>
            <div class="weui-cell" onclick="openList(10)">
                <div class="weui-cell__bd">全部订单</div>
                <div class="weui-cell__ft">${count.all}</div>
            </div>
            <a class="weui-cell" href="/address/list">
                <div class="weui-cell__bd">地址簿</div>
            </a>
            <div class="weui-cell">
                <div class="weui-cell__bd">
                    <a href="/owner/resetPassword">修改密码</a>
                </div>
            </div>
        </div>
        <div class="relation text-center">
            <a href="tel:05394395888">联系客服</a>
        </div>
    </div>

</section>
<script>
    function openList(status) {
        tools.navigate("/owner/order/list/"+status);
    }
    function editName() {
        $.prompt({
            text: "名字不超过6个字符",
            title: "输入姓名",
            onOK: function(text) {
                var reg=/^[\u2E80-\u9FFF]+$/;
                if(reg.test(text)&&(text.length<=6)){
                    var data={name:text};
                    tools.ajaxPut('/api/owner/update',data,function (json) {
                        $('.center_h .weui-cell__bd h5').text(text);
                        $.closeModal();
                    })
                }else{
                    $.toptip('用户名不超过6位的中文','error')
                }
            },
            input: $('.center_h .weui-cell__bd h5').text()
        });
        /*$.prompt({
            text:'名字不超过6个字符',
            title:'编辑姓名',
            onOK:function (text) {

            },
            onCancel:function () {

            },
            input:$('.center_h .cell__bd h5').text();
        })*/
    }
    /*function editName() {
        $.prompt({
            text:'名字不超过6个字符',
            title:'编辑姓名',
            onOK:function (text) {

            },
            onCancel:function () {
                
            },
            input:$('.center_h .cell__bd h5').text();
        })
    }*/
</script>
<#include "/common/footerWechat.ftl"/>

