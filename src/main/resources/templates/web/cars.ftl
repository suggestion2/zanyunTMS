<#include "/common/headerWeb.ftl"/>
<#include "/common/navWeb.ftl"/>
<section class="main_section">
    <section class="hero-unit-slider no-margin">
        <div id="carousel-hero" class="slick-carousel">
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <img src="/images/web/cars_bg.jpg" alt="Slider Image" width="100%">
                </div>
            </div>
        </div>
    </section>
    <section class="source_center">
        <div class="container">
            <div class="table_scroll">
                <table class="table-source table-cars">
                    <thead>
                    <tr>
                        <th width="200px">车辆图片</th>
                        <th width="200px">车辆信息</th>
                        <th width="200px">司机姓名</th>
                        <th width="200px">所在地址</th>
                        <th width="200px">驾龄</th>
                        <th width="200px"></th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if carsView.list??&&(carsView.list?size>0)>
                        <input value="${carsView.count}" class="count hide">
                        <#list carsView.list as item>
                        <tr>
                            <td width="200px" class="carImg"><img src="${item.dLicenseUrl?default('/images/web/no_img.png')}" ></td>
                            <td width="200px">${item.model?default('信息不完整')}</td>
                            <td width="200px">${item.name?default('信息不完整')}</td>
                            <td width="200px">${(item.province+item.city+item.county)?default('信息不完整')}</td>
                            <td width="200px">${item.drivingExp?default('信息不完整')}</td>
                            <td width="200px"><a class="detail_btn" onclick="openDetail(${item.id})">车源详情</a></td>
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
</section>
<script src="/lib/bootstrapPaginator/bootstrap-paginator.min.js"></script>
<script>
    $(function () {

        var count=$(".count").val();
        var totalPages=Math.ceil(count/20);
        if(totalPages==0){
            $('.table-source tfoot').hide();
            return false;
        }else{
            page(totalPages);
        }
    });
    
    function page(total) {
        var options = {
            bootstrapMajorVersion:3,
            currentPage: 1,//当前页
            totalPages: total,//总页数
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
                tools.ajaxPost('/api/driver/truckView/list',{"pageIndex":page-1,"pageSize":"20"},function (json) {
                    var str='';
                    $.each(json.list,function (idx,val) {
                        str+='<tr>' +
                                '<td width="200px" class="carImg"><img src="'+val.dLicenseUrl+'"></td>'+
                                '<td width="200px">'+val.model+'</td>'+
                                '<td width="200px">'+val.name+'</td>'+
                                '<td width="200px">'+val.province+val.city+val.county+'</td>'+
                                '<td width="200px">'+val.drivingExp+'</td>'+
                                '<td width="200px"><a class="detail_btn" onclick="openDetail('+val.id+')">车源详情</a></td>'+
                                '</tr>';
                    });
                    $('.table-source tbody').html(str);
                })
            }
        };
        $("#example").bootstrapPaginator(options);
    }
    /*打开详情*/
    function openDetail(index) {
        tools.navigate('/cars/detail/'+index);
    }
</script>
<#include "/common/footerWeb.ftl"/>

