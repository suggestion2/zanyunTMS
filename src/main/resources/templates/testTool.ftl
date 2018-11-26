<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>赵霞物流-API</title>
    <link href="/images/favicon.ico" rel="icon" type="image/x-icon"/>
    <link rel="stylesheet" href="/css/jquery-ui.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/tab.css">
    <link rel="stylesheet" href="/js/mask/mask.css">
    <link rel="stylesheet" href="/js/JsonParser/JsonParser.css">
</head>
<body>
<div id="tabs" class="ui-widget-content">

    <div class="tab">
        <button class="tablinks" onclick="openTab(1)">front</button>
        <button class="tablinks" onclick="openTab(2)">background</button>
    </div>

    <div id="tabs-1" style="width: 1400px;display: block">
        <div style="float: left; width: 700px;">
        <#--<div>
            ClientId:
            <select id="selClient">
            <#list clientList as item>
                <option value="${item.id}" secretKey="${item.secretKey}">${item.clientName}</option>
            </#list>
            </select>
            SecretKey:<input class="textbox" type="text" id="secretKey"/>
        </div>
        <div>
            <input type="button" value="Create Visitor ID" onclick="visitorModule.create();"/>
            VisitorID:<input class="textbox" type="text" id="visitorId"/>&nbsp;&nbsp;
        </div>-->
            <div>
                <strong>[当前登录状态]</strong><br/>
                <input type="button" value="check" onclick="loginStatus()"/><br>
            </div>
            <div>
                <strong>[发送注册验证短信]</strong><br/>
                手机:<input class="textbox" type="text" id="sms1-phone" style="width: 100px;" value="13600000000"/>
                类型:<select class="textbox" type="text" id="sms1-type" style="width: 100px;">
                <option value="1" selected>司机</option>
                <option value="2">货主</option>
            </select><br>
                <input type="button" value="send SMS" onclick="sendRegister()"/><br>
            </div>
            <div>
                <strong>[发送忘记密码验证短信]</strong><br/>
                手机:<input class="textbox" type="text" id="sms2-phone" style="width: 100px;" value="13600000000"/>
                <input type="button" value="send SMS" onclick="sendForgetPwd()"/><br>
            </div>
            <div>
                <strong>[司机注册与修改密码]</strong><br/>
                手机:<input class="textbox" type="text" id="driver-register-phone" style="width: 100px;"/>
                验证码:<input class="textbox" type="text" id="driver-register-captcha" style="width: 100px;"/>
                密码:<input class="textbox" type="text" id="driver-register-password" style="width: 200px;"/>
                <input type="button" value="注册" onclick="driverModule.register();"/>
                <input type="button" value="修改密码" onclick="driverModule.changePwd();"/><br>
            </div>
            <div>
                <strong>[验证司机手机号是否注册]</strong><br/>
                手机:<input class="textbox" type="text" id="driver-check-phone" style="width: 100px;" value="13600000000"/>
                <input type="button" value="check" onclick="driverModule.checkPhone()"/><br>
            </div>
            <div>
                <strong>[司机登录与登出]</strong><br/>
                手机:<input class="textbox" type="text" id="driver-login-phone" style="width: 100px;"/>
                密码:<input class="textbox" type="text" id="driver-login-password" style="width: 200px;"/>
                <input type="button" value="登录" onclick="driverModule.login();"/>
                <input type="button" value="登出" onclick="driverModule.logout();"/><br>
            </div>
            <div>
                <strong>[车型列表]</strong><br/>
                <input type="button" value="获取" onclick="transportationParams();"/><br>
                <strong>[司机完善信息]</strong><br/>
                姓名:<input class="textbox" type="text" id="driver-complete-name" style="width: 100px;" value="测试司机"/>
                性别:<input class="textbox" type="text" id="driver-complete-gender" style="width: 100px;" value="男"/><br>
                所在省、市、区:<br>
                <input class="textbox" type="text" id="driver-complete-province" style="width: 100px;" value="测试省"/>
                <input class="textbox" type="text" id="driver-complete-city" style="width: 100px;" value="测试市"/>
                <input class="textbox" type="text" id="driver-complete-county" style="width: 100px;" value="测试区"/><br>
                专线1:<br>
                <input class="textbox" type="text" id="driver-complete-taskProvince1" style="width: 100px;" value="测试省1"/>
                <input class="textbox" type="text" id="driver-complete-taskCity1" style="width: 100px;" value="测试市1"/>
                <input class="textbox" type="text" id="driver-complete-taskCounty1" style="width: 100px;" value="测试区1"/><br>
                <input class="textbox" type="text" id="driver-complete-taskProvince2" style="width: 100px;" value="测试省2"/>
                <input class="textbox" type="text" id="driver-complete-taskCity2" style="width: 100px;" value="测试市2"/>
                <input class="textbox" type="text" id="driver-complete-taskCounty2" style="width: 100px;" value="测试区2"/><br>
                专线2:<br>
                <input class="textbox" type="text" id="driver-complete-taskProvince3" style="width: 100px;" value="测试省3"/>
                <input class="textbox" type="text" id="driver-complete-taskCity3" style="width: 100px;" value="测试市3"/>
                <input class="textbox" type="text" id="driver-complete-taskCounty3" style="width: 100px;" value="测试区3"/><br>
                <input class="textbox" type="text" id="driver-complete-taskProvince4" style="width: 100px;" value="测试省4"/>
                <input class="textbox" type="text" id="driver-complete-taskCity4" style="width: 100px;" value="测试市4"/>
                <input class="textbox" type="text" id="driver-complete-taskCounty4" style="width: 100px;" value="测试区4"/><br>
                (选填)住址:<input class="textbox" type="text" id="driver-complete-address" style="width: 100px;"/>
                (选填)头像:<input class="textbox" type="text" id="driver-complete-portraitUrl" style="width: 200px;"/><br>
                驾照类型:<input class="textbox" type="text" id="driver-complete-licenseType" style="width: 200px;"
                            value="测试类型"/><br>
                驾照编号:<input class="textbox" type="text" id="driver-complete-licenseNum" style="width: 200px;"
                            value="123456123456123456"/><br>
                驾龄:<input class="textbox" type="text" id="driver-complete-drivingExp" style="width: 200px;"
                          value="3"/><br>
                驾照照片:<input class="textbox" type="text" id="driver-complete-licenseUrl" style="width: 200px;"
                            value="/image.jpg"/><br>
                初次领证日期:<input class="textbox" type="text" id="driver-complete-licenseEffTime" style="width: 100px;"
                              value="2015-1-14"/><br>
                驾照有效期(开始时间/有效期):<input class="textbox" type="text" id="driver-complete-licenseStartTime"
                                       style="width: 100px;" value="2015-1-14"/>---<input class="textbox" type="text"
                                                                                          id="driver-complete-expiredTime"
                                                                                          style="width: 100px;"
                                                                                          value="10"/><br>
                车辆识别代码:<input class="textbox" type="text" id="driver-complete-dLicenseNum" style="width: 200px;"
                              value="1234561234561234"/><br>
                发动机号:<input class="textbox" type="text" id="driver-complete-engineNum" style="width: 200px;"
                            value="12345678"/><br>
                车牌号(选填):<input class="textbox" type="text" id="driver-complete-licensePlate" style="width: 200px;"
                            value="闽D12345"/><br>
                行驶证照片:<input class="textbox" type="text" id="driver-complete-dLicenseUrl" style="width: 200px;"
                             value="/dImage.jpg"/><br>
                车型:<input class="" type="text" id="driver-complete-model" style="width: 100px;"
                              value="测试"/><br>
                <input type="button" value="提交" onclick="driverModule.completeInfo();"/><br>
            </div>
            <div>
                <strong>[司机修改信息]</strong><br/>
                专线1:<br>
                <input class="textbox" type="text" id="driver-update-taskProvince1" style="width: 100px;" value="测试省1"/>
                <input class="textbox" type="text" id="driver-update-taskCity1" style="width: 100px;" value="测试市1"/>
                <input class="textbox" type="text" id="driver-update-taskCounty1" style="width: 100px;" value="测试区1"/><br>
                <input class="textbox" type="text" id="driver-update-taskProvince2" style="width: 100px;" value="测试省2"/>
                <input class="textbox" type="text" id="driver-update-taskCity2" style="width: 100px;" value="测试市2"/>
                <input class="textbox" type="text" id="driver-update-taskCounty2" style="width: 100px;" value="测试区2"/><br>
                专线2:<br>
                <input class="textbox" type="text" id="driver-update-taskProvince3" style="width: 100px;" value="测试省3"/>
                <input class="textbox" type="text" id="driver-update-taskCity3" style="width: 100px;" value="测试市3"/>
                <input class="textbox" type="text" id="driver-update-taskCounty3" style="width: 100px;" value="测试区3"/><br>
                <input class="textbox" type="text" id="driver-update-taskProvince4" style="width: 100px;" value="测试省4"/>
                <input class="textbox" type="text" id="driver-update-taskCity4" style="width: 100px;" value="测试市4"/>
                <input class="textbox" type="text" id="driver-update-taskCounty4" style="width: 100px;" value="测试区4"/><br>
                <input type="button" value="提交" onclick="driverModule.updateInfo();"/>
            </div>
            <div>
                <strong>[司机个人信息]</strong><br/>
                <input type="button" value="获取" onclick="driverModule.current();"/>
            </div>
            <div>
                <strong>[货主注册与修改密码]</strong><br/>
                姓名:<input class="textbox" type="text" id="owner-register-name" style="width: 100px;"
                          value="测试"/>
                手机:<input class="textbox" type="text" id="owner-register-phone" style="width: 100px;"
                          value="13610000000"/>
                验证码:<input class="textbox" type="text" id="owner-register-captcha" style="width: 100px;"/>
                密码:<input class="textbox" type="text" id="owner-register-password" style="width: 200px;"/>
                <input type="button" value="注册" onclick="ownerModule.register();"/>
                <input type="button" value="修改密码" onclick="ownerModule.changePwd();"/><br>
            </div>
            <div>
                <strong>[货主登录与登出]</strong><br/>
                手机:<input class="textbox" type="text" id="owner-login-phone" style="width: 100px;"/>
                密码:<input class="textbox" type="text" id="owner-login-password" style="width: 200px;"/>
                <input type="button" value="登录" onclick="ownerModule.login();"/>
                <input type="button" value="登出" onclick="ownerModule.logout();"/><br>
            </div>
            <div>
                <strong>[获取货主]</strong><br/>
                <input type="button" value="货主信息" onclick="ownerModule.current();"/><br>
            </div>
            <div>
                <strong>[修改货主姓名]</strong><br/>
                姓名:<input class="textbox" type="text" id="owner-update-name" style="width: 100px;"/>
                <input type="button" value="修改" onclick="ownerModule.update();"/><br>
            </div>
            <div>
                <strong>[获取配车列表]</strong><br/>
                startIndex:<input class="textbox" type="text" id="truckList-index" style="width: 100px;" value="0"/>
                pageSize:<input class="textbox" type="text" id="truckList-size" style="width: 200px;" value="10"/>
                <input type="button" value="配车列表" onclick="driverModule.truckList();"/><br>
            </div>
            <div>
                <strong>[获取配车信息]</strong><br/>
                id:<input class="textbox" type="text" id="truckView-id" style="width: 100px;"/>
                <input type="button" value="配车信息" onclick="driverModule.truckView();"/><br>
            </div>

            <div>
                <strong>[获取支付状态]</strong><br/>
                <input type="button" value="支付状态" onclick="driverModule.paymentStatus();"/><br>
            </div>

            <div>
                <strong>[货源大厅]</strong><br/>
                startIndex:<input class="textbox" type="text" id="orderPublic-list-index" style="width: 100px;" value="0"/>
                pageSize:<input class="textbox" type="text" id="orderPublic-list-size" style="width: 200px;" value="10"/>
                <input type="button" value="货源大厅" onclick="orderModule.orderPublicList();"/><br>
            </div>

            <div>
                <strong>[车源大厅]</strong><br/>
                startIndex:<input class="textbox" type="text" id="truckPublic-list-index" style="width: 100px;" value="0"/>
                pageSize:<input class="textbox" type="text" id="truckPublic-list-size" style="width: 200px;" value="10"/>
                <input type="button" value="车源大厅" onclick="driverModule.truckPublicList();"/><br>
            </div>

            <div>
                <strong>[文章列表]</strong><br/>
                搜索标题:<input class="textbox" type="text" id="article-list-content" style="width: 100px;" />
                startIndex:<input class="textbox" type="text" id="article-list-index" style="width: 100px;" value="0"/>
                pageSize:<input class="textbox" type="text" id="article-list-size" style="width: 200px;" value="10"/>
                <input type="button" value="文章列表" onclick="articleModule.list();"/><br>
            </div>

            <div>
                <strong>[文章详情]</strong><br/>
                id:<input class="textbox" type="text" id="article-detail-id" style="width: 100px;" />
                <input type="button" value="文章详情" onclick="articleModule.getById();"/><br>
            </div>

            <div>
                <strong>[公告列表]</strong><br/>
                搜索标题:<input class="textbox" type="text" id="notice-list-content" style="width: 100px;" />
                startIndex:<input class="textbox" type="text" id="notice-list-index" style="width: 100px;" value="0"/>
                pageSize:<input class="textbox" type="text" id="notice-list-size" style="width: 200px;" value="10"/>
                <input type="button" value="公告列表" onclick="noticeModule.list();"/><br>
            </div>

            <div>
                <strong>[公告详情]</strong><br/>
                id:<input class="textbox" type="text" id="notice-detail-id" style="width: 100px;" />
                <input type="button" value="公告详情" onclick="noticeModule.getById();"/><br>
            </div>

            <div>
                <strong>[广告位列表]</strong><br/>
                <input type="button" value="广告位列表" onclick="getAdvs();"/><br>
            </div>

            <div>
                <strong>[轮播图列表]</strong><br/>
                <input type="button" value="轮播图列表" onclick="getBanners();"/><br>
            </div>
        </div>

        <div style="float: left; width: 700px;">
            <div>
                <strong>[调起地图]</strong><br/>
                <a href="http://api.map.baidu.com/marker?location=39.916979519873,116.41004950566&title=我的位置&content=百度奎科大厦&output=html">测试调起地图</a><br/>
            </div>
            <div>
                <strong>[获取图片上传参数]</strong><br/>
                <input type="button" value="获取" onclick="uploadParams();"/>
            </div>
            <div>
                <strong>[根据省市区选择中转站]</strong><br/>
                省:<input class="textbox" type="text" id="order-create-stationProvince" style="width: 100px;"
                         value="测试省"/>
                市:<input class="textbox" type="text" id="order-create-stationCity" style="width: 100px;" value="测试市"/>
                区:<input class="textbox" type="text" id="order-create-stationCounty" style="width: 100px;" value="测试区"/><br/>
                <input type="button" value="获取列表" onclick="stationModule.getStationList();"/>
            </div>
            <div>
                <strong>[地址列表]</strong><br/>
                <input type="button" value="地址列表" onclick="addressModule.list();"/>
            </div>
            <div>
                <strong>[创建地址]</strong><br/>
                联系人:<input class="textbox" type="text" id="address-create-contact" style="width: 100px;"
                         value="测试联系人"/>
                联系方式:<input class="textbox" type="text" id="address-create-phone" style="width: 100px;" value="13606095319"/><br/>
                省:<input class="textbox" type="text" id="address-create-province" style="width: 100px;" value="测试省"/>
                市:<input class="textbox" type="text" id="address-create-city" style="width: 100px;" value="测试市"/>
                区:<input class="textbox" type="text" id="address-create-county" style="width: 100px;" value="测试区"/><br/>
                详细地址:<input class="textbox" type="text" id="address-create-address" style="width: 100px;" value="测试地址"/><br/>
                经度:<input class="textbox" type="text" id="address-create-longitude" style="width: 100px;" value="118.123456"/>
                纬度:<input class="textbox" type="text" id="address-create-latitude" style="width: 100px;" value="56.224584"/><br/>
                <input type="button" value="创建地址" onclick="addressModule.create();"/>
            </div>
            <div>
                <strong>[更新地址]</strong><br/>
                id:<input class="textbox" type="text" id="address-update-id" style="width: 100px;"
                           value="1"/><br/>
                联系人:<input class="textbox" type="text" id="address-update-contact" style="width: 100px;"
                           value="测试联系人"/>
                联系方式:<input class="textbox" type="text" id="address-update-phone" style="width: 100px;" value="13606095319"/><br/>
                省:<input class="textbox" type="text" id="address-update-province" style="width: 100px;" value="测试省"/>
                市:<input class="textbox" type="text" id="address-update-city" style="width: 100px;" value="测试市"/>
                区:<input class="textbox" type="text" id="address-update-county" style="width: 100px;" value="测试区"/><br/>
                详细地址:<input class="textbox" type="text" id="address-update-address" style="width: 100px;" value="测试地址"/><br/>
                经度:<input class="textbox" type="text" id="address-update-longitude" style="width: 100px;" value="118.123456"/>
                纬度:<input class="textbox" type="text" id="address-update-latitude" style="width: 100px;" value="56.224584"/><br/>
                <input type="button" value="更新地址" onclick="addressModule.update();"/>
            </div>
            <div>
                <strong>[删除地址]</strong><br/>
                id:<input class="textbox" type="text" id="address-delete-id" style="width: 100px;"
                          value="1"/><br/>
                <input type="button" value="删除地址" onclick="addressModule.deleteById();"/>
            </div>
            <div>
                <strong>[创建订单]</strong><br/>
                货主姓名:<input class="textbox" type="text" id="order-create-ownerName" style="width: 100px;" value="测试货主"/>
                货主类型:
                <select class="textbox" type="text" id="order-create-ownerType" style="width: 100px;">
                    <option value="1" selected>个人</option>
                    <option value="2">公司</option>
                </select><br>
                个人:<br/>
                货主身份证:<input class="textbox" type="text" id="order-create-ownerIdCardNum" style="width: 200px;"
                             value="350204198001010001"/><br>
                公司:<br/>
                公司名称:<input class="textbox" type="text" id="order-create-companyName" style="width: 100px;"
                            value="测试公司"/>
                社会组织机构代码:<input class="textbox" type="text" id="order-create-companyLicenseCode" style="width: 200px;"
                                value="132456123456123456"/><br>
                省:<input class="textbox" type="text" id="order-create-companyProvince" style="width: 100px;"
                         value="测试省"/>
                市:<input class="textbox" type="text" id="order-create-companyCity" style="width: 100px;" value="测试市"/>
                区:<input class="textbox" type="text" id="order-create-companyCounty" style="width: 100px;" value="测试区"/><br/>
                地址:<input class="textbox" type="text" id="order-create-companyAddr" style="width: 100px;" value="测试地址"/><br/>

                装货时间(选填):<input class="textbox" type="text" id="order-create-loadTime" style="width: 100px;"
                            value="2017-12-31"/>
                装货联系人:<input class="textbox" type="text" id="order-create-loadContact" style="width: 100px;"
                             value="测试装货"/>
                联系人手机:<input class="textbox" type="text" id="order-create-loadPhone" style="width: 100px;"
                             value="13600000001"/><br>
                预计卸货时间(选填):<input class="textbox" type="text" id="order-create-landTime" style="width: 100px;"
                            value="2018-01-31"/>
                卸货公司(选填):<input class="textbox" type="text" id="order-create-dischargeCompany" style="width: 100px;"
                             value="测试卸货公司"/>
                卸货联系人:<input class="textbox" type="text" id="order-create-dischargeContact" style="width: 100px;"
                             value="测试卸货"/>
                联系人手机:<input class="textbox" type="text" id="order-create-dischargePhone" style="width: 100px;"
                             value="13600000002"/><br>

                装货中转站id、名称：
                <input class="textbox" type="text" id="order-create-oriStationId" style="width: 100px;" value="1"/>
                <input class="textbox" type="text" id="order-create-oriStationName" style="width: 100px;" value="装货中转站"/>
                装货省、市、区:
                <input class="textbox" type="text" id="order-create-oriProvince" style="width: 100px;" value="装货省"/>
                <input class="textbox" type="text" id="order-create-oriCity" style="width: 100px;" value="装货市"/>
                <input class="textbox" type="text" id="order-create-oriCounty" style="width: 100px;" value="装货区"/><br>
                装货详细地址、经度、纬度:
                <input class="textbox" type="text" id="order-create-oriAddress" style="width: 200px;" value="装货地址"/>
                <input class="textbox" type="text" id="order-create-oriLong" style="width: 100px;"
                       value="100.0001"/>
                <input class="textbox" type="text" id="order-create-oriLat" style="width: 100px;"
                       value="30.0001"/><br>

                卸货中转站id、名称：
                <input class="textbox" type="text" id="order-create-arrStationId" style="width: 100px;" value="2"/>
                <input class="textbox" type="text" id="order-create-arrStationName" style="width: 100px;" value="卸货中转站"/>
                卸货省、市、区:
                <input class="textbox" type="text" id="order-create-arrProvince" style="width: 100px;" value="卸货省"/>
                <input class="textbox" type="text" id="order-create-arrCity" style="width: 100px;" value="卸货市"/>
                <input class="textbox" type="text" id="order-create-arrCounty" style="width: 100px;" value="卸货区"/><br>
                卸货详细地址、经度、纬度:
                <input class="textbox" type="text" id="order-create-arrAddress" style="width: 200px;" value="卸货地址"/>
                <input class="textbox" type="text" id="order-create-arrLong" style="width: 100px;"
                       value="101.00001"/>
                <input class="textbox" type="text" id="order-create-arrLat" style="width: 100px;"
                       value="31.00001"/><br>

                货物类型:<input class="textbox" type="text" id="order-create-cargoType" style="width: 100px;" value="测试货物"/>
                车型:<input class="textbox" type="text" id="order-create-transportationModel" style="width: 100px;" value="测试车型"/>
                货物描述:<input class="textbox" type="text" id="order-create-cargoDesc" style="width: 200px;" value="测试货物"/><br/>
                吨数:<input class="textbox" type="text" id="order-create-ton" style="width: 100px;" value="1"/>
                立方数(选填):<input class="textbox" type="text" id="order-create-cube" style="width: 100px;" value="1"/>
                件数(选填):<input class="textbox" type="text" id="order-create-pieces" style="width: 100px;" value="1"/>
                货值(万元)(选填):<input class="textbox" type="text" id="order-create-cargoValue" style="width: 100px;" value="1"/><br>

                类型:
                <select class="textbox" type="text" id="order-create-type" style="width: 100px;">
                    <option value="1" selected>整单</option>
                    <option value="2">零担</option>
                    <option value="3">3PL</option>
                </select><br>
                货主运费:<input class="textbox" type="text" id="order-create-ownerFreight" style="width: 100px;"
                            value="0.01"/><br>
                备注:<input class="textbox" type="text" id="order-create-remarks" style="width: 200px;" value="无"/><br>
                <input type="button" value="创建" onclick="orderModule.create();"/><br>

            </div>
            <div>
                <strong>[接单]</strong><br/>
                id:<input class="textbox" type="text" id="order-take-id" style="width: 100px;" value="2"/>
                <input type="button" value="接单" onclick="orderModule.take();"/><br>
            </div>
            <div>
                <strong>[支付(支付前需接单)]</strong><br/>
                <a href="/weChatPay/js">微信支付</a>
            </div>

            <div>
                <strong>[列表]</strong><br/>
                状态:
                <select class="textbox" type="text" id="order-list-status" style="width: 100px;">
                    <option value="-1">取消</option>
                    <option value="0">创建</option>
                    <option value="3" selected>已接单</option>
                    <option value="4">运输中</option>
                    <option value="5">已完成</option>
                    <option value="10">全部</option>
                </select><br>
                pageIndex:<input class="textbox" type="text" id="order-list-pageIndex" style="width: 100px;" value="0"/>
                pageSize:<input class="textbox" type="text" id="order-list-pageSize" style="width: 100px;" value="10"/>
                <input type="button" value="待接单订单" onclick="orderModule.createdList();"/>
                <input type="button" value="司机" onclick="orderModule.driverList();"/>
                <input type="button" value="货主" onclick="orderModule.ownerList();"/><br>
            </div>

            <div>
                <strong>[详情]</strong><br/>
                id:<input class="textbox" type="text" id="order-detail-id" style="width: 100px;" value="1"/>
                <input type="button" value="司机" onclick="orderModule.driverDetail();"/>
                <input type="button" value="货主" onclick="orderModule.ownerDetail();"/><br>
            </div>

            <div>
                <strong>[状态数量]</strong><br/>
                <input type="button" value="司机" onclick="orderModule.statusCount();"/><br>
            </div>

        </div>
    </div>

    <div id="tabs-2" style="width: 1400px;display: none">
        <div style="float: left; width: 700px;">
            <div>
                <strong>[通过手机号查询司机,获取司机id]</strong><br/>
                手机号:<input class="textbox" type="text" id="driverContent" style="width: 100px;"/><br>
                往返城市:<input class="textbox" type="text" id="taskCity" style="width: 100px;"/><br>
                <input type="button" value="查询" onclick="driverModule.searchList()"/><br>
                <br>
                <strong>[司机审核]</strong><br/>
                id:<input class="textbox" type="text" id="driverId" style="width: 100px;"/><br>
                <input type="button" value="司机审核通过" onclick="driverModule.validate()"/><br>
                <input type="button" value="司机审核不通过" onclick="driverModule.reject()"/><br>
                <br>
                <strong>[司机启用禁用]</strong><br/>
                id:<input class="textbox" type="text" id="driverId" style="width: 100px;"/><br>
                <input type="button" value="司机审核通过" onclick="driverModule.validate()"/><br>
                <input type="button" value="司机审核不通过" onclick="driverModule.reject()"/><br>
                <br>
                <strong>[通过订单编号查询订单,获取订单id]</strong><br/>
                订单编号:<input class="textbox" type="text" id="orderContent" style="width: 100px;"/><br>
                <input type="button" value="查询" onclick="orderModule.searchList()"/><br>
                <br>
                <strong>[运单审核通过]</strong><br/>
                id:<input class="textbox" type="text" id="orderVId" style="width: 100px;"/><br>
                信息费(元):<input class="textbox" type="text" id="infoFee" style="width: 200px;" value="0.01"/><br>
                司机运费(元):<input class="textbox" type="text" id="driverFreight" style="width: 200px;" value="100"/><br>
                付款方式:<input class="textbox" type="text" id="driverPayType" style="width: 200px;" value="现结"/><br>
                平台实收运费(元):<input class="textbox" type="text" id="finalFreight" style="width: 200px;" value="100"/><br>
                装货处理部门:<input class="textbox" type="text" id="transDepartmentId" style="width: 200px;" value="1"/><br>
                <input type="button" value="运单审核通过" onclick="orderModule.validate()"/><br>
                <br>
                <strong>[运单取消]</strong><br/>
                id:<input class="textbox" type="text" id="orderCId" style="width: 100px;"/><br>
                备注:<input class="textbox" type="text" id="remarks" style="width: 200px;" value="取消原因"/><br>
                <input type="button" value="运单取消" onclick="orderModule.cancel()"/><br>
                <br>
            </div>

            <div>
                <strong>[解绑微信]</strong><br/>
                手机号:<input class="textbox" type="text" id="unbundled-phone" style="width: 100px;"
                           value="13123123123"/><br>
                <input type="button" value="司机解绑" onclick="driverModule.unbundled()"/><br>
                <input type="button" value="货主解绑" onclick="ownerModule.unbundled()"/><br>
            </div>
        </div>

        <div style="float: left; width: 700px;">
            <div>
                <strong>[权限列表]</strong><br/>
                <input type="button" value="权限列表" onclick="authModule.viewList()"/><br>
            </div>
        </div>
    </div>


    <div style="clear: both;"></div>
