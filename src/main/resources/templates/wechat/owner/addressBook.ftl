<#include "/common/headerWechat.ftl"/>

<header class="bar bar-nav">
    <h3 class="title">地址簿</h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/owner/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body addressBox">
        <#if list??&&(list?size>0)>
            <p class="tip">最多保存10条地址</p>
            <div class="address_list">
            <#list list as item>
                <div class="address_item">
                    <div class="address-inner">
                        <div class="title">
                            <span class="name">${item.contact}</span>
                            <span class="mobile">${item.phone}</span>
                        </div>
                        <div class="text">
                            <span class="address">${item.province + item.city + item.county + item.address}</span>
                        </div>
                        <div class="oPar text-center">
                            <a href="/address/update/${item.id}"><i class="fa fa-edit"></i>编辑</a>
                            <a onclick="deleteAddress(${item.id})"><i class="fa fa-trash-o"></i>删除</a>
                        </div>
                    </div>
                </div>
            </#list>
            </div>
        <#else>
            <div class="no_data text-center">
                <img src="/images/wechat/no_order.png">
                <div>
                    <p class="tip">暂无地址！</p>
                </div>
            </div>
        </#if>
    </div>
    <#if list?size<10>
        <a class="add_bar text-center" href="/address/create">
            <i class="fa fa-plus"></i>新建地址
        </a>
    </#if>
</section>
<script>
    function deleteAddress(id) {
        $.confirm("确定删除该地址？", function() {
            $.ajax({
                url:'/api/address/'+id,
                type:'DELETE',
                dataType:'html',
                success:function (data) {
                    tools.navigate('');
                }
            })
        });
    }
</script>
<#include "/common/footerWechat.ftl"/>

