<#include "/common/headerWechat.ftl"/>

<header class="bar bar-nav">
    <h3 class="title">新建地址</h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/owner/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body addressCreate">
        <form class="form" id="addressForm">
            <input value="${address.id}" name="id" class="id hide">
            <div class="item">
                <input id="place" readonly name="place" data-latitude="${address.latitude}" value="${address.province+' '+address.city+' '+address.county}" class="picker" placeholder="请选择地址">
                <label class="arrow_ico" for="shipAddress"><i class="fa fa-angle-down"></i></label>
            </div>
            <div class="item">
                <input name="address" value="${address.address}" placeholder="输入详细地址">
            </div>
            <div class="row">
                <div class="item g-col-5">
                    <input name="contact" value="${address.contact}" placeholder="联系人姓名">
                </div>
                <div class="item g-col-7">
                    <input name="phone" value="${address.phone}" placeholder="联系人电话">
                </div>
            </div>
            <div class="item_submit">
                <a href="javascript:;" class="weui-btn weui-btn_primary saveBtn">保存</a>
            </div>
        </form>

    </div>
</section>
<script src="/lib/wechat/city-picker.js"></script>

<#--百度地图API-->
<script src="http://api.map.baidu.com/api?v=2.0&ak=O0QSY8RvyTGiiOWwZVNkAaqeGS4YfIZC"></script>
<script>
    $(function () {
        $("#addressForm").validate({
            ignore: '',
            rules:{
                place:{
                    required:true
                },
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
                place:{
                    required:'请选择地址'
                },
                address:{
                    required:'请填写具体地址'
                },
                contact:{
                    required:'请填写联系人姓名',
                    isChinese:'请输入中文名称',
                    rangelength:'姓名长度为2到6位'
                },
                phone:{
                    required:'请输入联系人电话',
                    isMobile:'请输入正确的号码'
                }
            }
        });
        var province,city,county;
        $("#place").cityPicker({
            title:"选择地址",
            onChange:function (p,v,d) {
                province=d[0];
                city=d[1];
                county=d[2];
                $("#place-error").hide();
            },
            onClose:function () {

            }
        });
        var disable=false;
        $(".saveBtn").on('click',function () {
            if(disable){
                return false;
            }
            var flag = $("#addressForm").valid();
            if(!flag){
                //没有通过验证
                return;
            }else{
                disable=true;
                var data=tools.hashToJson($('#addressForm').serialize().substring(0).split("&"));
                var arr=data.place.split('+');
                data.province=arr[0];
                data.city=arr[1];
                data.county=arr[2];
                delete data.place;
                var site=data.province+data.city+data.county+data.address;
                getPoint(site).then(computePoint).then(function (result) {
                    data.longitude=result.lng;
                    data.latitude=result.lat;
                    tools.ajaxPut('/api/address/update',data,function (json) {
                        tools.navigate('/address/list');
                    },function () {
                        disable=false;
                    });
                });
            }
        });

        /*获取经纬度*/
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
    })
</script>
<#include "/common/footerWechat.ftl"/>

