/*
* 存放通用controller
* */
adminApp.controller('loginCtl' , function($scope,$http,$state,$stateParams,$rootScope){
    $scope.showPanel=true;
    $scope.login = function(){
        var ret = ($scope.user) && ($scope.user.phone) && ($scope.user.password);
        if(!ret){
            $.gritter.add({
                title: '提示信息：',
                text: '用户名或密码不能为空！'
            });
            return false;
        }
        $http.post("/background/user/login", $scope.user).success(function(data){
            $rootScope.navList = [];
            $(".login-wrap").removeClass('has-error');
            $(".help-block").hide();
            $('body').css('background','#eff0f4');

            if($stateParams.returnUrl === "" || $stateParams.returnUrl === 'index')
            {
                $state.go('index');
            } else{
                var returnUrl = CryptoJS.enc.Utf8.stringify(CryptoJS.enc.Base64.parse($stateParams.returnUrl));
                window.location =  returnUrl;
            }
        }).error(function (data) {
            $(".login-wrap").addClass('has-error');
            $(".help-block").show();
            $(".login-wrap input").css('border');
            $.gritter.add({
                title: '提示信息：',
                text: data.message
            });
        });

    };
    $scope.showResetPanel = function(){
        $scope.forget = {};
        $scope.showPanel=false;
    };
    $scope.showAccTip = function(){
        $("#getAccTip").modal("show");
    };


    $scope.sendCaptcha = function(){
        if(JSON.stringify($scope.forget)=="{}"){
            $.gritter.add({
                title: '提示信息：',
                text: '请输入手机号！'
            });
            return false;
        }else{
            $http.post("/background/common/captcha",$scope.forget).success(function(){
                $.gritter.add({
                    title: '提示信息：',
                    text: '发送验证码成功！'
                });
                return false;
            }).error(function () {
                $.gritter.add({
                    title: '提示信息：',
                    text: '发送验证码失败！'
                });
                return false;
            });
        }
    };
    $scope.chancelReset=function () {
        $scope.showPanel=true;
    };
    $scope.forgetPwd = function(){
        $http.put("/background/user/forgetPwd",$scope.forget).success(function(){
            $.gritter.add({
                title: '提示信息：',
                text: '修改密码成功！'
            });
            $("#tcModal").modal("hide");
            $scope.forget = {};
            $scope.showPanel=true;
        }).error(function (data) {
            if(data.message != undefined){
                $.gritter.add({
                    title: '提示信息：',
                    text: data.message
                });
            }else{
                $.gritter.add({
                    title: '提示信息：',
                    text: data.fieldErrors[0].message
                });
            }
        });
    };


});

adminApp.controller('resetPasswordCtrl', function ($scope, $http, $state ,$stateParams) {
    $scope.resetPassword={};
    $scope.reset = function(){
        if($stateParams.id != null){
            $scope.resetPassword.id=$stateParams.id;
        }
        $http.post("/user/resetPassword",$scope.resetPassword).success(function(data){
            $.gritter.add({
                title: '提示信息：',
                text: '重置密码成功！五秒后返回登录界面！'
            });
            $scope.resetPassword={};
            setTimeout(function(){
                $state.go('login');
            },5000);
        }).error(function (data) {
            if(data.message != undefined){
                $.gritter.add({
                    title: '提示信息：',
                    text: data.message
                });
            }else{
                $.gritter.add({
                    title: '提示信息：',
                    text: data.fieldErrors[0].message
                });
            }
        });
    }
});

adminApp.controller('initPwdCtl', function ($scope, $http, $state, $stateParams) {
    $scope.resetPassword={};
    $scope.initPwd = function(){
        $http.put("/background/user/changePwd",$scope.resetPassword).success(function(){
            $.gritter.add({
                title: '提示信息：',
                text: '初始化密码成功！'
            });
            $scope.resetPassword={};
            if($stateParams.returnUrl === "" || $stateParams.returnUrl === 'index')
            {
                $state.go('index');
            }
            else{
                var returnUrl = CryptoJS.enc.Utf8.stringify(CryptoJS.enc.Base64.parse($stateParams.returnUrl));
                window.location =  returnUrl;
            }
        }).error(function (data) {
            if(data.message != undefined){
                $.gritter.add({
                    title: '提示信息：',
                    text: data.message
                });
            }else{
                $.gritter.add({
                    title: '提示信息：',
                    text: data.fieldErrors[0].message
                });
            }
        });
    }

});

/*adminApp.controller('taskCountCtrl', function ($scope, $http, $state) {

    $scope.getTotal = function(){
        $http.get("/task/count").success(function (data) {
            $scope.taskCount = data;
        })
    };

    $scope.getTotal();

    window.setInterval(function(){
        $scope.getTotal();
    },60000);

});*/

