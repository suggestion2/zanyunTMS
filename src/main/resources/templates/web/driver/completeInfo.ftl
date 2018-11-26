<#include "/common/headerWeb.ftl"/>
<#include "/common/navWeb.ftl"/>
<input value="${driver.id}" class="driverId hide">
<input value="${driver.status}" class="driverStatus hide">
<section class="main_section">
    <input value="1" class="driverId hide">
    <section class="center_section">
        <div class="container center_body">
            <div class="panel panel_info">
                <div class="panel-heading">
                    <h5 class="panel-title">司机完善信息</h5>
                </div>
                <div class="panel-body">
                    <p class="reg_tip text-center">为了保障您作为承运人的合法权利，请填写并提交<a onclick="viewDemo()">B2类驾驶员</a>资质信息。在通过审核后，您的公开个人资料将仅显示姓氏。</p>
                    <form class="form-horizontal driverForm" role="form" id="reg_form_2">
                        <div class="row">
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>司机姓名：</label>
                                <div class="col-sm-8 inputBox">
                                    <input type="text" class="form-control" name="name" placeholder="请填写真实姓名" <#if (driver.name??)&&(driver.name!='')>value="${driver.name}" disabled</#if>>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>性别：</label>
                                <div class="col-sm-8 radioBox">
                                    <label>
                                        <input type="radio" name="gender" value="男" <#if (driver.gender??)&&(driver.gender=='男')>checked</#if>> 男
                                    </label>
                                    <label>
                                        <input type="radio" name="gender" value="女" <#if (driver.gender??)&&(driver.gender=='女')>checked</#if>> 女
                                    </label>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 text-center" style="margin-bottom: 24px">专线信息（选填）</div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4">专线1起点</label>
                                <div class="col-sm-8 inputBox addressBox" id="startPlace">
                                    <div class="col-xs-4">
                                        <select class="form-control" id="startprovince" name="taskProvince1" <#if driver.taskProvince1??&&driver.taskProvince1!=''>data-province="${driver.taskProvince1}"<#else>data-province="—— 省 ——"</#if>></select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" id="startcity" name="taskCity1" <#if driver.taskCity1??&&driver.taskCity1!=''>data-city="${driver.taskCity1}"<#else>data-city="—— 市 ——"</#if>></select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" id="startcounty" name="taskCounty1" <#if driver.taskCounty1??&&driver.taskCounty1!=''>data-district="${driver.taskCounty1}"<#else>data-district="—— 区 ——"</#if>></select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4">专线1终点</label>
                                <div class="col-sm-8 inputBox addressBox" id="endPlace">
                                    <div class="col-xs-4">
                                        <select class="form-control" id="endprovince" name="taskProvince2" <#if driver.taskProvince2??&&driver.taskProvince2!=''>data-province="${driver.taskProvince2}"<#else>data-province="—— 省 ——"</#if>></select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" id="endcity" name="taskCity2" <#if driver.taskCity2??&&driver.taskCity2!=''>data-city="${driver.taskCity2}"<#else>data-city="—— 市 ——"</#if>></select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" id="endcounty" name="taskCounty2" <#if driver.taskCounty2??&&driver.taskCounty2!=''>data-district="${driver.taskCounty2}"<#else>data-district="—— 区 ——"</#if>></select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4">专线2起点</label>
                                <div class="col-sm-8 inputBox addressBox" id="startPlace1">
                                    <div class="col-xs-4">
                                        <select class="form-control" id="startprovince1" name="taskProvince3" <#if driver.taskProvince3??&&driver.taskProvince3!=''>data-province="${driver.taskProvince3}"<#else>data-province="—— 省 ——"</#if>></select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" id="startcity1" name="taskCity3" <#if driver.taskCity3??&&driver.taskCity3!=''>data-city="${driver.taskCity3}"<#else>data-city="—— 市 ——"</#if>></select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" id="startcounty1" name="taskCounty3" <#if driver.taskCounty3??&&driver.taskCounty3!=''>data-district="${driver.taskCounty3}"<#else>data-district="—— 区 ——"</#if>></select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4">专线2终点</label>
                                <div class="col-sm-8 inputBox addressBox" id="endPlace1">
                                    <div class="col-xs-4">
                                        <select class="form-control" id="endprovince1" name="taskProvince4" <#if driver.taskProvince4??&&driver.taskProvince4!=''>data-province="${driver.taskProvince4}"<#else>data-province="—— 省 ——"</#if>></select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" id="endcity1" name="taskCity4" <#if driver.taskCity4??&&driver.taskCity4!=''>data-city="${driver.taskCity4}"<#else>data-city="—— 市 ——"</#if>></select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" id="endcounty1" name="taskCounty4" <#if driver.taskCounty4??&&driver.taskCounty4!=''>data-district="${driver.taskCounty4}"<#else>data-district="—— 区 ——"</#if>></select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 line" style="border-bottom: 1px solid #ddd;margin-bottom: 24px"></div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>所在省/市/区</label>
                                <div class="col-sm-8 inputBox addressBox" id="address">
                                    <div class="col-xs-4">
                                        <select class="form-control" id="province" name="province" <#if driver.province??&&driver.province!=''>data-province="${driver.province}"</#if>></select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" id="city" name="city" <#if driver.city??&&driver.city!=''>data-city="${driver.city}"</#if>></select>
                                    </div>
                                    <div class="col-xs-4">
                                        <select class="form-control" id="county" name="county" <#if driver.county??&&driver.county!=''>data-district="${driver.county}"</#if>></select>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>驾驶证编号：</label>
                                <div class="col-sm-8 inputBox">
                                    <input type="text" class="form-control" name="licenseNum" placeholder="请输入B2证-18位驾驶证编号" <#if (driver.licenseNum??)&&(driver.licenseNum!='')>value="${driver.licenseNum}" disabled</#if>>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>初次领证日期：</label>
                                <div class="col-sm-8 inputBox">
                                    <input type="text" class="form-control" name="licenseEffTime" id="licenseEffTime" placeholder="初次领证日期" readonly <#if (driver.licenseEffTime??)&&(driver.licenseEffTime?string('yyyy-MM-dd')!='')>value="${driver.licenseEffTime?string('yyyy-MM-dd')}" disabled</#if>>
                                    <label class="caret" for="licenseEffTime"></label>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>驾龄：</label>
                                <div class="col-sm-8 radioBox">
                                    <label>
                                        <input type="radio" name="drivingExp" value="3年以内" <#if (driver.drivingExp??)&&(driver.drivingExp=='3年以内')>checked</#if>> 3年以内
                                    </label>
                                    <label>
                                        <input type="radio" name="drivingExp" value="3-6年" <#if (driver.drivingExp??)&&(driver.drivingExp=='3-6年')>checked</#if>> 3-6年
                                    </label>
                                    <label>
                                        <input type="radio" name="drivingExp" value="7-10年" <#if (driver.drivingExp??)&&(driver.drivingExp=='7-10年')>checked</#if>> 7-10年
                                    </label>
                                    <label>
                                        <input type="radio" name="drivingExp" value="10年以上" <#if (driver.drivingExp??)&&(driver.drivingExp=='10年以上')>checked</#if>> 10年以上
                                    </label>
                                </div>
                            </div>

                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>驾驶证有效起始日期：</label>
                                <div class="col-sm-8 inputBox">
                                    <input type="text" class="form-control" name="licenseStartTime" id="licenseStartTime" placeholder="有效起始日期" readonly <#if (driver.licenseStartTime??)&&(driver.licenseStartTime?string('yyyy-MM-dd')!='')>value="${driver.licenseStartTime?string('yyyy-MM-dd')}" disabled</#if>>
                                    <label class="caret" for="licenseStartTime"></label>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>驾驶证有效期限：</label>
                                <div class="col-sm-8 radioBox">
                                    <label>
                                        <input type="radio" name="expiredTime" value="6年" <#if (driver.expiredTime??)&&(driver.expiredTime=='6年')>checked</#if>> 6年
                                    </label>
                                    <label>
                                        <input type="radio" name="expiredTime" value="10年" <#if (driver.expiredTime??)&&(driver.expiredTime=='10年')>checked</#if>> 10年
                                    </label>
                                    <label>
                                        <input type="radio" name="expiredTime" value="10年以上" <#if (driver.expiredTime??)&&(driver.expiredTime=='10年以上')>checked</#if>> 10年以上
                                    </label>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>发动机号：</label>
                                <div class="col-sm-8 inputBox">
                                    <input type="text" class="form-control" name="engineNum" placeholder="发动机号" <#if (driver.engineNum??)&&(driver.engineNum!='')>value="${driver.engineNum}" disabled</#if>>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>车辆识别代号：</label>
                                <div class="col-sm-8 inputBox">
                                    <input type="text" class="form-control" name="dLicenseNum" placeholder="车辆识别代号" <#if (driver.dLicenseNum??)&&(driver.dLicenseNum!='')>value="${driver.dLicenseNum}" disabled</#if>>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>车牌号：</label>
                                <div class="col-sm-8 inputBox">
                                    <input type="text" class="form-control" name="licensePlate" placeholder="车牌号" <#if (driver.licensePlate??)&&(driver.licensePlate!='')>value="${driver.licensePlate}" disabled</#if>>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>车型：</label>
                                <div class="col-sm-8">
                                    <div class="dropdown carMode">
                                        <input type="text" class="form-control dropdown-toggle"  data-toggle="dropdown" name="model" id="model" placeholder="选择货车车型" readonly <#if (driver.model??)&&(driver.model!='')>value="${driver.model}" disabled</#if>>
                                        <label class="caret" for="model"></label>
                                        <ul class="dropdown-menu model-menu" role="menu">

                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>驾驶证行驶证照片：</label>
                                <div class="item col-sm-8" index="0">
                                    <label class="btn btn-danger uploadBtn" for="licenseUrl" ><#if (driver.licenseUrl??)&&(driver.licenseUrl!='')>驾驶、行驶证证照片已通过<#else>上传驾驶、行驶证照片</#if></label>
                                    <p class="uploadTip"><i class="fa fa-check-circle"></i>驾驶、行驶证已添加，点击<a class="viewImg">查看大图</a></p>
                                    <input type="file" accept="image/*" <#if (driver.licenseUrl??)&&(driver.licenseUrl!='')>disabled</#if> name="file" id="licenseUrl" class="hide fileupload" index="0">
                                    <input type="text" class="hide" name="licenseUrl" <#if (driver.licenseUrl??)&&(driver.licenseUrl!='')>value="${driver.licenseUrl}"</#if>>
                                    <img class="target hide" <#if (driver.licenseUrl??)&&(driver.licenseUrl!='')>src="${driver.licenseUrl}"<#else>src=""</#if> >
                                </div>
                            </div>
                            <div class="form-group col-sm-6">
                                <label class="control-label col-sm-4"><b>*</b>车辆照片：</label>
                                <div class="item col-sm-8" index="1">
                                    <label class="btn btn-danger uploadBtn" for="dLicenseUrl"><#if (driver.dLicenseUrl??)&&(driver.dLicenseUrl!='')>车辆照片已通过<#else>上传车辆照片</#if></label>
                                    <p class="uploadTip"><i class="fa fa-check-circle"></i>车辆照片已添加，点击<a class="viewImg">查看大图</a></p>
                                    <input type="file" accept="image/*" name="file" id="dLicenseUrl" class="hide fileupload" index="1" <#if (driver.dLicenseUrl??)&&(driver.dLicenseUrl!='')>disabled</#if>>
                                    <input type="text" class="hide" name="dLicenseUrl" <#if (driver.dLicenseUrl??)&&(driver.dLicenseUrl!='')>value="${driver.dLicenseUrl}"</#if>>
                                    <img class="target hide"  <#if (driver.dLicenseUrl??)&&(driver.dLicenseUrl!='')>src="${driver.dLicenseUrl}"<#else>src=""</#if>>
                                </div>
                            </div>
                        </div>

                        <div class="item_submit form-group row text-center">
                            <a class="btn btn-danger submit_certification" href="javascript:;">提交认证</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
