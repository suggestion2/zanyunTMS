adminApp.controller('orderMngCtrl', function ($scope,$http, ngTableParams, $state) {
    $scope.search = {};
    $scope.search.pageIndex = 0;
    $scope.search.pageSize = 10;
    $scope.count = 0;

    // 当前时间
    $scope.date=new Date();
    $scope.year=$scope.date.getFullYear();
    $scope.month=$scope.date.getMonth()+1;
    $scope.month=($scope.month<10?'0'+$scope.month:$scope.month);
    $scope.today=($scope.year.toString()+'-'+$scope.month.toString());

    /*导出excel*/
    $scope.export = function (date) {
        if(!date){
            alert('请选择月份')
        }else{
            window.open('/background/document/order/excel?beginTime='+date+'-01');
        }
    };

    $scope.tableReload = function () {
        $scope.tableParams.reload();
    };

    $scope.getUrl = function(){
        return "/background/order/list" + $state.current.url.substr($state.current.url.lastIndexOf("/"));
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
                $http.post($scope.getUrl(), search).success(function (data) {
                    params.total(data.count);
                    $defer.resolve(data.list);
                    $scope.count = data.count;
                });
            }
        }
    );

    $scope.detail = function (id) {
        $state.go('index.orderForm', {id: id});
    };


});

adminApp.controller('orderFormCtrl', function ($scope, $http, $state, $stateParams) {
    $scope.goList = function (status) {
        if(status === 0){
            $state.go('index.validateOrder');
        }
        if(status === 1){
            $state.go('index.unpaidOrder');
        }
        if(status === 3){
            $state.go('index.transportOrder');
        }
        if(status === 4){
            $state.go('index.completeOrder');
        }
        if(status === 5){
            $state.go('index.doneOrder');
        }
        if(status === -1){
            $state.go('index.cancelOrder');
        }
    };

    $scope.map = null;
    $scope.initMap = function(){
        if($scope.map === null){
            $scope.map = new BMap.Map("orderMap");
            $scope.map.centerAndZoom(new BMap.Point(116.404, 39.915), 8);
            $scope.map.enableScrollWheelZoom();
            $scope.map.enableContinuousZoom();

            var driving = new BMap.DrivingRoute($scope.map, {renderOptions:{map: $scope.map, autoViewport: true},onSearchComplete:function(results){
                if($scope.order.status === 4){
                    var pts = results.getPlan(0).getRoute(0).getPath();
                    var paths = pts.length;
                    var part = $scope.order.id % 10 + 1;
                    var marker = new BMap.Marker(pts[parseInt(paths/4) * part]);
                    $scope.map.addOverlay(marker);
                    marker.setAnimation(BMAP_ANIMATION_BOUNCE);
                }
            }});
            driving.search($scope.p1, $scope.p2);

        }
    };

    $scope.getOrder = function () {
        $http.get('/background/order/detail/' + $stateParams.id).success(function (data) {
            $scope.order = data;
            var oriLong = parseInt($scope.order.oriLong);
            var oriLat = parseInt($scope.order.oriLat);
            var arrLong = parseInt($scope.order.arrLong);
            var arrLat = parseInt($scope.order.arrLat);

            $scope.p1 = new BMap.Point(oriLong,oriLat);
            $scope.p2 = new BMap.Point(arrLong,arrLat);


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
    };

    $scope.getOrder();


    //取消订单
    $scope.showRejectModal = function () {
        $scope.rejectForm = {
            id: $stateParams.id
        };
        $("#rejectModal").modal("show");
    };

    $scope.reject = function () {
        $http.put('/background/order/cancel', $scope.rejectForm).success(function () {
            $.gritter.add({
                title: '提示信息：',
                text: '审核成功'
            });
            $scope.getOrder();
            $("#rejectModal").modal("hide");
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
    };


    //审核
    $scope.showValidateModal = function () {
        $scope.validateForm = {
            id: $stateParams.id,
            driverPayType : "现结",
            transDepartmentId: null
        };
        $scope.getValidDepartmentList();
        $("#validateModal").modal("show");
    };

    $scope.getValidDepartmentList = function () {
        $http.get('/background/order/department/transport').success(function (data) {
            $scope.vList = data.list;
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
    };

    $scope.validateForm = {
        id: null,
        driverPayType : "现结",
        transDepartmentId: null
    };

    $scope.chooseValid = function (id) {
        $scope.validateForm.transDepartmentId = id;
    };

    $scope.checkValid = function (id) {
        return ($scope.validateForm.transDepartmentId === null ? false : $scope.validateForm.transDepartmentId === id)
    };

    $scope.validate = function () {
        if($scope.validateForm.transDepartmentId==null){
            $.gritter.add({
                title: '提示信息：',
                text: '请选择分配部门'
            });
            return false;
        }
        $http.put('/background/order/validate', $scope.validateForm).success(function () {
            $.gritter.add({
                title: '提示信息：',
                text: '审核成功'
            });
            $scope.getOrder();
            $scope.validateForm = {
                id: null,
                driverPayType : "现结",
                transDepartmentId: null
            };
            $("#validateModal").modal("hide");
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
    };

    //发货
    $scope.getTransDepartmentList = function () {
        $http.get('/background/order/department/complete').success(function (data) {
            $scope.tList = data.list;
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
    };

    $scope.transportForm = {
        id: null,
        comDepartmentId: null
    };

    $scope.chooseTrans = function (id) {
        $scope.transportForm.comDepartmentId = id;
    };

    $scope.checkTrans = function (id) {
        return ($scope.transportForm.comDepartmentId === null ? false : $scope.transportForm.comDepartmentId === id)
    };

    $scope.showTransportModal = function () {
        $scope.transportForm = {
            id: $stateParams.id,
            comDepartmentId: null
        };
        $scope.getTransDepartmentList();
        $("#transportModal").modal("show");
    };


    $scope.transport = function () {
        $http.put('/background/order/transport',$scope.transportForm).success(function (data) {
            $.gritter.add({
                title: '提示信息：',
                text: '发货成功'
            });
            $scope.getOrder();
            $scope.transportForm = {
                id: null,
                comDepartmentId: null
            };
            $("#transportModal").modal("hide");
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
    };

    $scope.complete = function () {
        $http.put('/background/order/complete', {id: $stateParams.id}).success(function (data) {
            $scope.getOrder();
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
});