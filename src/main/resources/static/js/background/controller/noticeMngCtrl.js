adminApp.controller('noticeMngCtrl', function ($scope, $http, ngTableParams,$state) {
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
                $http.post("/background/notice/list", search).success(function (data) {
                    params.total(data.count);
                    $defer.resolve(data.list);
                    $scope.count = data.count;
                });
            }
        }
    );

    /*$scope.enabled = function(id){
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
    };*/
});

adminApp.controller('noticeFormCtrl', function ($scope, $http, $state, $stateParams) {

    $scope.notice = {
        status :1
    };

    if($stateParams.id !== undefined){
        $http.get('/background/notice/detail/' + $stateParams.id).success(function (data) {
            $scope.notice = data;
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

    $scope.change = function(){
        $scope.notice.status === 0 ? $scope.notice.status++ : $scope.notice.status--;
    };

    $scope.confirm = function(){
        if($stateParams.id === undefined || $stateParams.id === ""){
            $http.post('/background/notice/create', $scope.notice).success(function (data) {
                $.gritter.add({
                    title: '提示信息：',
                    text: '新增公告成功！'
                });
                $scope.notice= {
                    status : 1
                };
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
            $http.put('/background/notice/update', $scope.notice).success(function (data) {
                $.gritter.add({
                    title: '提示信息：',
                    text: '编辑公告成功！'
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
