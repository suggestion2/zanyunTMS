$(function() {

    window.jsonParser = new JsonParser("");

    /*$("#secretKey").val($("option:selected", $("#selClient")).attr("secretKey"));

    $("#selClient").change(function(){
        var optionSelected = $("option:selected", this);
        $("#secretKey").val($(optionSelected).attr("secretKey"));

        $("#p_clientId").val( $("#selClient").val());
        $("#p_secretKey").val( $("#secretKey").val());
    });

    $("#p_clientId").val( $("#selClient").val());
    $("#p_secretKey").val( $("#secretKey").val());*/

});

function openTab(tab) {
    if(tab === 1){
        $("#tabs-2").hide();
        $("#tabs-1").show();
    }else if(tab === 2){
        $("#tabs-1").hide();
        $("#tabs-2").show();
    }
}

function uuid() {
    var s = [];
    var hexDigits = "0123456789abcdef";
    for (var i = 0; i < 36; i++) {
        s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    }
    s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
    s[8] = s[13] = s[18] = s[23] = "-";

    var uuid = s.join("");
    return uuid;
}

function showResult(settings) {
    $.fn.mask();

    $("#requestedUrl").val($("#requestedUrl").attr("domain") + settings.url);
    $("#requestedMethod").text(settings.type);
    $("#p_data").text(settings.data == null ? "" : settings.data);

    var timestamp = Math.round(new Date().getTime());
    /*var requestId = uuid();
    var visitorId = $("#visitorId").val();*/

    /*var signature = [];
    signature.push("uri=" + settings.url);
    signature.push("&method=" + settings.type.toUpperCase());
    if (settings.data != null && settings.data.length > 0)
        signature.push("&body=" + settings.data);
    signature.push("&timestamp=" + timestamp);
    signature.push("&requestId=" + requestId);
    if(visitorId != null && visitorId.length > 0)
        signature.push("&visitorId=" + visitorId);
    console.log(signature.join(''));
    var signatureStr =  CryptoJS.HmacSHA1(signature.join(''),$("#secretKey").val()).toString(CryptoJS.enc.Base64);
    console.log(signatureStr);*/

    $.ajax({
        type: settings.type,
        url: settings.url,
        dataType: settings.dataType,
        data: settings.data,
        contentType: "application/json",
        headers: {
            "Timestamp" : timestamp
            /*,"Client-Id": $("#selClient").val(),
            "Visitor-Id" : $("#visitorId").val(),
            "Request-Id" : requestId,
            "Client-Signature": signatureStr*/
        },
        success: function (data) {

            window.jsonParser.jsonContent = JSON.stringify(data);
            window.jsonParser.init();

            if (settings.success)
                settings.success(data);

            $.fn.mask.close();
        },
        error: function (data) {
            window.jsonParser.jsonContent = JSON.stringify(data);
            window.jsonParser.init();
            $.fn.mask.close();
        }
    });
}

function loginStatus() {
    var settings = {
        type: "GET",
        url: "/api/current/loginStatus",
        dataType: "json"
    };
    showResult(settings);
}

function sendRegister(){
    var settings = {
        type: "POST",
        url: "/api/captcha/register",
        dataType: "json",
        data: JSON.stringify({
            "phone": $("#sms1-phone").val(),
            "type": $("#sms1-type").val()
        })
    };
    showResult(settings);
}


function sendForgetPwd(){
    var settings = {
        type: "POST",
        url: "/api/captcha/forgetPassword",
        dataType: "json",
        data: JSON.stringify({
            "phone": $("#sms2-phone").val()
        })
    };
    showResult(settings);
}

function uploadParams() {
    var settings = {
        type: "GET",
        url: "/api/uploadParams",
        dataType: "json"
    };
    showResult(settings);
}

function transportationParams() {
    var settings = {
        type: "GET",
        url: "/api/transportationParams",
        dataType: "json"
    };
    showResult(settings);
}


function getAdvs() {
    var settings = {
        type: "GET",
        url: "/api/advertisement/list",
        dataType: "json"
    };
    showResult(settings);
}


function getBanners() {
    var settings = {
        type: "GET",
        url: "/api/banner/list",
        dataType: "json"
    };
    showResult(settings);
}

