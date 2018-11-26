adminApp.controller('driverMngCtrl', function ($scope, $http, ngTableParams,$state) {
    $scope.search = {};
    $scope.search.pageIndex = 0;
    $scope.search.pageSize = 10;
    $scope.count = 0;

    $scope.status = 1;

    $scope.setStatus = function (status) {
        $scope.status = status;
        $scope.tableParams.filter().content = null;
        $scope.tableReload();
    };

    $scope.tableReload = function () {
        $scope.tableParams.reload();
    };
    $scope.tableParams = new ngTableParams(
        {
            page: 1,            // show first page
            count: 20           // count per page
        },
        {
            total: 0, // length of data
            counts: [],
            getData: function ($defer, params) {
                var search = {};
                search.pageIndex = params.page() - 1;
                search.pageSize = params.count();
                search.content = params.filter().content == undefined ? null : params.filter().content;
                search.status = $scope.status;
                $http.post("/background/driver/list", search).success(function (data) {
                    params.total(data.count);
                    $defer.resolve(data.list);
                    $scope.count = data.count;
                });
            }
        }
    );

    $scope.info = function(id){
        $state.go('index.driverForm',{id : id});
    }
});

adminApp.controller('driverFormCtrl', function ($scope, $http, $state, $stateParams) {
    $scope.driver = {};
    $scope.rejectForm = {};

    $scope.getDriver = function(){
        $http.get('/background/driver/detail/' + $stateParams.id).success(function (data) {
            $scope.driver = data;
            $scope.rejectForm = angular.copy($scope.driver);
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

    $scope.getDriver();

    $scope.changeCount = 0;

    $scope.chosen = function(el){
        if($scope.rejectForm[el] === $scope.driver[el]){
            $scope.rejectForm[el] = null;
            $scope.changeCount++;
        }else {
            $scope.rejectForm[el] = $scope.driver[el];
            $scope.changeCount--;
        }
    };

    $scope.confirmForm = {
        id : $stateParams.id
    };

    $scope.confirm = function(){
        $http.put('/background/driver/validate',$scope.confirmForm).success(function (data) {
            $.gritter.add({
                title: '提示信息：',
                text: '审核通过'
            });
            $scope.getDriver();
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

    $scope.reject = function(){
        if($scope.changeCount === 0){
            $.gritter.add({
                title: '无法驳回：',
                text: '请选择要驳回的信息'
            });
            return false;
        }
        $http.put('/background/driver/reject',$scope.rejectForm).success(function (data) {
            $.gritter.add({
                title: '提示信息：',
                text: '完成驳回'
            });
            $scope.getDriver();
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

    $scope.enable = function(){
        $http.put('/background/driver/enable',{id:$stateParams.id}).success(function (data) {
            $.gritter.add({
                title: '提示信息：',
                text: '司机启用'
            });
            $scope.getDriver();
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

    $scope.showImgSrc=null;
    $scope.showDisable = function(){
        $("#disableModal").modal("show");
    };

    $scope.disable = function(){
        $http.put('/background/driver/disable',{id:$stateParams.id}).success(function (data) {
            $.gritter.add({
                title: '提示信息：',
                text: '司机禁用'
            });
            $scope.getDriver();
            $("#disableModal").modal("hide");
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

    $scope.showImgSrc = {src:"", rotate:0};
    $scope.showImg=function (imgName) {
        $scope.showImgSrc.src=imgName;
        $("#imgModal").modal("show");
    };
});
