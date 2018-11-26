<#include "/common/headerWechat.ftl"/>

<header class="bar bar-nav">
    <h3 class="title">货源大厅</h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/driver/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content no_padding_b">
    <div class="weui-pull-to-refresh__layer">
        <div class='weui-pull-to-refresh__arrow'></div>
        <div class='weui-pull-to-refresh__preloader'></div>
        <div class="down">下拉刷新</div>
        <div class="up">释放刷新</div>
        <div class="refresh">正在刷新</div>
    </div>
    <div class="content_body recruit_box">
        <#if list??&&(list?size>0)>
        <ul class="recruitList">
            <input value="${count}" class="count hide">
            <#list list as item>
                <li class="weui-flex" onclick="openDetail(${item.id})">
                    <div class="recruit_info weui-flex__item">
                        <div class="start">
                            <h5>${item.oriCity}</h5>
                            <p>${item.oriProvince+item.oriCity+item.oriCounty}<span>&nbsp;接单后显示详细信息</span></p>
                            <div class="add_ico"><i></i></div>
                        </div>
                        <div class="end">
                            <h5>${item.arrCity}</h5>
                            <p>${item.arrProvince+item.arrCity+item.arrCounty}<span>&nbsp;接单后显示详细信息</span></p>
                            <div class="add_ico"><i></i></div>
                        </div>
                        <div class="add_line">
                            <span></span>
                        </div>
                    </div>
                    <div class="recruit_date text-right">
                        <div class="time">
                            <p>${item.loadTime?string("yyyy-MM-dd")}</p>
                            <p>提货</p>
                            <p class="type">${item.ton+'吨-'+item.cargoDesc}</p>
                        </div>

                        <div class="sum"><p>￥${item.driverFreight?string("0.00")}</p></div>
                    </div>
                </li>
            </#list>
        </ul>
        <#else>
            <div class="no_data text-center">
                <img src="/images/wechat/no_order.png">
                <div>
                    <p class="tip">暂无货源数据，等待货主发布新货源！</p>
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
        /*下拉刷新*/
        $(".content").pullToRefresh(30).on("pull-to-refresh", function() {
            var self=this;
            setTimeout(function() {
                $(".recruit_box .recruitList li").remove();
                tools.ajaxPost('/api/order/list',{"pageIndex":"0","pageSize":"20"},function (json) {
                    var str='';
                    $.each(json.list,function (idx,val) {
                        str+='<li class="weui-flex" onclick="openDetail('+val.id+')">' +
                                '<div class="recruit_info weui-flex__item ">' +
                                '    <div class="start">' +
                                '        <h5>'+val.oriCity+'</h5>' +
                                '        <p>'+val.oriProvince+val.oriCity+val.oriCounty+'</p>' +
                                '        <i class="add_ico"></i>' +
                                '    </div>' +
                                '    <div class="end">' +
                                '        <h5>'+val.arrCity+'</h5>' +
                                '        <p>'+val.arrProvince+val.arrCity+val.arrCounty+'</p>' +
                                '        <i class="add_ico"></i>' +
                                '    </div>' +
                                '    <div class="add_line">' +
                                '        <span></span>' +
                                '    </div>' +
                                '</div>' +
                                '<div class="recruit_date text-right">' +
                                '    <div class="time">' +
                                '        <p>'+val.loadTime+'</p>' +
                                '        <p>提货</p>' +
                                '        <p class="type">'+val.ton+'吨-'+val.cargoDesc+'</p>'+
                                '    </div>' +
                                '    <div class="sum"><p>￥'+val.driverFreight+'</p></div>' +
                                '</div>' +
                                '</li>';
                    });
                    $('.recruitList').append(str);
                });
                $(self).pullToRefreshDone();
            }, 2000);
        });

        /*滚动加载*/
        var loading = false;
        $(document.body).infinite(1).on("infinite",function() {
            if(loading) {
                return false;
            }else{
                if(data.pageIndex>=count/data.pageSize){
                    return false;
                }else{
                    $(".weui-loadmore").show();
                    loading = true;
                    setTimeout(function() {
                        tools.ajaxPost('/api/order/list',data,function (json) {
                            var str='';
                            console.log(json);
                            $.each(json.list,function (idx,val) {
                                str+='<li class="weui-flex" onclick="openDetail('+val.id+')">' +
                                        '<div class="recruit_info weui-flex__item ">' +
                                        '    <div class="start">' +
                                        '        <h5>'+val.oriCity+'</h5>' +
                                        '        <p>'+val.oriProvince+val.oriCity+val.oriCounty+'</p>' +
                                        '        <i class="add_ico"></i>' +
                                        '    </div>' +
                                        '    <div class="end">' +
                                        '        <h5>'+val.arrCity+'</h5>' +
                                        '        <p>'+val.arrProvince+val.arrCity+val.arrCounty+'</p>' +
                                        '        <i class="add_ico"></i>' +
                                        '    </div>' +
                                        '    <div class="add_line">' +
                                        '        <span></span>' +
                                        '    </div>' +
                                        '</div>' +
                                        '<div class="recruit_date text-right">' +
                                        '    <div class="time">' +
                                        '        <p>'+val.loadTime+'</p>' +
                                        '        <p>提货</p>' +
                                        '        <p class="type">'+val.ton+'吨-'+val.cargoDesc+'</p>'+
                                        '    </div>' +
                                        '    <div class="sum"><p>￥'+val.driverFreight+'</p></div>' +
                                        '</div>' +
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
        tools.navigate('/order/take/'+index)
    }
</script>
<#include "/common/footerWechat.ftl"/>