var driverModule = {
    register: function(){
        var settings = {
            type: "POST",
            url: "/api/driver/register",
            dataType: "json",
            data: JSON.stringify({
                "phone": $("#driver-register-phone").val(),
                "captcha" : $("#driver-register-captcha").val(),
                "password" : $("#driver-register-password").val()
            })
        };
        showResult(settings);
    },
    checkPhone: function(){
        var settings = {
            type: "POST",
            url: "/api/driver/checkPhone",
            dataType: "json",
            data: JSON.stringify({
                "phone": $("#driver-check-phone").val()
            })
        };
        showResult(settings);
    },
    changePwd: function(){
        var settings = {
            type: "PUT",
            url: "/api/driver/changePwd",
            dataType: "json",
            data: JSON.stringify({
                "phone": $("#driver-register-phone").val(),
                "captcha" : $("#driver-register-captcha").val(),
                "password" : $("#driver-register-password").val()
            })
        };
        showResult(settings);
    },
    login: function () {
        var settings = {
            type: "POST",
            url: "/api/driver/login",
            dataType: "json",
            data: JSON.stringify({
                "phone": $("#driver-login-phone").val(),
                "password" : $("#driver-login-password").val(),
            })
        };
        showResult(settings);
    },

    logout : function(){
        var settings = {
            type: "GET",
            url: "/api/logout",
            dataType: "json"
        };
        showResult(settings);
    },

    completeInfo : function(){
        var settings = {
            type: "PUT",
            url: "/api/driver/completeInfo",
            dataType: "json",
            data: JSON.stringify({
                "name": $("#driver-complete-name").val(),
                "gender": $("#driver-complete-gender").val(),
                "province": $("#driver-complete-province").val(),
                "city": $("#driver-complete-city").val(),
                "county": $("#driver-complete-county").val(),
                "address": $("#driver-complete-address").val(),
                "portraitUrl": $("#driver-complete-portraitUrl").val(),
                "licenseType": $("#driver-complete-licenseType").val(),
                "licenseNum": $("#driver-complete-licenseNum").val(),
                "drivingExp": $("#driver-complete-drivingExp").val(),
                "licenseUrl": $("#driver-complete-licenseUrl").val(),
                "licenseEffTime": $("#driver-complete-licenseEffTime").val(),
                "licenseStartTime": $("#driver-complete-licenseStartTime").val(),
                "expiredTime": $("#driver-complete-expiredTime").val(),
                "dLicenseNum": $("#driver-complete-dLicenseNum").val(),
                "licensePlate": $("#driver-complete-licensePlate").val(),
                "engineNum": $("#driver-complete-engineNum").val(),
                "dLicenseUrl": $("#driver-complete-dLicenseUrl").val(),
                "model": $("#driver-complete-model").val(),
                "taskProvince1": $("#driver-complete-taskProvince1").val(),
                "taskCity1": $("#driver-complete-taskCity1").val(),
                "taskCounty1": $("#driver-complete-taskCounty1").val(),
                "taskProvince2": $("#driver-complete-taskProvince2").val(),
                "taskCity2": $("#driver-complete-taskCity2").val(),
                "taskCounty2": $("#driver-complete-taskCounty2").val(),
                "taskProvince3": $("#driver-complete-taskProvince3").val(),
                "taskCity3": $("#driver-complete-taskCity3").val(),
                "taskCounty3": $("#driver-complete-taskCounty3").val(),
                "taskProvince4": $("#driver-complete-taskProvince4").val(),
                "taskCity4": $("#driver-complete-taskCity4").val(),
                "taskCounty4": $("#driver-complete-taskCounty4").val()
            })
        };
        showResult(settings);
    },
    updateInfo : function(){
        var settings = {
            type: "PUT",
            url: "/api/driver/updateInfo",
            dataType: "json",
            data: JSON.stringify({
                "taskProvince1": $("#driver-update-taskProvince1").val(),
                "taskCity1": $("#driver-update-taskCity1").val(),
                "taskCounty1": $("#driver-update-taskCounty1").val(),
                "taskProvince2": $("#driver-update-taskProvince2").val(),
                "taskCity2": $("#driver-update-taskCity2").val(),
                "taskCounty2": $("#driver-update-taskCounty2").val(),
                "taskProvince3": $("#driver-update-taskProvince3").val(),
                "taskCity3": $("#driver-update-taskCity3").val(),
                "taskCounty3": $("#driver-update-taskCounty3").val(),
                "taskProvince4": $("#driver-update-taskProvince4").val(),
                "taskCity4": $("#driver-update-taskCity4").val(),
                "taskCounty4": $("#driver-update-taskCounty4").val()
            })
        };
        showResult(settings);
    },
    current : function(){
        var settings = {
            type: "GET",
            url: "/api/driver/current",
            dataType: "json"
        };
        showResult(settings);
    },
    validate: function(){
        var settings = {
            type: "PUT",
            url: "/background/driver/validate",
            dataType: "json",
            data: JSON.stringify({
                "id": $("#driverId").val()
            })
        };
        showResult(settings);
    },
    
    reject: function () {
        var settings = {
            type: "PUT",
            url: "/background/driver/reject",
            dataType: "json",
            data: JSON.stringify({
                "id": $("#driverId").val()
            })
        };
        showResult(settings);
    },
    unbundled: function () {
        var settings = {
            type: "PUT",
            url: "/background/driver/unbundled",
            dataType: "json",
            data: JSON.stringify({
                "phone": $("#unbundled-phone").val()
            })
        };
        showResult(settings);
    },

    searchList:function () {
        var settings = {
            type: "POST",
            url: "/background/driver/list",
            dataType: "json",
            data: JSON.stringify({
                "content": $("#driverContent").val(),
                "taskCity": $("#taskCity").val()
            })
        };
        showResult(settings);
    },

    truckList:function(){
        var settings = {
            type: "POST",
            url: "/api/driver/truckView/list",
            dataType: "json",
            data: JSON.stringify({
                "pageIndex": $("#truckList-index").val(),
                "pageSize": $("#truckList-size").val()
            })
        };
        showResult(settings);
    },

    truckPublicList:function(){
    var settings = {
        type: "POST",
        url: "/api/driver/truckView/list/public",
        dataType: "json",
        data: JSON.stringify({
            "pageIndex": $("#truckPublic-list-index").val(),
            "pageSize": $("#truckPublic-list-size").val()
        })
    };
    showResult(settings);
},

    truckView:function(){
        var settings = {
            type: "GET",
            url: "/api/driver/truckView/" + $("#truckView-id").val(),
            dataType: "json"
        };
        showResult(settings);
    },

    paymentStatus:function(){
        var settings = {
            type: "GET",
            url: "/wechat/payment/status",
            dataType: "json"
        };
        showResult(settings);
    }
};

