<#include "/common/headerWechat.ftl"/>
<input value="${driver.id}" class="driverId hide">
<input value="${driver.status}" class="driverStatus hide">
<header class="bar bar-nav ">
    <h3 class="title">验证驾驶和运营资质</h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/driver/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body resLog_box">
        <h4>第二步 验证驾驶和运营资质</h4>
        <p class="reg_tip">为了保障您作为承运人的合法权利，请填写并提交<a onclick="viewDemo()">B2类驾驶员</a>资质信息。在通过审核后，您的公开个人资料将仅显示姓氏。</p>
        <form id="reg_form_2" class="reg_form">
            <div class="row">
                <div class="item g-col-7">
                    <input name="name" placeholder="请输入真实姓名" <#if (driver.name??)&&(driver.name!='')>value="${driver.name}" disabled</#if>>
                </div>
                <div class="item g-col-5">
                    <input name="gender" placeholder="性别" <#if (driver.gender??)&&(driver.gender!='')>value="${driver.gender}" disabled</#if> class="picker" type="text" id="gender">
                    <label class="arrow_ico" for="gender"><i class="fa fa-angle-down"></i></label>
                </div>
            </div>
            <div class="item">
                <input name="licenseNum" type="text" placeholder="B2证-18位驾驶证编号" <#if (driver.licenseNum??)&&(driver.licenseNum!='')>value="${driver.licenseNum}" disabled</#if>>
            </div>
            <div class="row">
                <div class="item g-col-7">
                    <input name="licenseEffTime" <#if (driver.licenseEffTime??)&&(driver.licenseEffTime?string('yyyy-MM-dd')!='')>value="${driver.licenseEffTime?string('yyyy-MM-dd')}" disabled</#if>  placeholder="初次领证日期" class="picker" type="text" id="licenseEffTime">
                    <label class="arrow_ico" for="licenseEffTime"><i class="fa fa-angle-down"></i></label>
                </div>
                <div class="item g-col-5">
                    <input name="drivingExp" placeholder="驾龄" <#if (driver.drivingExp??)&&(driver.drivingExp!='')>value="${driver.drivingExp}" disabled</#if> class="picker" type="text" id="drivingExp">
                    <label class="arrow_ico" for="drivingExp"><i class="fa fa-angle-down"></i></label>
                </div>
            </div>
            <div class="row">
                <div class="item g-col-7">
                    <input name="licenseStartTime" <#if (driver.licenseStartTime??)&&(driver.licenseStartTime?string('yyyy-MM-dd')!='')>value="${driver.licenseStartTime?string('yyyy-MM-dd')}" disabled</#if> placeholder="有效起始日期"  class="picker" type="text" id="licenseStartTime">
                    <label class="arrow_ico" for="licenseStartTime"><i class="fa fa-angle-down"></i></label>
                </div>
                <div class="item g-col-5">
                    <input name="expiredTime" <#if (driver.expiredTime??)&&(driver.expiredTime!='')>value="${driver.expiredTime}" disabled</#if>  placeholder="有效期限" class="picker" type="text" id="expiredTime">
                    <label class="arrow_ico" for="expiredTime"><i class="fa fa-angle-down"></i></label>
                </div>
            </div>
            <div class="item">
                <input id="driverPlace" readonly name="driverPlace" class="picker" <#if (driver.city??&&driver.province??&&driver.county??)&&((driver.city!='')&&(driver.province!='')&&(driver.county!=''))>value="${driver.province+' '+driver.city+' '+driver.county}" disabled</#if> placeholder="请选择常驻地址">
                <label class="arrow_ico" for="driverPlace" style="right: 13px;"><i class="fa fa-angle-down"></i></label>
            </div>
            <div class="item_title text-center" style="margin-top: 16px;">专线1（选填）</div>
            <div class="item">
                <input id="startPlace" readonly name="startPlace" class="picker" <#if (driver.taskCity1??&&driver.taskProvince1??&&driver.taskCounty1??)&&((driver.taskCity1!='')&&(driver.taskProvince1!='')&&(driver.taskCounty1!=''))>value="${driver.taskProvince1+' '+driver.taskCity1+' '+driver.taskCounty1}" disabled</#if> placeholder="专线1起点">
                <label class="arrow_ico" for="startPlace" style="right: 13px;"><i class="fa fa-angle-down"></i></label>
            </div>
            <div class="item">
                <input id="endPlace" readonly name="endPlace" class="picker" <#if (driver.taskCity2??&&driver.taskProvince2??&&driver.taskCounty2??)&&((driver.taskCity2!='')&&(driver.taskProvince2!='')&&(driver.taskCounty2!=''))>value="${driver.taskProvince2+' '+driver.taskCity2+' '+driver.taskCounty2}" disabled</#if> placeholder="专线1终点">
                <label class="arrow_ico" for="endPlace" style="right: 13px;"><i class="fa fa-angle-down"></i></label>
            </div>
            <div class="item_title text-center" style="margin-top: 16px;">专线2（选填）</div>
            <div class="item">
                <input id="startPlace1" readonly name="startPlace1" class="picker" <#if (driver.taskCity3??&&driver.taskProvince3??&&driver.taskCounty3??)&&((driver.taskCity3!='')&&(driver.taskProvince3!='')&&(driver.taskCounty3!=''))>value="${driver.taskProvince3+' '+driver.taskCity3+' '+driver.taskCounty3}" disabled</#if> placeholder="专线2起点">
                <label class="arrow_ico" for="startPlace1" style="right: 13px;"><i class="fa fa-angle-down"></i></label>
            </div>
            <div class="item">
                <input id="endPlace1" readonly name="endPlace2" class="picker" <#if (driver.taskCity4??&&driver.taskProvince4??&&driver.taskCounty4??)&&((driver.taskCity4!='')&&(driver.taskProvince4!='')&&(driver.taskCounty4!=''))>value="${driver.taskProvince4+' '+driver.taskCity4+' '+driver.taskCounty4}" disabled</#if> placeholder="专线2终点">
                <label class="arrow_ico" for="endPlace2" style="right: 13px;"><i class="fa fa-angle-down"></i></label>
            </div>

            <div class="item" index="0">
                <p class="uploadTip"><i class="fa fa-check-circle"></i>驾驶、行驶证照片已添加，点击<a class="viewImg">查看大图</a></p>
                <label class="weui-btn weui-btn_primary uploadBtn" for="licenseUrl"><#if (driver.licenseUrl??)&&(driver.licenseUrl!='')>驾驶、行驶证证照片已通过<#else>上传驾驶、行驶证照片</#if></label>
                <input type="file" name="file" accept="image/*" capture="camera" <#if (driver.licenseUrl??)&&(driver.licenseUrl!='')>disabled</#if> class="hide fileupload" id="licenseUrl"  index="0">
                <input type="text" name="licenseUrl" class="hide" <#if (driver.licenseUrl??)&&(driver.licenseUrl!='')>value="${driver.licenseUrl}"</#if>>
                <img class="target hide" <#if (driver.licenseUrl??)&&(driver.licenseUrl!='')>src="${driver.licenseUrl}"</#if> >
            </div>
            <div class="item">
                <input name="engineNum" placeholder="输入发动机号" <#if (driver.engineNum??)&&(driver.engineNum!='')>value="${driver.engineNum}" disabled</#if> >
            </div>
            <div class="item">
                <input name="licensePlate" placeholder="输入车牌号" <#if (driver.licensePlate??)&&(driver.licensePlate!='')>value="${driver.licensePlate}" disabled</#if>>
            </div>
            <div class="item">
                <input name="dLicenseNum" placeholder="输入车辆识别代号" <#if (driver.dLicenseNum??)&&(driver.dLicenseNum!='')>value="${driver.dLicenseNum}" disabled</#if>>
            </div>
            <div class="item">
                <input name="model" id="model" class="picker" <#if (driver.model??)&&(driver.model!='')>value="${driver.model}" disabled</#if> placeholder="车型">
                <label class="arrow_ico" for="model" style="right: 13px"><i class="fa fa-angle-down" ></i></label>
            </div>
            <div class="item" index="1">
                <p class="uploadTip"><i class="fa fa-check-circle"></i>车辆照片已添加，点击<a class="viewImg">查看大图</a></p>
                <label class="weui-btn weui-btn_primary uploadBtn" for="dLicenseUrl"><#if (driver.dLicenseUrl??)&&(driver.dLicenseUrl!='')>车辆照片已通过<#else>上传车辆照片</#if></label>
                <input type="file" name="file" accept="image/*" capture="camera" <#if (driver.dLicenseUrl??)&&(driver.dLicenseUrl!='')>disabled</#if> id="dLicenseUrl" class="hide fileupload"  index="1">
                <input type="text" name="dLicenseUrl" class="hide" <#if (driver.dLicenseUrl??)&&(driver.dLicenseUrl!='')>value="${driver.dLicenseUrl}"</#if>>
                <img class="target hide" <#if (driver.dLicenseUrl??)&&(driver.dLicenseUrl!='')>src="${driver.dLicenseUrl}"</#if> >
            </div>
            <div class="item_submit">
                <a href="javascript:;" class="weui-btn weui-btn_primary submit_certification">提交认证</a>
            </div>
        </form>
    </div>
