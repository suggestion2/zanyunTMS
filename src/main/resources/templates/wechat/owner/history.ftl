<#include "/common/headerWechat.ftl"/>
<input value="${status}" class="status hide">
<header class="bar bar-nav">
    <h3 class="title"><#if status==3>待运输订单<#elseif status==-1>已取消订单<#elseif status==0>待接单订单<#elseif status==4>运输中订单<#elseif status==5>已完成订单<#elseif status==10>全部订单</#if></h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/owner/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content no_padding_b">
    <div class="content_body recruit_box">
        <#if list??&&(list?size>0)>
            <input value="${count}" class="count hide">
            <ul class="recruitList">
                <#list list as item>
                    <li class="weui-flex" onclick="openDetail(${item.id})">
                        <div class="recruit_info weui-flex__item">
                            <div class="start">
                                <h5>${item.oriCity}</h5>
                                <p>${item.oriProvince+item.oriCity+item.oriCounty}</p>
                                <i class="add_ico"></i>
                            </div>
                            <div class="end">
                                <h5>${item.arrCity}</h5>
                                <p>${item.arrProvince+item.arrCity+item.arrCounty}</p>
                                <i class="add_ico"></i>
                            </div>
                            <div class="add_line">
                                <span></span>
                            </div>
                        </div>
                        <div class="recruit_date text-right">
                            <div class="time">
                                <p>${item.loadTime?string("yyyy-MM-dd")}</p>
                                <p>提货</p>
                            </div>
                            <div class="sum"><p>￥${item.ownerFreight?string("0.00")}</p></div>
                        </div>
                    </li>
                </#list>
            </ul>
        <#else>
            <div class="no_data text-center">
                <img src="/images/wechat/no_order.png">
                <div>
                    <p class="tip">暂无订单数据</p>
                </div>
            </div>
        </#if>
    </div>
    <div class="weui-loadmore">
        <i class="weui-loading"></i>
        <span class="weui-loadmore__tips">正在加载</span>
    </div>
</section>
<script type="text/javascript">
    $(function () {
        var data={"pageIndex":"1","pageSize":"20"};
        var count=$(".count").val();
        var status=$('.status').val();
        data.status=status;
        /*滚动加载*/
        var loading = false;
        $(document.body).infinite(1).on("infinite",function() {
            if(loading) {
                return false;
            }else{
                if(data.pageIndex>=count/data.pageSize){
                    /*$.toast("没有更多数据了！",1000);*/
                    return false;
                }else{
                    $(".weui-loadmore").show();
                    loading = true;
                    setTimeout(function() {
                        tools.ajaxPost('/api/order/list/'+status,data,function (json) {
                            var str='';
                            console.log(json);
                            $.each(json.list,function (idx,val) {
                                str+='<li class="weui-flex" onclick="openDetail(\'+val.id+\')">\n' +
                                        '<div class="recruit_info weui-flex__item ">\n' +
                                        '    <div class="start">\n' +
                                        '        <h5>'+val.oriCity+'</h5>\n' +
                                        '        <p>'+val.oriProvince+val.oriCity+val.oriCounty+'</p>\n' +
                                        '        <i class="add_ico"></i>\n' +
                                        '    </div>\n' +
                                        '    <div class="end">\n' +
                                        '        <h5>'+val.arrCity+'</h5>\n' +
                                        '        <p>'+val.arrProvince+val.arrCity+val.arrCounty+'</p>\n' +
                                        '        <i class="add_ico"></i>\n' +
                                        '    </div>\n' +
                                        '    <div class="add_line">\n' +
                                        '        <span></span>\n' +
                                        '    </div>\n' +
                                        '</div>\n' +
                                        '<div class="recruit_date text-right">\n' +
                                        '    <div class="time">\n' +
                                        '        <p>'+val.loadTime+'</p>\n' +
                                        '        <p>提货</p>\n' +
                                        '    </div>\n' +
                                        '    <div class="sum"><p>￥'+val.driverFreight+'</p></div>\n' +
                                        '</div>\n' +
                                        '</li>';
                            });
                            $('.recruitList').append(str);
                            data.pageIndex++;
                        });
                        loading = false;
                        $(".weui-loadmore").hide();
                    }, 2000);
                }
            }

        });
    });
    function openDetail(index) {
        tools.navigate('/owner/order/detail/'+index)
    }
</script>
<#include "/common/footerWechat.ftl"/>