</div>

<div style="margin-top: 7px; height:27px;" class="ui-tabs ui-widget ui-widget-content ui-corner-all">
    <b>Requested URL: </b>
    <input type="text" id="requestedUrl" style="width:60%;"
           domain="${request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()?c}"/>


</div>

<div id="d_param" class="ui-tabs ui-corner-all">
    <div style="float:left;width:300px; margin:0 10px 10px 0;height: 450px;"
         class="ui-tabs ui-widget ui-widget-content ui-corner-all">
        <strong style="margin-left: 5px;">Requested Method:</strong>

        <lable id="requestedMethod"></lable>
        <br/><br/>
        <strong style="margin-left: 5px;">HTTP Header:</strong>
        <table id="tb_h_param">
        <#--<tr>
            <td>ClientId:</td>
            <td><input type="text" id="p_clientId"/></td>
        </tr>
        <tr>
            <td>SecretKey:</td>
            <td><input type="text" id="p_secretKey"/></td>
        </tr>-->
            <tr>
                <td colspan="2"><textarea id="p_data" rows="20" cols="35"></textarea></td>
            </tr>
        </table>
    </div>

    <div style="margin-left:315px; z-index:9999; position:relative;">

        <div id="resultShow"></div>
    </div>
</div>


</body>
<script src="/js/jquery-1.10.2.js"></script>
<script src="/js/jquery-ui.js"></script>
<script src="/js/JsonParser/JsonParser.js"></script>
<script src="/js/crypto/hmac-sha1.js"></script>
<script src="/js/crypto/enc-base64-min.js"></script>
<script src="/js/tool.js"></script>
<script src="/js/mask/mask.js"></script>

</html>
