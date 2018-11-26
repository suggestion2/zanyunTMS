<#include "/common/driverCenterHeaderWeb.ftl"/>
<input value="${count}" class="count hide">
<input value="${status}" class="status hide">
    <div class="panel">
        <div class="panel-heading">
            <h5 class="panel-title"><i></i>我的订单</h5>
        </div>
        <div class="panel-body">
            <div class="center_tab">
                <ul class="nav nav-tabs">
                    <li <#if status==3>class="active"</#if>><a onclick="openList(3)">待运输</a></li>
                    <li <#if status==2>class="active"</#if>><a onclick="openList(2)">待支付</a></li>
                    <li <#if status==4>class="active"</#if>><a onclick="openList(4)">运输中</a></li>
                    <li <#if status==-1>class="active"</#if>><a onclick="openList(-1)">已取消</a></li>
                    <li <#if status==5>class="active"</#if>><a onclick="openList(5)">已完成</a></li>
                </ul>
                <div class="tab-content no_padding_fr">
                    <div class="table-scroll">
                        <table class="table table-bordered table-hover orderTable">
                            <thead>
                                <tr>
                                    <th>订单编号</th>
                                    <th>装货地址</th>
                                    <th>卸货地址</th>
                                    <th>装货时间</th>
                                    <th>运价</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody>
                            <#if list??>
                                <#if count!=0>
                                    <#list list as item>
                                    <tr>
                                        <td width="200px">${item.number}</td>
                                        <td width="200px">${item.oriProvince+item.oriCity+item.oriCounty}</td>
                                        <td width="200px">${item.arrProvince+item.arrCity+item.arrCounty}</td>
                                        <td width="200px">${item.loadTime?string("yyyy-MM-dd")}</td>
                                        <td width="200px">${item.driverFreight+'元'}</td>
                                        <td width="200px">
                                            <a class="detail_btn" onclick="openDetail(${item.id})">查看详情</a>
                                        </td>
                                    </tr>
                                    </#list>
                                <#else>
                                <tr class="data_none">
                                    <td colspan="6" width="1200px" >暂无数据</td>
                                </tr>
                                </#if>
                            </#if>
                            </tbody>
                            <tfoot>
                            <tr>
                                <td width="1200px" colspan="6" class="text-center">
                                    <ul id="example"></ul>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script src="/lib/bootstrapPaginator/bootstrap-paginator.min.js"></script>
<script>
    $(function () {
        var status=$("input.status").val();
        var orderCount=$(".count").val();
        var totalPages= Math.ceil(orderCount/20);
        if(totalPages==0){
            $('.orderTable tfoot').hide();
            return false;
        }else{
            var options = {
                bootstrapMajorVersion:3,
                currentPage: 1,//当前页
                totalPages: totalPages,//总页数
                numberOfPages: 5,//显示的页数
                shouldShowPage:function(type, page, current){
                    switch(type)
                    {
                        default:
                            return true;
                    }
                },
                tooltipTitles: function (type, page, current) {
                    switch (type) {
                        case "first":
                            return "首页";
                        case "prev":
                            return "上一页";
                        case "next":
                            return "下一页";
                        case "last":
                            return "尾页";
                        case "page":
                            return "第"+page+"页";
                    }
                },
                itemTexts: function(type, page, current) { //修改显示文字
                    switch (type) {
                        case "first":
                            return "首页";
                        case "prev":
                            return "上一页";
                        case "next":
                            return "下一页";
                        case "last":
                            return "末页";
                        case "page":
                            return page;
                    }
                },
                onPageClicked: function (event, originalEvent, type, page) { //异步换页
                    tools.ajaxPost('/api/order/driver/list',{"status":status,"pageIndex":page-1,"pageSize":"10"},function (json) {
                        console.log(json);
                        var str='';
                        $.each(json.list,function (idx,val) {
                            str+='<tr>' +
                                    '<td width="200px">'+val.number+'</td>' +
                                    '<td width="200px">'+val.oriProvince+val.oriCity+val.oriCounty+'</td>' +
                                    '<td width="200px">'+val.arrProvince+val.arrCity+val.arrCounty+'</td>' +
                                    '<td width="200px">'+val.loadTime+'</td>' +
                                    '<td width="200px">'+val.driverFreight+'元</td>' +
                                    '<td width="200px">' +
                                    '<a class="detail_btn" onclick="openDetail('+val.id+')">查看详情</a>' +
                                    '</td>' +
                                    '</tr>';
                        });
                        $('.orderTable tbody').html(str);
                    })
                }
            };
            $("#example").bootstrapPaginator(options);
        }

    });
    function openList(status) {
        tools.navigate('/driver/order/list/'+status);
    }
    /*详情*/
    function openDetail(index) {
        tools.navigate('/driver/order/detail/'+index);
    }
</script>
<#include "/common/centerFooterWeb.ftl"/>