<script type="text/html" class="pageBox" id="tpl_carDemand">
    <div class="page">
        <div class="step1 step2">
            <div class="stepInfo">
                <ul>
                    <li class="active"></li>
                    <li class="active"></li>
                    <li></li>
                </ul>
                <div class="stepIco first active">
                    <p><span>1</span><em style="margin-left: -12px">选择委托人类型</em></p>
                </div>
                <div class="stepIco two active">
                    <p><span>2</span><em style="margin-left: -5px">填写相关信息</em></p>
                </div>
                <div class="stepIco three active">
                    <p><span>3</span><em>订车需求</em></p>
                </div>
                <div class="stepIco last">
                    <p><span>4</span><em>完成订车</em>
                    </p>
                </div>
            </div>
        </div>
        <div class="panel">
            <div class="panel-body">
                <p class="reg_tip text-center">货主向平台提交的委托运输内容即为订车信息。在提交订车信息后,平台将为您匹配车源。为了保障您作为托运人的权利，请谨慎填写托运信息。</p>
                <form class="form-horizontal createForm" role="form" id="order_form">
                    <div class="row">
                        <div class="col-sm-6 shipBox">
                            <div class="form-group">
                                <label class="col-sm-4 control-label"><b>*</b>装货信息：</label>
                                <div class="col-sm-8 inputBox">
                                    <input class="form-control" name="deliverPlace" id="deliverPlace" readonly type="text" placeholder="发货地址" style="cursor: pointer">
                                    <label class="caret" for="deliverPlace"></label>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 disBox">
                            <div class="form-group">
                                <label class="col-sm-4 control-label"><b>*</b>卸货地址：</label>
                                <div class="col-sm-8 inputBox">
                                    <input class="form-control" name="dischargePlace" id="dischargePlace" readonly type="text" placeholder="卸货地址" style="cursor: pointer">
                                    <label class="caret" for="dischargePlace"></label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">收货公司：</label>
                                <div class="col-sm-8">
                                    <div class="dropdown">
                                        <input type="text" class="form-control" name="dischargeCompany" id="dischargeCompany" placeholder="请输入收货公司">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label"><b>*</b>货物类别：</label>
                                <div class="col-sm-8">
                                    <div class="dropdown">
                                        <input type="text" class="form-control dropdown-toggle"  data-toggle="dropdown" name="cargoType" id="cargoType" placeholder="货物类别" readonly style="cursor: pointer">
                                        <label class="caret" for="cargoType"></label>
                                        <ul class="dropdown-menu cargoType-menu" role="menu">
                                            <li><a>普货</a></li>
                                            <li><a>危货</a></li>
                                            <li><a>集装箱</a></li>
                                            <li><a>小件</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <#--车型选择-->
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label"><b>*</b>车型选择：</label>
                                <div class="col-sm-8">
                                    <div class="dropdown">
                                        <input type="text" class="form-control dropdown-toggle"  data-toggle="dropdown" name="transportationModel" id="transportationModel" placeholder="车型选择" readonly style="cursor: pointer">
                                        <label class="caret" for="transportationModel"></label>
                                        <ul class="dropdown-menu transport-menu" role="menu">
                                            <#list list as item>
                                                <li><a>${item}</a></li>
                                            </#list>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label"><b>*</b>货物描述：</label>
                                <div class="col-sm-8">
                                    <input class="form-control" name="cargoDesc" type="text" placeholder="货物描述">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label"><b>*</b>重量：</label>
                                <div class="col-sm-8 item">
                                    <input class="form-control int_r" name="ton" type="text">
                                    <i class="arrange">约</i>
                                    <i class="unit">吨</i>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">体积：</label>
                                <div class="col-sm-8 item">
                                    <input class="form-control int_r" name="cube" type="text" >
                                    <i class="arrange">约</i>
                                    <i class="unit">方</i>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">装货件数：</label>
                                <div class="col-sm-8 item">
                                    <input class="form-control int_r" name="pieces" type="text">
                                    <i class="unit">件</i>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">发货时间：</label>
                                <div class="col-sm-8 inputBox">
                                    <input class="form-control" name="loadTime" id="loadTime" type="text" readonly placeholder="发货时间 " style="cursor: pointer">
                                    <label class="caret" for="loadTime"></label>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">预计卸货时间：</label>
                                <div class="col-sm-8 inputBox">
                                    <input class="form-control" name="landTime" id="landTime" type="text" readonly placeholder="预计卸货时间 " style="cursor: pointer">
                                    <label class="caret" for="landTime"></label>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">货值：</label>
                                <div class="col-sm-8 item">
                                    <input class="form-control int_r" name="cargoValue" type="text" style="padding-right: 36px">
                                    <i class="unit">万元</i>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label"><b>*</b>运费出价：</label>
                                <div class="col-sm-8 item">
                                    <input class="form-control int_r" name="ownerFreight" type="text">
                                    <i class="unit">元</i>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">备注：</label>
                                <div class="col-sm-10 textareaBox">
                                    <textarea name="remarks" placeholder="备注订车要求，选填"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row text-center" style="margin-bottom: 20px;">
                        <label style="font-weight: normal;"><input id="agreement" type="checkbox"> 我已阅读并接受《运输协议书》所有条款。</label> <a href="javascript:;" id="viewAgreement">查看《运输协议书》</a>
                    </div>
                    <div class="item_submit form-group col-sm-12 text-center">

                        <a class="btn btn-danger submitOrder" href="javascript:;">提交认证</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <#--装货联系人信息-->
    <div class="modal fade" id="shipModal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        装货地址
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="addressBox">
                        <div class="address_list">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <#--卸货信息-->
    <div class="modal fade" id="disModal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        卸货地址
                    </h4>
                </div>
                <div class="modal-body">
                    <div class="addressBox">
                        <div class="address_list">

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
            /*判断是否页面刷新或者直接跳转进来的*/
            if(secData==null){
                //刷新了,读取上一页存储的cookie
                if($.cookie('secCookie')==null){
                    tools.msg('所填数据丢失,请重新填写订单',function () {
                        tools.navigate('/order/create');
                    });
                }else{
                    secData=jQuery.parseJSON($.cookie('secCookie'));
                }
            }

            /*验证订单*/
            $("#order_form").validate({
                rules:{
                    deliverPlace:{
                        required:true
                    },
                    dischargePlace:{
                        required:true
                    },
                    cargoType:{
                        required:true
                    },
                    transportationModel:{
                        required:true
                    },
                    cargoDesc:{
                        required:true
                    },
                    ton:{
                        required:true,
                        number:true
                    },
                    cube:{
                        number:true
                    },
                    pieces:{
                        number:true
                    },
                    cargoValue:{
                        number:true
                    },
                    ownerFreight:{
                        required:true,
                        number:true
                    }
                },
                messages:{
                    deliverPlace:{
                        required:'请填写装货信息'
                    },
                    dischargePlace:{
                        required:'请填写卸货信息'
                    },
                    cargoType:{
                        required:'请选择货物类型'
                    },
                    transportationModel:{
                        required:'请选择车型'
                    },
                    cargoDesc:{
                        required:'请填写货物描述'
                    },
                    ton:{
                        required:'请填写吨数',
                        number:'请填写数字'
                    },
                    cube:{
                        number:'请填写数字'
                    },
                    pieces:{
                        number:'请填写数字'
                    },
                    cargoValue:{
                        number:'请填写数字'
                    },
                    ownerFreight:{
                        required:'请填写运费',
                        number:'请填写数字'
                    }
                }
            });

            /*选择装货地址*/
            $("#deliverPlace").on('click',function(){
                $('#shipModal .address_list').html('');
                $('#shipModal').modal('show');
                var shipStr='';
                $.ajax({
                    url:'/api/address/list',
                    type:'GET',
                    dataType:'JSON',
                    contentType:'application/json; charset=utf-8',
                    success:function (json) {
                        if(json.list.length==0){
                            shipStr='<div class="no_data text-center">' +
                                    '    <img src="/images/web/no_listData.png" style="max-width: 200px">' +
                                    '    <div>' +
                                    '        <p class="tip">没有地址簿信息，<a href="/address/list">马上去创建</a>。</p>' +
                                    '    </div>' +
                                    '</div>'
                        }else{
                            $.each(json.list,function (idx,val) {
                                shipStr+='<div class="address_item">' +
                                     '<div class="address-inner">' +
                                     '<div class="title">' +
                                     '<span class="name">'+val.contact+'</span>' +
                                     '<span class="mobile">'+val.phone+'</span>' +
                                     '</div>' +
                                     '<div class="text">' +
                                     '<span class="address" data-province="'+val.province+'" data-city="'+val.city+'" data-county="'+val.county+'" data-address="'+val.address+'" data-longitude="'+val.longitude+'" data-latitude="'+val.latitude+'">'+val.province+val.city+val.county+val.address+'</span>' +
                                     '</div>' +
                                     '<div class="checkLabel"><i class="fa fa-check"></i></div>' +
                                     '</div>' +
                                     '</div>'
                            });
                            shipStr+='<div class="item_submit text-center">' +
                                 '<a href="javascript:;" class="btn btn-danger saveBtn">确认地址</a>' +
                                 '<div class="text-center" style="margin-top: 6px "><a href="/address/list">创建新地址</a></div>'+
                                 '</div>';
                        }
                        $('#shipModal .address_list').prepend(shipStr);
                    },
                    error:function () {
                        tools.msg('获取地址簿失败');
                    }
                });
            });

            /*重新绑定地址选择事件*/
            $(document).on('click','#shipModal .address_list .address_item',function () {
                $(this).addClass('selected').siblings().removeClass('selected');
            });
            /*保存发货地址*/
            var shipData={};
            $(document).on('click','#shipModal .item_submit .saveBtn',function () {
                var shipObj=$('#shipModal .address_item.selected');
                if(shipObj.hasClass('selected')){
                    shipData.loadContact=shipObj.find('.name').text();
                    shipData.loadPhone=shipObj.find('.mobile').text();
                    shipData.oriProvince=shipObj.find('.address').data('province');
                    shipData.oriCity=shipObj.find('.address').data('city');
                    shipData.oriCounty=shipObj.find('.address').data('county');
                    shipData.oriAddress=shipObj.find('.address').data('address');
                    shipData.oriLong=shipObj.find('.address').data('longitude');
                    shipData.oriLat=shipObj.find('.address').data('latitude');
                    $("#deliverPlace").val(shipData.oriProvince+shipData.oriCity+shipData.oriCounty);
                    $('#shipModal').modal('hide')
                }else{
                    tools.msg('请选择发货地址');
                    return false;
                }
            });


            /*选择卸货地址*/
            $("#dischargePlace").on('click',function(){
                $('#disModal .address_list').html('');
                $('#disModal').modal('show');
                var disStr='';
                $.ajax({
                    url:'/api/address/list',
                    type:'GET',
                    dataType:'JSON',
                    contentType:'application/json; charset=utf-8',
                    success:function (json) {
                        if(json.list.length==0){
                            disStr='<div class="no_data text-center">' +
                                    '    <img src="/images/web/no_listData.png" style="max-width: 200px">' +
                                    '    <div>' +
                                    '        <p class="tip">没有地址簿信息，<a href="/address/list">马上去创建</a>。</p>' +
                                    '    </div>' +
                                    '</div>'
                        }else{
                            $.each(json.list,function (idx,val) {
                                disStr+='<div class="address_item">' +
                                        '<div class="address-inner">' +
                                        '<div class="title">' +
                                        '<span class="name">'+val.contact+'</span>' +
                                        '<span class="mobile">'+val.phone+'</span>' +
                                        '</div>' +
                                        '<div class="text">' +
                                        '<span class="address" data-province="'+val.province+'" data-city="'+val.city+'" data-county="'+val.county+'" data-address="'+val.address+'" data-longitude="'+val.longitude+'" data-latitude="'+val.latitude+'">'+val.province+val.city+val.county+val.address+'</span>' +
                                        '</div>' +
                                        '<div class="checkLabel"><i class="fa fa-check"></i></div>' +
                                        '</div>' +
                                        '</div>'
                            });
                            disStr+='<div class="item_submit text-center">' +
                                    '<a href="javascript:;" class="btn btn-danger saveBtn">确认地址</a>' +
                                    '<div class="text-center" style="margin-top: 6px "><a href="/address/list">创建新地址</a></div>'+
                                    '</div>';
                        }
                        $('#disModal .address_list').prepend(disStr);
                    },
                    error:function () {
                        tools.msg('获取地址簿失败');
                    }
                });
            });

            /*重新绑定地址选择事件*/
            $(document).on('click','#disModal .address_list .address_item',function () {
                $(this).addClass('selected').siblings().removeClass('selected');
            });
            /*保存发货地址*/
            var disData={};
            $(document).on('click','#disModal .item_submit .saveBtn',function () {
                var disObj=$('#disModal .address_item.selected');
                if(disObj.hasClass('selected')){
                    disData.dischargeContact=disObj.find('.name').text();
                    disData.dischargePhone=disObj.find('.mobile').text();
                    disData.arrProvince=disObj.find('.address').data('province');
                    disData.arrCity=disObj.find('.address').data('city');
                    disData.arrCounty=disObj.find('.address').data('county');
                    disData.arrAddress=disObj.find('.address').data('address');
                    disData.arrLong=disObj.find('.address').data('longitude');
                    disData.arrLat=disObj.find('.address').data('latitude');
                    $("#dischargePlace").val(disData.arrProvince+disData.arrCity+disData.arrCounty);
                    $('#disModal').modal('hide')
                }else{
                    tools.msg('请选择发货地址');
                    return false;
                }
            });


            /*发货时间*/
            laydate.render({
                elem:'#loadTime'
            });
            laydate.render({
                elem:'#landTime'
            });

            $(".cargoType-menu li a").on('click',function () {
                $("input[name=cargoType]").val($(this).text());
            });

            $(".transport-menu li a").on('click',function () {
                $("input[name=transportationModel]").val($(this).text());
            });

            $("#viewAgreement").on('click',function(){
                layer.open({
                    type:1,
                    title:'运输协议书',
                    area:['1040px','500px'],
                    content:agreementCon()
                })
            });
            function agreementCon(){
                var str='';
                str='<div class="agreementBox"><h4 class="text-center">运输协议书</h4>'+
                        '<div>甲方（承运单位）：</div>'+
                        '<div class="row">'+
                        '<div class="col-sm-4"><label>姓名：</label><input value="" type="text" disabled></div>'+
                        '<div class="col-sm-4"><label>驾驶证号：</label><input value="" type="text" disabled></div>'+
                        '<div class="col-sm-4"><label>身份证号：</label><input value="" type="text" disabled></div>'+
                        '<div class="col-sm-4"><label>车牌号：</label><input value="" type="text" disabled></div>'+
                        '<div class="col-sm-4"><label>车架号：</label><input value="" type="text" disabled></div>'+
                        '<div class="col-sm-4"><label>发动机号：</label><input value="" type="text" disabled></div>'+
                        '<div class="col-sm-12"><label>详细地址： </label><input value="" type="text" disabled style="width: 856px;"></div>'+
                        '</div>'+
                        '<div style="margin-top: 20px;">乙方（托运单位）：</div>'+
                        '<div class="row">'+
                        '<div class="col-sm-12"><label style="width: 140px;">个体姓名或单位名称： </label><input value="" type="text" disabled style="width: 789px;"></div>'+
                        '<div class="col-sm-6"><label style="width: 110px;">托运人身份证号：</label><input value="" type="text" disabled style="width: 333px;"></div>'+
                        '<div class="col-sm-6"><label style="width: 98px;">企业证件编号：</label><input value="" type="text" disabled style="width: 345px;"></div>'+
                        '</div>'+
                        '<div style="margin-top: 20px;">'+
                        '<div style="text-indent: 2em;">为提高货运效益，明确承运、托运双方的权利、义务及责任，本着平等互利、共同发展的原则，经承运、托运双方协商同意，互相查证无异议后方可签订以下协议：</div>'+
                        '<div>1. 货物于<input type="text" value="" disabled style="width:50px">年<input type="text" value="" disabled style="width:50px">月<input type="text" value="" disabled style="width:50px">日前运抵交付单位<input type="text" value="" disabled style="width:180px">查收由<input type="text" value="" disabled style="width:70px">方负责押运。</div>'+
                        '<div>2. 托运货物中严禁夹带易燃、易爆、危险品及禁运物资。</div>'+
                        '<div>3. 运输途中因承运手续不全，车况不良等原因造成的事故，罚款损失由承运单位负责承担，因货物手续不全，包装缺陷等原因造成的事故罚款、损失由承运单位负责承担。</div>'+
                        '<div>4. 本公司只提供为货找车，为车找货的货运信息，不负责其他任何责任。签订协议后，承运托运双方如发生纠纷，可以协商解决，如需发生诉讼的，须在乙方（托运方）所在法院诉讼执行。</div>'+
                        '<div>5. 为了保证运输信息的真实性和保密性，凡是签过本协议的承运方。托运方不得直接联系，如有违反，属于偷窃临沂市赵霞货运公司的商业信息，后果自负。</div>'+
                        '<div>6. 本协议一式三份，承运方、托运方各持一份，货运公司存档一份，承、托运双方签字后生效。</div>'+
                        '</div>'+
                        '<div style="margin: 10px 0;"><table style="width: 100%;">'+
                        '<tr><td>货物名称</td><td>货物价值</td><td>装货数量</td><td>合计车费</td><td>运费结算方式</td></tr>'+
                        '<tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>'+
                        '</table></div>'+
                        '<div class="row" style="margin-top: 50px;"><div class="col-sm-6">甲方：</div><div class="col-sm-6">乙方：</div><div class="col-sm-6">(签字)</div><div class="col-sm-6">(签字)</div></div>'+
                        '</div>';
                return str;
            };
            var disable=false;
            $(".submitOrder").on('click',function () {
                if(disable){
                    return false;
                }
                if(!$('#agreement').is(':checked')){
                  tools.alert('请阅读《运输协议书》，并勾选表示同意！');
                    return false;
                };
                var flag = $("#order_form").valid();
                if(!flag){
                    //没有通过验证
                    return;
                }else{
                    disable=true;
                    var dataform = tools.hashToJson($('#order_form').serialize().substring(0).split("&"));
                    delete dataform.deliverPlace;
                    delete dataform.dischargePlace;
                    var addData=eval('('+(JSON.stringify(shipData)+JSON.stringify(disData)).replace(/}{/,',')+')');
                    var thiData=eval('('+(JSON.stringify(dataform)+JSON.stringify(addData)).replace(/}{/,',')+')');
                    var data = eval('('+(JSON.stringify(thiData)+JSON.stringify(secData)).replace(/}{/,',')+')');
                    data.type=1;
                    tools.ajaxPost('/api/order/create',data,function (json) {
                        disable=false;
                        tools.msg("创建订单成功","1",function () {
                            orderId=json.id;
                            $(".carDemand").hide();
                            $.cookie('orderIdCookie',orderId,{expires:7});
                            tools.navigate('#carSuc');
                        });
                    },function () {
                        disable=false;
                    })
                }
            })
        });
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
</script>