var ownerModule = {
    register: function(){
        var settings = {
            type: "POST",
            url: "/api/owner/register",
            dataType: "json",
            data: JSON.stringify({
                "name": $("#owner-register-name").val(),
                "phone": $("#owner-register-phone").val(),
                "captcha" : $("#owner-register-captcha").val(),
                "password" : $("#owner-register-password").val()
            })
        };
        showResult(settings);
    },
    changePwd: function(){
        var settings = {
            type: "PUT",
            url: "/api/owner/changePwd",
            dataType: "json",
            data: JSON.stringify({
                "phone": $("#owner-register-phone").val(),
                "captcha" : $("#owner-register-captcha").val(),
                "password" : $("#owner-register-password").val()
            })
        };
        showResult(settings);
    },
    login: function () {
        var settings = {
            type: "POST",
            url: "/api/owner/login",
            dataType: "json",
            data: JSON.stringify({
                "phone": $("#owner-login-phone").val(),
                "password" : $("#owner-login-password").val(),
            })
        };
        showResult(settings);
    },
    update: function(){
        var settings = {
            type: "PUT",
            url: "/api/owner/update",
            dataType: "json",
            data: JSON.stringify({
                "name": $("#owner-update-name").val()
            })
        };
        showResult(settings);
    },
    logout : function(){
        var settings = {
            type: "GET",
            url: "/api/logout",
            dataType: "json"
        };
        showResult(settings);
    },
    current : function(){
        var settings = {
            type: "GET",
            url: "/api/owner/current",
            dataType: "json"
        };
        showResult(settings);
    },
    validate: function(){
        var settings = {
            type: "PUT",
            url: "/background/owner/validate",
            dataType: "json",
            data: JSON.stringify({
                "id": $("#validateId").val()
            })
        };
        showResult(settings);
    },

    reject: function () {
        var settings = {
            type: "PUT",
            url: "/background/owner/reject",
            dataType: "json",
            data: JSON.stringify({
                "id": $("#validateId").val()
            })
        };
        showResult(settings);
    },

    unbundled: function () {
        var settings = {
            type: "PUT",
            url: "/background/owner/unbundled",
            dataType: "json",
            data: JSON.stringify({
                "phone": $("#unbundled-phone").val()
            })
        };
        showResult(settings);
    }
};

