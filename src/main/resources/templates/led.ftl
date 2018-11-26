<!DOCTYPE html>
<html>
<head>
    <title>led-货源信息</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="/lib/jquery/jquery-2.1.4.js"></script>
    <style type="text/css">
        html,body{width: 100%;height: 100%;}
        body{background: #000;color:red;}
        .kai{font-family: "楷体","楷体_GB2312","KaiTi","KaiTi_GB2312","STKaiti";}
        h1.kai{text-align: center;}
        .box{margin-top: 20px;overflow: hidden;}
        .box .left{width: 80%;float: left;}
        .box .right{width: 20%;float: left;}
        td,th{padding: 0;border-spacing: 0;}
        .table1{width: 100%;border-left:1px solid orange;border-top:1px solid orange;}
        .table1 td,.table1 th{padding:0 10px;height: 30px;line-height: 30px;text-align: center;word-break: keep-all;white-space: nowrap;text-overflow: ellipsis;}
        .table1 td,.table1 th{border-right: 1px solid orange;border-bottom:1px solid orange;}
        .table1 th{color:orange;}
        .rbox{padding: 0 20px 0;}
    </style>
</head>

<body>
    <div style="padding:20px;">
        <h1 class="kai">山东赵霞物流有限公司欢迎您</h1>
        <div class="box">

                <table class="table1"  cellspacing="0">
                    <thead>
                        <tr>
                            <th width="40%">发货地</th>
                            <th width="40%">卸货地</th>
                            <th width="10%">运价(元)</th>
                            <th width="10%">发布时间</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            <div style="text-align: center;padding:20px 0;">当前共有 <span id="gcounts"></span> 条货源信息</div>

                <div class="rbox">
                    <p style="margin-top: 0" id="today"></p>
                </div>

        </div>
    </div>

</body>

</html>
<script type="text/javascript">
    $(function(){
        var mydate = new Date();
        $("#today").html("日期： "+mydate.getFullYear()+" 年 "+mydate.getMonth()+" 月 "+mydate.getDate()+" 日 ");
        var index = 0;
        var pageSize = 10;
        var counts,pages = 0;
        $.ajax({
            type: "POST",
            url: "/api/order/list/public",
            data: JSON.stringify({"pageIndex":index,"pageSize":pageSize}),
            contentType:"application/json",
            success: function(data){
                $("#gcounts").html(data.count);

                var str="";
                $.each(data.list,function(idx,obj){
                    var oriAdd = obj.oriProvince+obj.oriCity+obj.oriCounty;
                    if(oriAdd.length > 12){
                        oriAdd = oriAdd.substr(0,12) + "..."
                    }
                    var arrAdd = obj.arrProvince+obj.arrCity+obj.arrCounty;
                    if(arrAdd.length > 12){
                        arrAdd = arrAdd.substr(0,12) + "..."
                    }
                    str="<tr>"+
                            "<td>"+oriAdd+"</td>"+
                            "<td>"+arrAdd+"</td>"+
                            "<td>"+obj.driverFreight+"</td>"+
                            "<td>"+obj.loadTime+"</td></tr>";
                    $(".table1 tbody").append(str);
                });

                counts = data.count;
                pages = Math.ceil(counts/10);
                rolldata();
            }
        });

        var rolldata = function(){
            setInterval(function () {
                index = index + 1;
                if(index >= pages){
                    index = 0;
                }
                $.ajax({
                    type: "POST",
                    url: "/api/order/list/public",
                    data: JSON.stringify({"pageIndex":index,"pageSize":pageSize}),
                    contentType:"application/json",
                    success:function(data){
                        $(".table1 tbody").html("");
                        var str="";
                        $.each(data.list,function(idx,obj){
                            var oriAdd = obj.oriProvince+obj.oriCity+obj.oriCounty;
                            if(oriAdd.length > 12){
                                oriAdd = oriAdd.substr(0,12) + "..."
                            }
                            var arrAdd = obj.arrProvince+obj.arrCity+obj.arrCounty;
                            if(arrAdd.length > 12){
                                arrAdd = arrAdd.substr(0,12) + "..."
                            }
                            str="<tr>"+
                                    "<td>"+oriAdd+"</td>"+
                                    "<td>"+arrAdd+"</td>"+
                                    "<td>"+obj.driverFreight+"</td>"+
                                    "<td>"+obj.loadTime+"</td></tr>";
                            $(".table1 tbody").append(str);
                        });

                        counts = data.count;
                        pages = Math.ceil(counts/10);
                    }
                });
            },10000);
        }
    })
</script>