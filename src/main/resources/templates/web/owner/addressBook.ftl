<#include "/common/ownerCenterHeaderWeb.ftl"/>
    <div class="panel">
        <div class="panel-heading clearfix">
            <h5 class="panel-title pull-left"><i></i>地址簿</h5>
            <a class="pull-right" onclick="add()" style="font-size: 16px"><i></i>添加地址</a>
        </div>
        <div class="panel-heading">
            <div class="table-scroll">
                <table class="table table-bordered table-hover orderTable">
                    <thead>
                    <tr>
                        <th>地址</th>
                        <th>联系人</th>
                        <th>电话</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                        <#if list??&&(list?size>0)>
                            <#list list as item>
                                <tr data-id="${item.id}">
                                    <td width="200px" data-longitude="${item.longitude}" data-latitude="${item.latitude}" data-province="${item.province}" data-city="${item.city}" data-county="${item.county}" data-address="${item.address}">${item.province + item.city + item.county + item.address}</td>
                                    <td width="200px" data-contact="${item.contact}">${item.contact}</td>
                                    <td width="200px" data-phone="${item.phone}">${item.phone}</td>
                                    <td width="200px">
                                        <a class="detail_btn" onclick="edit(${item.id})">编辑</a>
                                        <a class="detail_btn" onclick="deleteAddress(${item.id})">删除</a>
                                    </td>
                                </tr>
                            </#list>
                        <#else>
                            <tr class="data_none">
                                <td colspan="6" width="1200px" >暂无数据</td>
                            </tr>
                        </#if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
<#--地址选择器 -->
<script src="/lib/citypicker/distpicker.data.js"></script>
<script src="/lib/citypicker/distpicker.js"></script>
<#--百度地图API-->
<script src="http://api.map.baidu.com/api?v=2.0&ak=O0QSY8RvyTGiiOWwZVNkAaqeGS4YfIZC"></script>

