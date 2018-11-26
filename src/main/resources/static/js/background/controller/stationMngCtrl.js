adminApp.controller('stationMngCtrl', function ($scope, $http, ngTableParams,$state) {
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
                $http.post("/background/station/list", search).success(function (data) {
                    params.total(data.count);
                    $defer.resolve(data.list);
                    $scope.count = data.count;
                });
            }
        }
    );

    $scope.enabled = function(id){
        $http.put('/background/station/enabled', {id:id}).success(function (data) {
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
        $http.put('/background/station/disabled', {id:id}).success(function (data) {
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
});

adminApp.controller('stationFormCtrl', function ($scope, $http, $state, $stateParams) {

    $scope.stationInit = function(){
        $scope.station = {
            name : null,
            province : null,
            city : null,
            county : null,
            address : null,
            departmentId : null
        };
    };

    $scope.stationInit();

    if($stateParams.id !== undefined){
        $http.get('/background/station/detail/' + $stateParams.id).success(function (data) {
            $scope.station = data;
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


    $scope.confirm = function(){

        if($stateParams.id === undefined || $stateParams.id === ""){
            var myGeo = new BMap.Geocoder();
            myGeo.getPoint($scope.station.province + $scope.station.city + $scope.station.county + $scope.station.address, function(point){
                if (point) {
                    $scope.station.longitude = point.lng;
                    $scope.station.latitude = point.lat;

                    $http.post('/background/station/create', $scope.station).success(function (data) {
                        $.gritter.add({
                            title: '提示信息：',
                            text: '新增场站成功！'
                        });
                        $scope.stationInit();
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
                }else{
                    $.gritter.add({
                        title: '提示信息：',
                        text: '您选择地址无法解析地理位置！'
                    });
                }
            });
        }else {
            $http.put('/background/station/update', $scope.station).success(function (data) {
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
