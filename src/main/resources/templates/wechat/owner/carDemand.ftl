<#--企业-->
<script type="text/html" class="pageBox" id="tpl_carDemand">
    <div class="page">
        <header class="bar bar-nav">
            <h3 class="title">订车需求</h3>
            <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
                <i class="fa fa-angle-left"></i>
            </a>
            <a href="/owner/center" class="userBtn">
                <i class="fa fa-user-circle-o"></i>
            </a>
        </header>
        <section class="content">
            <div class="content_body resLog_box">
                <h4>第三步 提交订车需求</h4>
                <p class="reg_tip">货主向平台提交的委托运输内容即为订车信息。在提交订车信息后,平台将为您匹配车源。为了保障您作为托运人的权利，请谨慎填写托运信息。</p>
                <form id="order_form" class="reg_form">
                    <div class="row choicePlace">
                        <div class="item g-col-6">
                            <input id="deliverPlace" name="deliverPlace" readonly placeholder="发货地址">
                        </div>
                        <i class="point"></i>
                        <div class="item g-col-6">
                            <input id="dischargePlace" name="dischargePlace" readonly placeholder="卸货地址">
                        </div>
                    </div>
                    <div class="item">
                        <input name="dischargeCompany" type="text" placeholder="收货公司">
                    </div>
                    <div class="row">
                        <div class="item g-col-12">
                            <input placeholder="货物类别" readonly class="picker" name="cargoType" id="cargoType">
                            <label class="arrow_ico" for="cargoType"><i class="fa fa-angle-down"></i></label>
                        </div>
                    </div>
                    <div class="item">
                        <input name="cargoDesc" type="text" placeholder="货物描述">
                    </div>
                    <div class="row">
                        <div class="item g-col-12">
                            <input placeholder="车型选择" readonly class="picker" name="transportationModel" id="transportationModel">
                            <label class="arrow_ico" for="transportationModel"><i class="fa fa-angle-down"></i></label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="item g-col-6">
                            <input name="ton" type="number" class="int_r">
                            <i class="arrange">约</i>
                            <i class="unit">吨</i>
                        </div>
                        <div class="item g-col-6">
                            <input name="cube" type="number" class="int_r">
                            <i class="arrange">约</i>
                            <i class="unit">方</i>
                        </div>
                    </div>
                    <div class="row">
                        <div class="item g-col-12">
                            <input name="pieces" type="number" class="int_r">
                            <i class="arrange">装货</i>
                            <i class="unit">件</i>
                        </div>
                    </div>
                    <div class="row">
                        <div class="item g-col-12">
                            <input name="cargoValue" type="number" class="int_r2">
                            <i class="arrange">货值</i>
                            <i class="unit">万元</i>
                        </div>
                    </div>
                    <div class="row">
                        <div class="item g-col-12">
                            <input placeholder="预计发货时间" readonly class="picker" name="loadTime" id="loadTime">
                            <label class="arrow_ico"><i class="fa fa-angle-down"></i></label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="item g-col-12">
                            <input placeholder="预计卸货时间" readonly class="picker" name="landTime" id="landTime">
                            <label class="arrow_ico"><i class="fa fa-angle-down"></i></label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="item g-col-12">
                            <input name="ownerFreight" type="number" class="int_r">
                            <i class="arrange">运费出价</i>
                            <i class="unit">元</i>
                        </div>
                    </div>
                    <div class="item">
                        <textarea name="remarks" placeholder="备注订车要求，选填"></textarea>
                    </div>
                    <div class="row text-center weui-cells_checkbox ydc-check" style="margin-bottom: 20px;">
                        <label style="font-weight: normal;" class="weui-cell weui-check__label"><div class="weui-cell__hd"><input id="agreement" type="checkbox" class="weui-check"><i class="weui-icon-checked"></i></div><div class="weui-cell_bd"><p> 阅读并接受《运输协议书》所有条款。</p></div></label>
                        <div style="text-align: left;padding-left: 40px;"><a href="javascript:;" id="viewAgreement">查看《运输协议书》</a></div>
                    </div>
                    <div class="item_submit">
                        <a href="javascript:;" class="weui-btn weui-btn_primary submitOrder">提交订车需求</a>
                    </div>
                </form>
            </div>
        </section>
    </div>
    <#--装货地址信息-->
    <div id="shipmentInfo" class="weui-popup-container">
        <div class="weui-popup-overlay"></div>
        <div class="weui-popup__modal">
            <i class="closeBtn close-popup"></i>
            <div class="address_box resLog_box">
                <form id="shipment_form" class="reg_form">
                    <div class="ad_t text-center">
                        <h5>装货地址</h5>
                    </div>
                    <div class="addressBox">
                        <div class="address_list">

                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <#--卸货地址信息-->
    <div id="dischargeInfo" class="weui-popup-container">
        <div class="weui-popup-overlay"></div>
        <div class="weui-popup__modal">
            <i class="closeBtn close-popup"></i>
            <div class="address_box resLog_box">
                <form id="discharge_form" class="reg_form">
                    <div class="ad_t text-center">
                        <h5>卸货地址</h5>
                    </div>
                    <div class="addressBox">
                        <div class="address_list">

                        </div>
                    </div>
                    <#--<div class="ad_b">
                        <div class="item">
                            <input id="disAddress"  readonly name="disAddress" class="picker" placeholder="请选择卸货地址">
                            <label class="arrow_ico" for="disAddress"><i class="fa fa-angle-down"></i></label>
                        </div>
                        <div class="item">
                            <input name="arrAddress" placeholder="请输入详细卸货地址">
                            &lt;#&ndash;<input id="arrAddress" name="arrAddress" class="picker" placeholder="请选择卸货地区中转站" readonly>
                            <label class="arrow_ico" for="arrAddress"><i class="fa fa-angle-down"></i></label>&ndash;&gt;
                        </div>
                        <div class="row">
                            <div class="item g-col-5">
                                <input name="dischargeContact" placeholder="联系人姓名">
                            </div>
                            <div class="item g-col-7">
                                <input name="dischargePhone" placeholder="联系人电话">
                            </div>
                        </div>
                        <div class="item_submit">
                            <a href="javascript:;" class="weui-btn weui-btn_primary saveBtn">保存</a>
                        </div>
                    </div>-->
                </form>
            </div>
        </div>
    </div>

    <div id="showAgreement" class="weui-popup__container">
        <div class="weui-popup__overlay" style="opacity: 1;"></div>
        <div class="weui-popup__modal">
            <div class="agreementBox">
                <h4 class="text-center">运输协议书</h4>
                <div class="row">甲方（承运单位）：</div>
                <div class="row">
                    <div class="g-col-12"><label>姓名：</label><input value="" type="text" disabled></div>
                    <div class="g-col-12"><label>驾驶证号：</label><input value="" type="text" disabled></div>
                    <div class="g-col-12"><label>身份证号：</label><input value="" type="text" disabled></div>
                    <div class="g-col-12"><label>车牌号：</label><input value="" type="text" disabled></div>
                    <div class="g-col-12"><label>车架号：</label><input value="" type="text" disabled></div>
                    <div class="g-col-12"><label>发动机号：</label><input value="" type="text" disabled></div>
                    <div class="g-col-12"><label>详细地址： </label><input value="" type="text" disabled></div>
                </div>
                <div style="margin-top: 20px;" class="row">乙方（托运单位）：</div>
                <div class="row">
                    <div class="col-sm-12"><label style="width: 140px;">个体姓名或单位名称： </label><input value="" type="text" disabled style="width: 100%"></div>
                    <div class="col-sm-6"><label style="width: 130px;">托运人身份证号：</label><input value="" type="text" disabled style="width: 100%"></div>
                    <div class="col-sm-6"><label style="width: 130px;">企业证件编号：</label><input value="" type="text" disabled style="width: 100%"></div>
                </div>
                <div style="margin-top: 20px;" class="row">
                    <div style="text-indent: 2em;">为提高货运效益，明确承运、托运双方的权利、义务及责任，本着平等互利、共同发展的原则，经承运、托运双方协商同意，互相查证无异议后方可签订以下协议：</div>
                    <div>1. 货物于<input type="text" value="" disabled style="width:50px">年<input type="text" value="" disabled style="width:50px">月<input type="text" value="" disabled style="width:50px">日前运抵交付单位<input type="text" value="" disabled style="width:180px">查收由<input type="text" value="" disabled style="width:70px">方负责押运。</div>
                    <div>2. 托运货物中严禁夹带易燃、易爆、危险品及禁运物资。</div>
                    <div>3. 运输途中因承运手续不全，车况不良等原因造成的事故，罚款损失由承运单位负责承担，因货物手续不全，包装缺陷等原因造成的事故罚款、损失由承运单位负责承担。</div>
                    <div>4. 本公司只提供为货找车，为车找货的货运信息，不负责其他任何责任。签订协议后，承运托运双方如发生纠纷，可以协商解决，如需发生诉讼的，须在乙方（托运方）所在法院诉讼执行。</div>
                    <div>5. 为了保证运输信息的真实性和保密性，凡是签过本协议的承运方。托运方不得直接联系，如有违反，属于偷窃临沂市赵霞货运公司的商业信息，后果自负。</div>
                    <div>6. 本协议一式三份，承运方、托运方各持一份，货运公司存档一份，承、托运双方签字后生效。</div>
                </div>
                <div style="margin: 10px 0;" class="row"><table style="width: 100%;">
                    <tr><td>货物名称</td><td>货物价值</td><td>装货数量</td><td>合计车费</td><td>运费结算方式</td></tr>
                    <tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
                    </table></div>
                <div class="row" style="margin-top: 50px;">
                    <div class="g-col-6">甲方：</div><div class="g-col-6">乙方：</div>
                    <div class="g-col-6">(签字)</div><div class="g-col-6">(签字)</div>
                </div>
                <div class="row">
                    <a href="javascript:;" class="weui-btn weui-btn_primary close-popup" style="margin-top: 40px;">我已阅读</a>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(function () {
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

            /*判断是否页面刷新或者直接跳转进来的*/
            if(secData==null){
                //刷新了,读取上一页存储的cookie
                if($.cookie('secCookie')==null){
                    $.toast('所填数据丢失,请重新填写订单',1000,function () {
                        tools.navigate('/order/create');
                    });
                }else{
                    secData=jQuery.parseJSON($.cookie('secCookie'));
                }
            }

            /*装货信息*/
            $("#deliverPlace").on('click',function () {
                $('#shipment_form .address_list').html('');
                $("#shipmentInfo").popup();
                var str='';
                /*获取地址簿*/
                $.ajax({
                    url:'/api/address/list',
                    type:'GET',
                    dataType:'JSON',
                    contentType:'application/json; charset=utf-8',
                    success:function (json) {
                        if(json.list.length==0){
                            str='<div class="no_data text-center">' +
                                '    <img src="/images/wechat/no_order.png">' +
                                '    <div>' +
                                '        <p class="tip">没有地址簿信息，<a href="/address/create">马上去创建</a>。</p>' +
                                '    </div>' +
                                '</div>'
                        }else{
                            $.each(json.list,function (idx,val) {
                                str+='<div class="address_item">' +
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
                            str+='<div class="item_submit" style="margin-bottom: 16px">' +
                                 '<a href="javascript:;" class="weui-btn weui-btn_primary saveBtn">确定</a>' +
                                 '<div class="text-center" style="margin-top: 6px '+((json.list.length<10)?(''):(';display:none'))+'"><a href="/address/create">创建新地址</a></div>' +
                                 '</div>';
                        }
                        $('#shipment_form .address_list').prepend(str);
                    },
                    error:function (res) {
                        $.toast('获取地址簿失败！','text');
                    }
                })
            });
            /*绑定选择发货地址*/
            $(document).on('click','#shipmentInfo .address_item',function () {
                $(this).addClass('selected').siblings().removeClass('selected');
            });
            /*保存发货地址*/
            var shipData={};
            $(document).on('click','#shipmentInfo .item_submit .saveBtn',function () {
                var shipObj=$('#shipmentInfo .address_item.selected');
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
                    $.closePopup();
                }else{
                    $.toast('请选择发货地址');
                    return false;
                }
            });


            /*卸货信息*/
            $("#dischargePlace").on('click',function () {
                $('#discharge_form .address_list').html('');
                $("#dischargeInfo").popup();
                var disStr='';
                /*获取地址簿*/
                $.ajax({
                    url:'/api/address/list',
                    type:'GET',
                    dataType:'JSON',
                    contentType:'application/json; charset=utf-8',
                    success:function (json) {
                        if(json.list.length==0){
                            disStr='<div class="no_data text-center">' +
                                    '    <img src="/images/wechat/no_order.png">' +
                                    '    <div>' +
                                    '        <p class="tip">没有地址簿信息，<a href="/address/create">马上去创建</a>。</p>' +
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
                            disStr+='<div class="item_submit" style="margin-bottom: 16px">' +
                                    '<a href="javascript:;" class="weui-btn weui-btn_primary saveBtn">确定</a>' +
                                    '<div class="text-center" style="margin-top: 6px '+((json.list.length<10)?(''):(';display:none'))+'"><a href="/address/create">创建新地址</a></div>' +
                                    '</div>';
                        }
                        $('#discharge_form .address_list').prepend(disStr);
                    },
                    error:function (res) {
                        $.toast('获取地址簿失败！','text');
                    }
                })
            });

            /*绑定选择发货地址*/
            $(document).on('click','#dischargeInfo .address_item',function () {
                $(this).addClass('selected').siblings().removeClass('selected');
            });
            /*保存发货地址*/
            var disData={};
            $(document).on('click','#dischargeInfo .item_submit .saveBtn',function () {
                var disObj=$('#dischargeInfo .address_item.selected');
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
                    $.closePopup();
                }else{
                    $.toast('请选择发货地址');
                    return false;
                }
            });


            /*清空表单*/
            $(".clearBtn").on('click',function () {
                var formId=$(this).next().find('form').attr('id');
                tools.clearFrom(formId);
            });

            /*货物类别*/
            $("#cargoType").picker({
                title:"选择货物类别",
                cols:[
                    {
                        textAlign:'center',
                        values:['普货','危货','集装箱','小件']
                    }
                ]
            });

            /*车型选择*/
            $("#transportationModel").picker({
                title:'选择车型',
                cols: [
                    {
                        textAlign: 'center',
                        values: getCarModel()
                    }
                ],
            });

            /*发货时间*/
            var myDate = new Date;
            var year = myDate.getFullYear();//获取当前年
            var mouth = myDate.getMonth()+1;//获取当前月
            var date = myDate.getDate();//获取当前日
            var today=year+'-'+mouth+'-'+date;
            $("#loadTime").calendar({
                minDate:today
            });

            /*卸货时间*/
            $("#landTime").calendar({
                minDate:today
            });
            $("#viewAgreement").on("click",function(){
                $("#showAgreement").popup();
            });

            /*提交订车需求*/
            $(".submitOrder").on('click',function () {
                if(!$('#agreement').is(':checked')){
                    $.alert('请阅读《运输协议书》，并勾选表示同意！','重要提示');
                    return false;
                };
                var flag = $("#order_form").valid();
                if(!flag){
                    //没有通过验证
                    return;
                }else{
                    var dataform = tools.hashToJson($('#order_form').serialize().substring(0).split("&"));
                    delete dataform.deliverPlace;
                    delete dataform.dischargePlace;
                    var addData=eval('('+(JSON.stringify(shipData)+JSON.stringify(disData)).replace(/}{/,',')+')');
                    var thiData=eval('('+(JSON.stringify(dataform)+JSON.stringify(addData)).replace(/}{/,',')+')');
                    var data = eval('('+(JSON.stringify(thiData)+JSON.stringify(secData)).replace(/}{/,',')+')');
                    //console.log(data);
                    data.type=1;
                    tools.ajaxPost('/api/order/create',data,function (json) {
                        $.toast("创建订单成功",1000,function () {
                            tools.navigate("/owner/order/detail/" + json.id);
                        });
                    })
                }
            })
        });

       /* /!*获取经纬度*!/
        function getPoint(siteString) {
            return new Promise(function(resolve) {
                var myGeo = new BMap.Geocoder();
                myGeo.getPoint(siteString, function(point){
                    if (point) {
                        resolve(point);
                    }else{
                        $.toast("您选择地址解析没有结果，请重新填写！","forbidden");
                    }
                })
            });
        }
        /!*返回经纬度*!/
        function computePoint(point) {
            return point;
        }*/
        /*获取车型*/
        function getCarModel() {
            var carArr=[];
            $.ajax({
                type: "GET",
                async:false,
                url: '/api/transportationParams',
                contentType: APPLICATION_JSON,
                success:function (json) {
                    carArr=json.list;
                }
            });
            return carArr;
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
</script>
