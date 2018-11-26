adminApp.controller('userMngCtrl', function ($scope, $http, ngTableParams,$state) {
    $scope.search = {};
    $scope.search.pageIndex = 0;
    $scope.search.pageSize = 10;
    $scope.count = 0;


    $scope.tableReload = function () {
        $scope.tableParams.reload();
    };

    $scope.tableParams = new ngTableParams(
        {
            page: 1,            // show first page
            count: 10           // count per page
        },
        {
            total: 0, // length of data
            counts: [],
            getData: function ($defer, params) {
                var search = {};
                search.pageIndex = params.page() - 1;
                search.pageSize = params.count();
                search.content = params.filter().content == undefined ? null : params.filter().content;
                $http.post("/background/user/list", search).success(function (data) {
                    params.total(data.count);
                    $defer.resolve(data.list);
                    $scope.count = data.count;
                });
            }
        }
    );

    $scope.enabled = function(id){
        $http.put('/background/user/enabled', {id:id}).success(function (data) {
            $.gritter.add({
                title: '提示信息：',
                text: '启用成功',
            });
            $scope.tableParams.reload();
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

    $scope.disabled = function(id){
        $http.put('/background/user/disabled', {id:id}).success(function (data) {
            $.gritter.add({
                title: '提示信息：',
                text: '禁用成功',
            });
            $scope.tableParams.reload();
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

    $scope.initPwd = function(id){
        $http.put('/background/user/initPwd', {id : id}).success(function (data) {
            $.gritter.add({
                title: '提示信息：',
                text: '初始化密码成功'
            });
            $scope.tableReload();
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

adminApp.controller('userFormCtrl', function ($scope, $http, $state, $stateParams) {
    $scope.getDepartmentList = function(){
        $http.get('/background/user/department/list').success(function (data) {
            $scope.dList = data.list;
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

    $scope.getDepartmentList();

    $scope.userInit = function(){
        $scope.user = {
            name : null,
            phone : null,
            departmentId : null
        };
    };

    $scope.userInit();

    if($stateParams.id !== undefined){
        $http.get('/background/user/detail/' + $stateParams.id).success(function (data) {
            $scope.user = data;
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


    $scope.choose = function(id){
        $scope.user.departmentId = id;
    };

    $scope.checkId = function(id){
        return ($scope.user.departmentId === null ? false : $scope.user.departmentId === id)
    };

    $scope.confirm = function(){
        if($scope.user.departmentId === null){
            $.gritter.add({
                title: '提示信息：',
                text: '请选择部门！'
            });
            return false;
        }

        if($stateParams.id === undefined || $stateParams.id === ""){
            $http.post('/background/user/create', $scope.user).success(function (data) {
                $.gritter.add({
                    title: '提示信息：',
                    text: '新增用户成功！'
                });
                $scope.userInit();
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
        }else {
            $http.put('/background/user/update', $scope.user).success(function (data) {
                $.gritter.add({
                    title: '提示信息：',
                    text: '改变部门成功！'
                });
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

    }
});
