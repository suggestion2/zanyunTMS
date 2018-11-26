adminApp.controller('offlineOrderMngCtrl', function ($scope, $http, ngTableParams, $state) {
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
                search.content = params.filter().content === undefined ? null : params.filter().content;
                $http.post("/background/offlineOrder/list", search).success(function (data) {
                    params.total(data.count);
                    $defer.resolve(data.list);
                    $scope.count = data.count;
                });
            }
        }
    );

    $scope.detail = function (id) {
        $state.go('index.updateOfflineOrder', {id: id});
    };

    $scope.create = function () {
        $state.go('index.insertOfflineOrder');
    };
});

adminApp.controller('offlineOrderFormCtrl', function ($scope, $http, $state, $stateParams) {

    $scope.order = {
        ownerType : 1
    };

    $scope.ownerTypes = [
        {name : "公司",value : 2},
        {name : "个人",value : 1}
    ];

    $scope.getOrder = function(){
        $http.get('/background/offlineOrder/detail/' + $stateParams.id).success(function (data) {
            $scope.order = data;
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

    if($stateParams.id !== undefined){
        $scope.getOrder();
    }

    //删除
    $scope.deleteOrder = function () {
        $http.delete('/background/offlineOrder/' + $stateParams.id).success(function (data) {
            $state.go('index.offlineOrderMng');
        })
    };

    $scope.confirm = function () {
        if($stateParams.id !== undefined) {
            $http.put('/background/offlineOrder/update', $scope.order).success(function (data) {
                $scope.getOrder();
                $state.go('index.offlineOrderMng');
            }).error(function (data) {
                if (data.message !== undefined) {
                    $.gritter.add({
                        title: '提示信息：',
                        text: data.message
                    });
                } else {
                    $.gritter.add({
                        title: '提示信息：',
                        text: data.fieldErrors[0].message
                    });
                }
            });
        }else {
            $http.post('/background/offlineOrder/create', $scope.order).success(function (data) {
                $scope.order = {};
                $state.go('index.offlineOrderMng');
            }).error(function (data) {
                if (data.message !== undefined) {
                    $.gritter.add({
                        title: '提示信息：',
                        text: data.message
                    });
                } else {
                    $.gritter.add({
                        title: '提示信息：',
                        text: data.fieldErrors[0].message
                    });
                }
            });
        }

    }
});