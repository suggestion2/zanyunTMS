adminApp.controller('userInfoCtrl', function ($scope, $http, $state, $stateParams,$rootScope) {

    $http.get("/background/user/current").success(function (data) {
        $scope.user = data;

        $("#aUserName").text(data.name);
    });

    $scope.forget = {};

    $scope.sendCaptcha = function(){
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
    };

    $scope.forgetPwd = function(){
        $http.put("/background/user/forgetPwd",$scope.forget).success(function(){
            $.gritter.add({
                title: '提示信息：',
                text: '修改密码成功！'
            });
            $("#changePasswordModal").modal("hide");
            $scope.forget = {};
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
    $scope.testText = "";

    $scope.log = function () {
        console.log($scope.testText);
    };

    $scope.test = function(){

    }
});