var orderModule = {
    create: function(){
        var settings = {
            type: "POST",
            url: "/api/order/create",
            dataType: "json",
            data: JSON.stringify({
                "ownerType": parseInt($("#order-create-ownerType").val()),
                "ownerName": $("#order-create-ownerName").val(),
                "ownerIdCardNum": $("#order-create-ownerIdCardNum").val(),
                "companyName": $("#order-create-companyName").val(),
                "companyLicenseCode": $("#order-create-companyLicenseCode").val(),
                "companyProvince": $("#order-create-companyProvince").val(),
                "companyCity": $("#order-create-companyCity").val(),
                "companyCounty": $("#order-create-companyCounty").val(),
                "companyAddr": $("#order-create-companyAddr").val(),
                "loadTime": $("#order-create-loadTime").val(),
                "landTime": $("#order-create-landTime").val(),
                "loadContact": $("#order-create-loadContact").val(),
                "loadPhone": $("#order-create-loadPhone").val(),
                "dischargeContact": $("#order-create-dischargeContact").val(),
                "dischargeCompany": $("#order-create-dischargeCompany").val(),
                "dischargePhone": $("#order-create-dischargePhone").val(),
                "oriStationId": $("#order-create-oriStationId").val(),
                "oriStationName": $("#order-create-oriStationName").val(),
                "oriProvince": $("#order-create-oriProvince").val(),
                "oriCity": $("#order-create-oriCity").val(),
                "oriCounty": $("#order-create-oriCounty").val(),
                "oriAddress": $("#order-create-oriAddress").val(),
                "oriLong": $("#order-create-oriLong").val(),
                "oriLat": $("#order-create-oriLat").val(),
                "arrStationId": $("#order-create-arrStationId").val(),
                "arrStationName": $("#order-create-arrStationName").val(),
                "arrProvince": $("#order-create-arrProvince").val(),
                "arrCity": $("#order-create-arrCity").val(),
                "arrCounty": $("#order-create-arrCounty").val(),
                "arrAddress": $("#order-create-arrAddress").val(),
                "arrLong": $("#order-create-arrLong").val(),
                "arrLat": $("#order-create-arrLat").val(),
                "cargoType": $("#order-create-cargoType").val(),
                "cargoDesc": $("#order-create-cargoDesc").val(),
                "ton": $("#order-create-ton").val(),
                "cube": $("#order-create-cube").val(),
                "pieces": $("#order-create-pieces").val(),
                "cargoValue": $("#order-create-cargoValue").val(),
                "type": $("#order-create-type").val(),
                "ownerFreight": $("#order-create-ownerFreight").val(),
                "transportationModel": $("#order-create-transportationModel").val(),
                "remarks": $("#order-create-remarks").val()
            })
        };
        showResult(settings);
    },

    validate: function(){
        var settings = {
            type: "PUT",
            url: "/background/order/validate",
            dataType: "json",
            data: JSON.stringify({
                "id": $("#orderVId").val(),
                "infoFee": $("#infoFee").val(),
                "driverFreight": $("#driverFreight").val(),
                "finalFreight": $("#finalFreight").val(),
                "driverPayType": $("#driverPayType").val(),
                "transDepartmentId": $("#transDepartmentId").val()
            })
        };
        showResult(settings);
    },

    cancel: function () {
        var settings = {
            type: "PUT",
            url: "/background/order/cancel",
            dataType: "json",
            data: JSON.stringify({
                "id": $("#orderCId").val(),
                "remarks": $("#remarks").val()
            })
        };
        showResult(settings);
    },

    take: function () {
        var settings = {
            type: "PUT",
            url: "/api/order/take",
            dataType: "json",
            data: JSON.stringify({
                "id": $("#order-take-id").val()
            })
        };
        showResult(settings);
    },

    createdList: function () {
        var settings = {
            type: "POST",
            url: "/api/order/list",
            dataType: "json",
            data: JSON.stringify({
                "pageIndex": $("#order-list-pageIndex").val(),
                "pageSize": $("#order-list-pageSize").val()
            })
        };
        showResult(settings);
    },

    driverList: function () {
        var settings = {
            type: "POST",
            url: "/api/order/driver/list",
            dataType: "json",
            data: JSON.stringify({
                "status": parseInt($("#order-list-status").val()),
                "pageIndex": $("#order-list-pageIndex").val(),
                "pageSize": $("#order-list-pageSize").val()
            })
        };
        showResult(settings);
    },

    ownerList: function () {
        var settings = {
            type: "POST",
            url: "/api/order/owner/list",
            dataType: "json",
            data: JSON.stringify({
                "status": parseInt($("#order-list-status").val()),
                "pageIndex": $("#order-list-pageIndex").val(),
                "pageSize": $("#order-list-pageSize").val()
            })
        };
        showResult(settings);
    },

    driverDetail: function () {
        var settings = {
            type: "GET",
            url: "/api/order/driver/" + $("#order-detail-id").val()
        };
        showResult(settings);
    },

    ownerDetail: function () {
        var settings = {
            type: "GET",
            url: "/api/order/owner/" + $("#order-detail-id").val()
        };
        showResult(settings);
    },

    statusCount: function () {
        var settings = {
            type: "GET",
            url: "/api/order/driver/count"
        };
        showResult(settings);
    },

    searchList:function () {
        var settings = {
            type: "POST",
            url: "/background/order/list",
            dataType: "json",
            data: JSON.stringify({
                "content": $("#orderContent").val()
            })
        };
        showResult(settings);
    },

    orderPublicList:function () {
        var settings = {
            type: "POST",
            url: "/api/order/list/public",
            dataType: "json",
            data: JSON.stringify({
                "pageIndex": $("#orderPublic-list-index").val(),
                "pageSize": $("#orderPublic-list-size").val()
            })
        };
        showResult(settings);

    }
};