adminApp.controller('loginOut', function ($scope, $http, $state) {

    $http.get("/background/user/current").success(function (data) {
        $scope.user = data;
    });

    $scope.loginOut = function () {
        $http.get("/background/common/logout").success(function () {
            $state.go('login');
        }).error(function () {

        });

    }
});



adminApp.controller('navCtrl', function ($scope, $http, $state,$stateParams ) {

    $scope.navList = [];

    $scope.getList = function(){
        $http.get("/background/nav/list").success(function (data) {
            $scope.navList = data.list;

            $scope.setCurrentNav();
        });
    };

    $scope.setCurrentNav = function(){
        $scope.home=true;

        var getCurrent = false;

        for(var i=0; i< $scope.navList.length; i++){

            var parent = $scope.navList[i];

            if(parent.parentId !== 0){
                continue;
            }

            for(var j=0; j< $scope.navList.length; j++){

                var child = $scope.navList[j];

                if(child === null || child.parentId === 0)
                    continue;

                if(child.parentId === parent.id && $state.includes(child.uri)){
                    parent.currentItem = true;
                    child.currentItem = true;
                    $scope.home=false;
                    getCurrent = true;
                    break;
                }
            }

            if(getCurrent){
                break;
            }
        }

        if($stateParams.id !== undefined){
            $scope.setNavByState($state.current.name);
        }
    };

    $scope.getParentNav = function(item){
        if(item.parentId === 0){
            return null;
        }

        for(var j = 0; j < $scope.navList.length; j++){
            var parent = $scope.navList[j];
            if(item.parentId === parent.id){
                if(parent.parentId === 0)
                    return item;
                else
                    return $scope.getParentNav(parent);
            }
        }
    };

    $scope.setNavByState = function(uri){
        var parent;
        for(var i = 0;i < $scope.navList.length; i++){
            var item = $scope.navList[i];
            if(item.uri === uri){
                parent = $scope.getParentNav(item);
                break;
            }
        }

        if(parent !== undefined){
            $scope.navStyle(parent.parentId);
            $scope.selectSecondItem(parent);
        }
    };

    $scope.navStyle = function(id){
        var handler = $("#" + id);
        var parent = jQuery(handler).parent();
        var sub = parent.find('> ul');
        parent.addClass('nav-active');
        sub.slideDown(200, function(){
            // mainContentHeightAdjust();
        });
    };

    $scope.getList();

    // 首页nav
    $scope.gotoBackHome=function () {
        $state.go("index.home");
        $scope.home=true;
        for(var i=0; i< $scope.navList.length; i++){
            var item = $scope.navList[i];
            item.currentItem = false;
        }
    };

    $scope.selectItem = function(nav){
        $state.go(nav.uri);
        $scope.home=false;
        nav.currentItem = true;

        for(var i=0; i< $scope.navList.length; i++){
            var item = $scope.navList[i];
            if(item.id !== nav.id){
                item.currentItem = false;
            }
            if(item.id === nav.parentId){
                item.currentItem = true;
            }
        }
    };

    $scope.selectSecondItem = function(nav){
        $scope.home=false;
        nav.currentItem = true;
        for(var i=0; i< $scope.navList.length; i++){
            var item = $scope.navList[i];

            if(item.id !== nav.id){
                item.currentItem = false;
            }
            if(item.id === nav.parentId){
                item.currentItem = true;
            }
        }
    };

    $scope.$on('ngRepeatFinished', function () {
        $('body').append("<script type='text/javascript' src='/lib/admin/scripts.js'></script>");
    });

    $scope.$on('goIndex',function (event,data) {
        $scope.gotoBackHome();
    })

    /*$scope.$on('onStateChangeNav',function (event,data) {
        $scope.home = true;
        var item;
        for(var i1=0; i1< $scope.navList.length; i1++){
            var sub = $scope.navList[i1];
            sub.currentItem = sub.uri === data;
            if(sub.currentItem){
                item = sub;
                $scope.home = false;
            }
        }
        if(item !== undefined){
            for(var i2=0; i2< $scope.navList.length; i2++){
                var parent1 = $scope.navList[i2];
                parent1.currentItem = parent1.id === item.parentId;
                if(parent1.currentItem){
                    item = parent1;
                }
            }
            for(var i3=0; i3< $scope.navList.length; i3++){
                var parent = $scope.navList[i3];
                parent.currentItem = parent.id === item.parentId;
            }
        }

    })*/
});


// 面包屑导航


adminApp.directive('onFinishRenderFilters', function ($timeout) {
    return {
        restrict: 'A',
        link: function(scope, element, attr) {
            if (scope.$last === true) {
                $timeout(function() {
                    scope.$emit('ngRepeatFinished');
                });
            }
        }
    };
});

