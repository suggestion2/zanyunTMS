<!DOCTYPE html>
<html>
<head>
    <title>led-货源信息</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        .table1 td,.table1 th{padding:0 10px;height: 42px;line-height: 42px;text-align: center;word-break: keep-all;white-space: nowrap;text-overflow: ellipsis;}
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
                    <p id="today"></p>
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
        var obj = new XMLHttpRequest();
        obj.open("POST", "/api/order/list/public", true);
        obj.setRequestHeader("Content-type", "application/json");  // 添加http头，发送信息至服务器时内容编码类型
        obj.onreadystatechange = function() {
            if (obj.readyState == 4 && (obj.status == 200 || obj.status == 304)) {  // 304未修改
                var result = JSON.parse(obj.responseText);
            }
        };
        obj.send(data);
        $.ajax({
            type: "POST",
            url: "/api/order/list/public",
            data: JSON.stringify({"pageIndex":index,"pageSize":pageSize}),
            contentType:"application/json",
            success: function(data){
                $("#gcounts").html(data.count);

                var str="";
                $.each(data.list,function(idx,obj){
                    str="<tr>"+
                            "<td>"+obj.oriProvince+obj.oriCity+obj.oriCounty+"</td>"+
                            "<td>"+obj.arrProvince+obj.arrCity+obj.arrCounty+"</td>"+
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
                            str="<tr>"+
                                    "<td>"+obj.oriProvince+obj.oriCity+obj.oriCounty+"</td>"+
                                    "<td>"+obj.arrProvince+obj.arrCity+obj.arrCounty+"</td>"+
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