var authModule = {
    viewList:function () {
        var settings = {
            type: "GET",
            url: "/background/auth/list"
        };
        showResult(settings);
    }
};

var stationModule = {
    getStationList:function () {
        var settings = {
            type: "POST",
            url: "/api/station/list",
            dataType: "json",
            data: JSON.stringify({
                "province": $("#order-create-stationProvince").val(),
                "city": $("#order-create-stationCity").val(),
                "county": $("#order-create-stationCounty").val()
            })
        };
        showResult(settings);
    }
};

var addressModule = {
    list:function () {
        var settings = {
            type: "GET",
            url: "/api/address/list",
            dataType: "json"
        };
        showResult(settings);
    },
    create:function () {
        var settings = {
            type: "POST",
            url: "/api/address/create",
            dataType: "json",
            data: JSON.stringify({
                "contact": $("#address-create-contact").val(),
                "phone": $("#address-create-phone").val(),
                "province": $("#address-create-province").val(),
                "city": $("#address-create-city").val(),
                "county": $("#address-create-county").val(),
                "longitude": $("#address-create-longitude").val(),
                "latitude": $("#address-create-latitude").val(),
                "address": $("#address-create-address").val()
            })
        };
        showResult(settings);
    },
    update:function () {
        var settings = {
            type: "PUT",
            url: "/api/address/update",
            dataType: "json",
            data: JSON.stringify({
                "id": $("#address-update-id").val(),
                "contact": $("#address-update-contact").val(),
                "phone": $("#address-update-phone").val(),
                "province": $("#address-update-province").val(),
                "city": $("#address-update-city").val(),
                "county": $("#address-update-county").val(),
                "longitude": $("#address-update-longitude").val(),
                "latitude": $("#address-update-latitude").val(),
                "address": $("#address-update-address").val()
            })
        };
        showResult(settings);
    },
    deleteById:function () {
        var settings = {
            type: "DELETE",
            url: "/api/address/" + $("#address-delete-id").val(),
            dataType: "json"
        };
        showResult(settings);
    }
};

var articleModule = {
    list:function () {
        var settings = {
            type: "POST",
            url: "/api/article/list",
            dataType: "json",
            data: JSON.stringify({
                "content": $("#article-list-content").val(),
                "pageIndex": $("#article-list-index").val(),
                "pageSize": $("#article-list-size").val()
            })
        };
        showResult(settings);
    },
    getById:function () {
        var settings = {
            type: "GET",
            url: "/api/article/" + $("#article-detail-id").val(),
            dataType: "json"
        };
        showResult(settings);
    }
};

var noticeModule = {
    list:function () {
        var settings = {
            type: "POST",
            url: "/api/notice/list",
            dataType: "json",
            data: JSON.stringify({
                "content": $("#notice-list-content").val(),
                "pageIndex": $("#notice-list-index").val(),
                "pageSize": $("#notice-list-size").val()
            })
        };
        showResult(settings);
    },
    getById:function () {
        var settings = {
            type: "GET",
            url: "/api/notice/" + $("#notice-detail-id").val(),
            dataType: "json"
        };
        showResult(settings);
    }
};
