<#include "/common/headerWeb.ftl"/>
<#include "/common/navWeb.ftl"/>
<section class="hero-unit-slider no-margin">
    <div id="carousel-hero" class="slick-carousel">
        <div class="carousel-inner" role="listbox">
            <div class="item active">
                <img src="/images/web/source_bg.jpg" alt="Slider Image" width="100%">
            </div>
        </div>
    </div>
</section>
<section class="source_center">
    <div class="container">
        <div class="table_scroll">
            <table class="table-source clearfix">
                <thead>
                <tr>
                    <th width="200px">发货地</th>
                    <th width="200px"> </th>
                    <th width="200px">卸货地</th>
                    <th width="200px">运价</th>
                    <th width="200px">发货时间</th>
                    <th width="200px"> </th>
                </tr>
                </thead>
                <tbody>
                <#if list??&&(list?size>0)>
                    <input value="${count}" class="count hide">
                    <#list list as item>
                    <tr>
                        <td width="200px">${item.oriProvince+item.oriCity+item.oriCounty}</td>
                        <td width="200px"><img src="/images/web/rote_line.png"></td>
                        <td width="200px">${item.arrProvince+item.arrCity+item.arrCounty}</td>
                        <td width="200px">￥${item.driverFreight?string("0.00")}</td>
                        <td width="200px">${item.loadTime?string("yyyy-MM-dd")}</td>
                        <td width="200px">
                            <a class="detail_btn" onclick="openDetail(${item.id})">查看详情</a>
                        </td>
                    </tr>
                    </#list>
                <#else>
                <tr class="data_none">
                    <td colspan="6" width="1200px" ><img src="/images/web/no_listData.png"><br>暂无数据</td>
                </tr>
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
</section>
<script src="/lib/bootstrapPaginator/bootstrap-paginator.min.js"></script>
<script>
    $(function () {

        var totalPages= Math.ceil($(".count").val()/20);
        /*分页*/
        if(totalPages==0){
            $('.table-source tfoot').hide();
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
                    tools.ajaxPost('/api/order/list',{"pageIndex":page-1,"pageSize":"20"},function (json) {
                        var str='';
                        $.each(json.list,function (idx,val) {
                            str+='<tr>' +
                                    '<td width="200px">'+val.oriProvince+val.oriCity+val.oriCounty+'</td>'+
                                    '<td width="200px">--></td>'+
                                    '<td width="200px">'+val.arrProvince+val.arrCity+val.arrCounty+'</td>'+
                                    '<td width="200px">￥'+val.driverFreight+'</td>'+
                                    '<td width="200px">'+val.loadTime+'</td>'+
                                    '<td width="200px"><a class="detail_btn" onclick="openDetail('+val.id+')">货源详情</a></td>'+
                                    '</tr>';
                        });
                        $('.table-source tbody').html(str);
                    })
                }
            };
            $("#example").bootstrapPaginator(options);
        }
    });

    /*打开详情*/
    function openDetail(index) {
        tools.navigate('/order/take/'+index)
    }
</script>
<#include "/common/footerWeb.ftl"/>