</section>
<#--预览示例图片-->
<div id="licDemoPop" class="weui-popup__container">
    <div class="weui-popup__overlay"></div>
    <div class="weui-popup__modal">
        <i class="closeBtn close-popup"></i>
        <div class="viewImgBox">
            <div class="view_title text-center">
                <h5>驾驶证样例</h5>
            </div>
            <div class="view_body">
                <img src="/images/wechat/driLicImg.png">
            </div>
            <div class="view_title text-center">
                <h5>行驶证样例</h5>
            </div>
            <div class="view_body">
                <img src="/images/wechat/driLicImg.png">
            </div>
        </div>
    </div>
</div>
<#--预览上传图片-->
<div id="licViewPop" class="weui-popup__container">
    <div class="weui-popup__overlay"></div>
    <div class="weui-popup__modal">
        <i class="closeBtn close-popup"></i>
        <div class="viewImgBox">
            <div class="view_title text-center">
                <h5>预览图片</h5>
            </div>
            <div class="view_body">
                <img src="">
            </div>
        </div>
    </div>
</div>
<#--<canvas id="myCanvas" style="display: none"></canvas>
<img src="" id="ago" style="display: none" />-->
<#--上传图片-->
<script src="/lib/fileUpload/jquery.ui.widget.js"></script>
<script src="/lib/fileUpload/jquery.iframe-transport.js"></script>
<script src="/lib/fileUpload/jquery.fileupload.js"></script>
<#--城市选择-->
<script src="/lib/wechat/city-picker.js"></script>
<script>
    var driverId=$(".driverId").val();

    $(function () {
        $("#reg_form_2").validate({
            ignore:"",
            rules:{
                name:{
                    required:true,
                    isChinese:true,
                    rangelength:[1,6]
                },
                gender:{
                    required:true
                },
                licenseNum:{
                    required:true,
                    rangelength:[18,18]
                },
                licenseEffTime:{
                    required:true
                },
                drivingExp:{
                    required:true
                },
                licenseStartTime:{
                    required:true
                },
                expiredTime:{
                    required:true
                },
                driverPlace:{
                    required:true
                },
                licenseUrl:{
                    required:true
                },
                engineNum:{
                    required:true
                },
                licensePlate:{
                    required:true
                },
                dLicenseNum:{
                    required:true
                },
                dLicenseUrl:{
                    required:true
                },
                model:{
                    required:true
                }
            },
            messages:{
                name:{
                    required:"请输入姓名",
                    isChinese:"请输入中文",
                    rangelength:'请输入6个字符以内的中文姓名'
                },
                gender:{
                    required:"请选择性别"
                },
                licenseNum:{
                    required:"请输入驾驶证编号",
                    rangelength:"证件号码位数或编码有误"
                },
                licenseEffTime:{
                    required:"请选择领证时间"
                },
                drivingExp:{
                    required:"请选择驾龄"
                },
                licenseStartTime:{
                    required:"请选择有效起始日期"
                },
                expiredTime:{
                    required:"请选择有效期限"
                },
                driverPlace:{
                    required:"请选择所在地址"
                },
                licenseUrl:{
                    required:"请上传驾驶、行驶证图片"
                },
                engineNum:{
                    required:"请输入发动机编号"
                },
                licensePlate:{
                    required:"请输入车牌号"
                },
                dLicenseNum:{
                    required:"请输入车辆识别代号"
                },
                dLicenseUrl:{
                    required:"请上传车辆图片"
                },
                model:{
                    required:"请选择车型"
                }
            }
        });
        /*性别*/
        $("#gender").picker({
            title: "选择性别",
            cols: [
                {
                    textAlign: 'center',
                    values:['男', '女']
                }
            ],
            onChange:function () {
                $("#gender-error").hide();
            }
        });
        /*驾龄*/
        $("#drivingExp").picker({
            title:"选择驾龄",
            cols: [
                {
                    textAlign: 'center',
                    values:['3年以内','3-6年','7-10年','10年以上']
                }
            ],
            onChange:function () {
                $("#drivingExp-error").hide();
            }

        });
        /*有效期限*/
        $("#expiredTime").picker({
            title:"选择驾驶证有效期限",
            cols: [
                {
                    textAlign: 'center',
                    values: ['6年','10年','10年以上']
                }
            ],
            onChange:function () {
                $("#expiredTime-error").hide();
            }
        });
        /*选择时间*/
        $("#licenseEffTime").calendar({
            onChange: function (p, values, displayValues) {
                $("#licenseEffTime-error").hide();
            }
        });
        $("#licenseStartTime").calendar({
            onChange: function (p, values, displayValues) {
                $("#licenseStartTime-error").hide();
            }
        });
        /*地址*/

        $("#driverPlace").cityPicker({
            title:"选择所在地址",
        });

        $("#startPlace").cityPicker({
            title:"选择专线1起始地址",
        });
        $("#endPlace").cityPicker({
            title:"选择专线1终点地址",
        });

        $("#startPlace1").cityPicker({
            title:"选择专线2起始地址",
        });
        $("#endPlace1").cityPicker({
            title:"选择专线2终点地址",
        });
        /*车型 */
        $("#model").picker({
            title:'选择车型',
            cols: [
                {
                    textAlign: 'center',
                    values: getCarModel()
                }
            ],
        });

        /*图片上传*/
        //获取上传的参数
        var upUrl,upAppId,upPolicy,upSignature;
        $.ajax({ url: "/api/uploadParams",async: false,  success: function(data){
            upUrl=data.url;
            upAppId=data.appId;
            upPolicy=data.policy;
            upSignature=data.signature;
            //console.log(upUrl+'.......'+upAppId+'.......'+upPolicy+'.......'+upSignature)
        }});

        var imageList=[null,null];
        var licenceName = 'licence'+driverId;
        var dLicenceName = 'dLicence'+driverId;
        var originFileNameList=[licenceName,dLicenceName];
        var fileNameList=[''];
        var uploadSuccessCount=0;
        var uploadFail=false;
        var imageCount = 0;
        $('.fileupload').each(function () {
            var a=$(this).parent();
            var index=$(this).attr('index');
            var self=this;
            $(this).fileupload({
                url:upUrl,
                dataType: 'xml',
                done:function (e,data) {
                    imageCount --;
                    if(imageCount === 0){
                        submitForm();
                    }
                },
                add:function (e,data) {
                    var uploadErrors = [];
                    var acceptFileTypes = /^image\/(jpe?g|png)$/i;

                    if (data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {
                        $.toast('请上传1M以内的 jpg 或 png 文件',1000);
                        return false;
                    }
                    var dataType = data.originalFiles[0]['type'].substr(6, data.originalFiles[0]['type'].length);
                    if (data.originalFiles[0]['size'] > 6000000) {
                        $.toast('文件不能超过6M',1000);
                        return false;
                    }
                    if (uploadErrors.length > 0) {
                        $.toast(uploadErrors.join("<br/>"));
                        return false;
                    }else{
                        $(this).fileupload('option', 'formData', {
                            'Filename': originFileNameList[index] + '.' + dataType,
                            'key': originFileNameList[index] + '.' + dataType,
                            'policy': upPolicy,
                            'OSSAccessKeyId': upAppId,
                            'success_action_status': '200', //让服务端返回200,不然，默认会返回204
                            'signature': upSignature,
                            'Content-Disposition': 'content_disposition'
                        });

                        fileNameList[index] = originFileNameList[index] + '.' + dataType;
                        imageList[index] = data;

                        imageCount ++;

                        var id=$(self).attr('id');
                        if(id=='licenseUrl'){
                            $('[name='+id+']').val(fileNameList[index]);
                            $('#licenseUrl-error').hide();
                        }else if(id=='dLicenseUrl'){
                            $('[name='+id+']').val(fileNameList[index]);
                            $('#dLicenseUrl-error').hide();
                        }

                        /*var Cnv = document.getElementById('myCanvas');
                        var Cntx = Cnv.getContext('2d');
                        var imgss = new Image();
                        var agoimg=document.getElementById("ago");*/

                        if (data.files && data.files[0]) {
                            var reader = new FileReader();
                            reader.onload = function (e) {
                                var url=e.target.result;
                                a.find('.uploadTip').show();
                                a.find('.uploadBtn').text("重新上传照片");
                                a.find('.target').attr('src', url);
                                a.find('.target').attr('data-img', 'true');
                                /*imgss.src = url;
                                agoimg.src = url;
                                agoimg.onload=function () {
                                    var m=imgss.width/imgss.height;
                                    Cnv.height=300;
                                    Cnv.width=300*m;
                                    Cntx.drawImage(agoimg,0,0,300*m,300);
                                    var Pic=Cnv.toDataURL("image/png");
                                    Pic = Pic.replace(/^data:image\/(png|jpg);base64,/, "");
                                    alert(Pic);
                                };*/
                            };
                            reader.readAsDataURL(data.files[0]);
                        }
                    }
                },
                fail:function (e,data) {
                    uploadFail=true;
                    uploadSuccessCount=0;
                    $.hideLoading();
                    $.toast("上传图片失败",1000);
                },
                progressall: function (e, data) {
                    var progress = parseInt(data.loaded / data.total * 100, 10);
                    $('#progress .bar').css(
                            'width',
                            progress + '%'
                    );
                }
            })
        });

        /*查看上传的图片*/
        $(".viewImg").on('click',function () {
            var url=$(this).parents(".item").find(".target").attr("src");
            $("#licViewPop .view_body img").attr("src",url);
            $("#licViewPop").popup();
        });

        /*提交认证*/
        $('.submit_certification').on('click',function () {
            var flag = $("#reg_form_2").valid();
            if(!flag){
                //没有通过验证
                return false;
            }else{
                $.showLoading('图片上传中！');
                var isUpload = false;
                imageList.forEach(function (data) {
                    if (data !== null){
                        data.submit();
                        isUpload = true;
                    }
                });
                if(!isUpload){
                    $.hideLoading();
                    submitForm();
                }
            }
        })
    });

    function submitForm(){
        var data={};
        $("#reg_form_2 input").each(function () {
            var k=$(this).prop('name');
            var v=$(this).val();
            data[k]=v;
        });
        data.licenseType='B2';
        var placeArr=$("#driverPlace").val().split(' ');
        data.province=placeArr[0];
        data.city=placeArr[1];
        data.county=placeArr[2];
        delete data.driverPlace;
        delete data.file;
        var startArr=$("#startPlace").val().split(' ');
        data.taskProvince1=startArr[0];
        data.taskCity1=startArr[1];
        data.taskCounty1=startArr[2];
        delete data.startPlace;

        var endArr=$("#endPlace").val().split(' ');
        data.taskProvince2=endArr[0];
        data.taskCity2=endArr[1];
        data.taskCounty2=endArr[2];
        delete data.endPlace;

        var startArr1=$("#startPlace1").val().split(' ');
        data.taskProvince3=startArr1[0];
        data.taskCity3=startArr1[1];
        data.taskCounty3=startArr1[2];
        delete data.startPlace1;

        var endArr1=$("#endPlace1").val().split(' ');
        data.taskProvince4=endArr1[0];
        data.taskCity4=endArr1[1];
        data.taskCounty4=endArr1[2];
        delete data.endPlace1;


        tools.ajaxPut('/api/driver/completeInfo',data,function (json) {
            $.toast('认证信息提交成功！',1000,function () {
                tools.navigate("/driver/center");
            })
        })
    }
    
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

    //    查看示例大图
    function viewDemo() {
        $("#licDemoPop").popup();
    }
</script>
<#include "/common/footerWechat.ftl"/>