</section>

<div class="modal" id="upload_tip" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="false" style="background: rgba(0,0,0,.3)"></div>
<#--时间插件-->
<script src="/lib/laydate/laydate.js"></script>
<#--地址选择器 -->
<script src="/lib/citypicker/distpicker.data.js"></script>
<script src="/lib/citypicker/distpicker.js"></script>
<#--上传图片-->
<script src="/lib/fileUpload/jquery.ui.widget.js"></script>
<script src="/lib/fileUpload/jquery.iframe-transport.js"></script>
<script src="/lib/fileUpload/jquery.fileupload.js"></script>
<script>
    var driverId=$(".driverId").val();
    $(function () {

        $('[data-toggle="tooltip"]').tooltip();
        /*表单验证*/
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
                dLicenseNum:{
                    required:true
                },
                licensePlate:{
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
                    required:"请选择领驾驶证时间"
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
                dLicenseNum:{
                    required:"请输入车辆识别代号"
                },
                licensePlate:{
                    required:"请输入车辆号"
                },
                dLicenseUrl:{
                    required:"请上传车辆图片"
                },
                model:{
                    required:"请选择车型"
                }
            }
        });

        /*城市选择*/
        $('#startPlace').distpicker({
            autoSelect: false
        });
        $('#endPlace').distpicker({
            autoSelect: false
        });
        $('#startPlace1').distpicker({
            autoSelect: false
        });
        $('#endPlace1').distpicker({
            autoSelect: false
        });
        $('#address').distpicker({
            placeholder:false,
            autoSelect: true
        });
        /*领证时间*/
        laydate.render({
            elem:'#licenseEffTime'
        });
        /*驾照有效起始时间*/
        laydate.render({
            elem:'#licenseStartTime'
        });
        /*车型*/
        $(".model-menu li a").on('click',function () {
            $("input[name=model]").val($(this).text());
        });
        /*图片上传*/
        /*获取上传图片的参数*/
        var upUrl,upAppId,upPolicy,upSignature;
        $.ajax({ url: "/api/uploadParams",async: false,  success: function(data){
            upUrl=data.url;
            upAppId=data.appId;
            upPolicy=data.policy;
            upSignature=data.signature;
//            console.log(upUrl+'.......'+upAppId+'.......'+upPolicy+'.......'+upSignature)
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
                    $('#upload_tip').modal('hide');
                    tools.msg("上传图片失败");
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
            var title='';
            var url=$(this).parents(".item").find(".target").attr("src");
            var inputId=$(this).parent('p').next('input').attr('id');
            console.log(inputId);
            if(inputId=='dLicenseUrl'){
                title="查看车辆大图";
            }else{
                title="查看驾驶、行驶证大图";
            }
            layer.open({
                type:1,
                title:title,
                area:['400px','500px'],
                shadeClose:true,
                content:"<div class='viewImgBox'>" +
                "<img src="+url+">" +
                "</div>"
            });
        });

        /*提交认证*/
        $('.submit_certification').on('click',function () {
            var flag = $("#reg_form_2").valid();
            if(!flag){
                //没有通过验证
                return;
            }else{
                $('#upload_tip').modal('show');
                var isUpload = false;
                imageList.forEach(function (data) {
                    if (data !== null){
                        data.submit();
                        isUpload = true;
                    }
                });
                if(!isUpload){
                    submitForm();
                }
            }
        });
    });

    function submitForm(){
        var data={};
        $("#reg_form_2 input").each(function () {
            if($(this).attr('type') == 'radio'){
                var k=$(this).prop('name');
                var v=$('input:radio[name='+k+']:checked').val();
            }else{
                var k=$(this).prop('name');
                var v=$(this).val();
            }
            data[k]=v;
        });
        data.licenseType='B2';
        data.province=$("#province option:selected").text();
        data.city=$("#city option:selected").text();
        data.county=$("#county option:selected").text();

        data.taskProvince1=$("#startprovince option:selected").text();
        if(data.taskProvince1=='—— 省 ——') data.taskProvince1='';
        data.taskCity1=$("#startcity option:selected").text();
        if(data.taskCity1=='—— 市 ——') data.taskCity1='';
        data.taskCounty1=$("#startcounty option:selected").text();
        if(data.taskCounty1=='—— 区 ——') data.taskCounty1='';

        data.taskProvince2=$("#endprovince option:selected").text();
        if(data.taskProvince2=='—— 省 ——') data.taskProvince2='';
        data.taskCity2=$("#endcity option:selected").text();
        if(data.taskCity2=='—— 市 ——') data.taskCity2='';
        data.taskCounty2=$("#endcounty option:selected").text();
        if(data.taskCounty2=='—— 区 ——') data.taskCounty2='';

        data.taskProvince3=$("#startprovince1 option:selected").text();
        if(data.taskProvince3=='—— 省 ——') data.taskProvince3='';
        data.taskCity3=$("#startcity1 option:selected").text();
        if(data.taskCity3=='—— 市 ——') data.taskCity3='';
        data.taskCounty3=$("#startcounty1 option:selected").text();
        if(data.taskCounty3=='—— 区 ——') data.taskCounty3='';

        data.taskProvince4=$("#endprovince1 option:selected").text();
        if(data.taskProvince4=='—— 省 ——') data.taskProvince4='';
        data.taskCity4=$("#endcity1 option:selected").text();
        if(data.taskCity4=='—— 市 ——') data.taskCity4='';
        data.taskCounty4=$("#endcounty1 option:selected").text();
        if(data.taskCounty4=='—— 区 ——') data.taskCounty4='';
        delete data.file;
        console.log(data);
        tools.ajaxPut('/api/driver/completeInfo',data,function (json) {
            $('#upload_tip').modal('hide');
            tools.msg('认证信息提交成功！',function () {
                tools.navigate("/driver/center");
            },function () {
                $('#upload_tip').modal('hide');
            })
        })
    }

    /*验证中文字符*/
    jQuery.validator.addMethod("isChinese", function(value, element) {
        return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);
    }, "只能包含中文字符。");
    /*查看示例大图 */
    function viewDemo() {
        layer.open({
            type:1,
            title:'驾驶证行驶证示例图片',
            area:['450px','600px'],
            shadeClose:true,
            content:'<img src="/images/web/driLicImg.png">'
        });
    }
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
                var str='';
                $.each(carArr,function (idx,val) {
                    str+='<li><a>'+val+'</a></li>'
                });
                $(".carMode .model-menu").html(str);
            }
        });
    }
    getCarModel();
</script>
<#include "/common/footerWeb.ftl"/>