<script>
    function add() {
        layer.open({
            type: 1,
            title:'新增地址',
            area:['600px'],
            shadeClose:true,
            content:'<form class="form-horizontal addressFrom" role="form" id="addAddressForm">' +
            '<div class="form-group">' +
            '<label class="col-sm-3 control-label"><b>*</b>地址：</label>' +
            '<div class="col-sm-8 addressBox" id="addAddress">' +
            '<div class="col-xs-4">' +
            '<select class="form-control" id="province" name="province"></select>' +
            '</div>' +
            '<div class="col-xs-4">' +
            '<select class="form-control" id="city" name="city" ></select>' +
            '</div>' +
            '<div class="col-xs-4">' +
            '<select class="form-control" id="county" name="county"></select>' +
            '</div>' +
            '</div>' +
            '</div>' +
            '<div class="form-group">' +
            '<label class="col-sm-3 control-label"><b>*</b>详细地址：</label>' +
            '<div class="col-sm-8">' +
            '<input class="form-control" name="address" type="text" placeholder="详细地址">' +
            '</div>' +
            '</div>' +
            '<div class="form-group">' +
            '<label class="col-sm-3 control-label"><b>*</b>联系人姓名：</label>' +
            '<div class="col-sm-8">' +
            '<input class="form-control" name="contact" type="text"  placeholder="联系人姓名">' +
            '</div>' +
            '</div>' +
            '<div class="form-group">' +
            '<label class="col-sm-3 control-label"><b>*</b>联系人电话：</label>' +
            '<div class="col-sm-8">' +
            '<input class="form-control" name="phone" type="text" placeholder="联系人电话">' +
            '</div>' +
            '</div>' +
            '<div class="item_submit text-center">' +
            '<a href="javascript:;" class="btn btn-danger addressAddBtn">保存地址</a>' +
            '</div>' +
            '</form>',
            success:function () {
                $("#addAddressForm").validate({
                    rules:{
                        address:{
                            required:true
                        },
                        contact:{
                            required:true,
                            isChinese:true,
                            rangelength:[2,6]
                        },
                        phone:{
                            required:true,
                            isMobile:true
                        }
                    },
                    messages:{
                        address:{
                            required:'请填写详细地址'
                        },
                        contact:{
                            required:'请填写姓名',
                            isChinese:'请输入中文名称',
                            rangelength:'姓名长度为2到6位'
                        },
                        phone:{
                            required:'请输入联系电话',
                            isMobile:'请输入正确的号码'
                        }
                    }
                });

                $('#addAddress').distpicker({
                    placeholder: false,
                    autoSelect: true
                });

                /*更新信息*/
                $('.addressAddBtn').on('click',function () {
                    var flag = $("#addAddressForm").valid();
                    if(!flag){
                        //没有通过验证
                        return;
                    }else{
                        var data=tools.hashToJson($('#addAddressForm').serialize().substring(0).split("&"));
                        var site=data.province+data.city+data.county+data.address;
                        getPoint(site).then(computePoint).then(function (result) {
                            data.longitude=result.lng;
                            data.latitude=result.lat;
                            tools.ajaxPost('/api/address/create',data,function (json) {
                                tools.navigate('/address/list');
                            });
                        });
                    }
                })
            }
        });
    }

    function edit(id) {
        var obj=$('[data-id='+id+'] td');
        var addressJson={};
        obj.each(function () {
            $.each($(this).data(),function (idv,val) {
                addressJson[idv]=val;
            })
        });
        layer.open({
            type: 1,
            title:'编辑地址',
            area:['600px'],
            shadeClose:true,
            content:'<form class="form-horizontal addressFrom" role="form" id="updateAddress">' +
                    '<div class="form-group">' +
                    '<label class="col-sm-3 control-label"><b>*</b>地址：</label>' +
                    '<div class="col-sm-8 addressBox" id="updateAddress">' +
                    '<div class="col-xs-4">' +
                    '<select class="form-control" id="province" name="province" data-province="'+addressJson.province+'"></select>' +
                    '</div>' +
                    '<div class="col-xs-4">' +
                    '<select class="form-control" id="city" name="city" data-city="'+addressJson.city+'"></select>' +
                    '</div>' +
                    '<div class="col-xs-4">' +
                    '<select class="form-control" id="county" name="county" data-county="'+addressJson.county+'"></select>' +
                    '</div>' +
                    '</div>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label class="col-sm-3 control-label"><b>*</b>详细地址：</label>' +
                    '<div class="col-sm-8">' +
                    '<input class="form-control" name="address" type="text" value="'+addressJson.address+'" placeholder="详细地址">' +
                    '</div>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label class="col-sm-3 control-label"><b>*</b>联系人姓名：</label>' +
                    '<div class="col-sm-8">' +
                    '<input class="form-control" name="contact" type="text" value="'+addressJson.contact+'" placeholder="联系人姓名">' +
                    '</div>' +
                    '</div>' +
                    '<div class="form-group">' +
                    '<label class="col-sm-3 control-label"><b>*</b>联系人电话：</label>' +
                    '<div class="col-sm-8">' +
                    '<input class="form-control" name="phone" type="text" value="'+addressJson.phone+'" placeholder="联系人电话">' +
                    '</div>' +
                    '</div>' +
                    '<div class="item_submit text-center">' +
                    '<a href="javascript:;" class="btn btn-danger addressUpdateBtn">保存地址</a>' +
                    '</div>' +
                    '</form>',
            success:function () {
                $("#updateAddress").validate({
                    rules:{
                        address:{
                            required:true
                        },
                        contact:{
                            required:true,
                            isChinese:true,
                            rangelength:[2,6]
                        },
                        phone:{
                            required:true,
                            isMobile:true
                        }
                    },
                    messages:{
                        address:{
                            required:'请填写详细地址'
                        },
                        contact:{
                            required:'请填写姓名',
                            isChinese:'请输入中文名称',
                            rangelength:'姓名长度为2到6位'
                        },
                        phone:{
                            required:'请输入联系电话',
                            isMobile:'请输入正确的号码'
                        }
                    }
                });

                $('#updateAddress').distpicker({
                    placeholder: false,
                    autoSelect: true
                });

                /*更新信息*/
                $('.addressUpdateBtn').on('click',function () {
                    var flag = $("#updateAddress").valid();
                    if(!flag){
                        //没有通过验证
                        return;
                    }else{
                        var data=tools.hashToJson($('#updateAddress').serialize().substring(0).split("&"));
                        data.id=id;
                        var site=data.province+data.city+data.county+data.address;
                        getPoint(site).then(computePoint).then(function (result) {
                            data.longitude=result.lng;
                            data.latitude=result.lat;
                            tools.ajaxPut('/api/address/update',data,function (json) {
                                tools.navigate('/address/list');
                            });
                        });
                    }
                })

            }
        });
    }

    function deleteAddress(id) {
        tools.confirm("确定删除该地址？", function() {
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

    /*获取经纬度*/
    function getPoint(siteString) {
        return new Promise(function(resolve) {
            var myGeo = new BMap.Geocoder();
            myGeo.getPoint(siteString, function(point){
                if (point) {
                    resolve(point);
                }else{
                    $.msg("您选择地址解析没有结果，请重新填写！");
                }
            })
        });
    }
    /*返回经纬度*/
    function computePoint(point) {
        return point;
    }

    /*验证中文字符*/
    jQuery.validator.addMethod("isChinese", function(value, element) {
        return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);
    }, "只能包含中文字符。");
    // 手机号码验证
    jQuery.validator.addMethod("isMobile", function(value, element) {
        var length = value.length;
        var mobile = /^(13[0-9]{9})|(18[0-9]{9})|(14[0-9]{9})|(17[0-9]{9})|(15[0-9]{9})$/;
        return this.optional(element) || (length == 11 && mobile.test(value));
    }, "请正确填写您的手机号码");
</script>
<#include "/common/centerFooterWeb.ftl"/>

