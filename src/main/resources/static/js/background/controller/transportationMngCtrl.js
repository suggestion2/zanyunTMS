adminApp.controller('transportationMngCtrl', function ($scope, $http, ngTableParams,$state) {
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
                $http.post("/background/transportation/list", search).success(function (data) {
                    params.total(data.count);
                    $defer.resolve(data.list);
                    $scope.count = data.count;
                });
            }
        }
    );

    $scope.delete = function (id) {
        var con = confirm("确定要删除该记录吗？删除后无法恢复，请谨慎操作！");
        if(con==true){
            $http.delete('/background/transportation/delete/' + id).success(function (data) {
                $.gritter.add({
                    title: '提示信息：',
                    text: '删除成功'
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
    };
});

adminApp.controller('transportationFormCtrl', function ($scope, $http, $state, $stateParams) {
    $scope.checkAuth = function(){
        return false;
    };


    $scope.brands = [];
    $scope.types = [];
    $scope.cargoTypes = [];

    $scope.getParamsList = function(){
        $http.get('/background/transportation/params').success(function (data) {
            angular.forEach(data.list,function (item) {
                if(item.name === 'brand'){
                    $scope.brands = item.value;
                }
                if(item.name === 'type'){
                    $scope.types = item.value;
                }
                if(item.name === 'cargoTypes'){
                    $scope.cargoTypes = item.value;
                }
            })
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

    $scope.getParamsList();

    $scope.transportationInit = function(){
        $scope.transportation = {
            brand : null,
            type : null,
            cargoTypes : []
        };
    };

    $scope.transportationInit();

    if($stateParams.id !== undefined){
        $http.get('/background/transportation/' + $stateParams.id).success(function (data) {
            $scope.transportation = data;
            $scope.transportation.cargoTypes = $scope.transportation.cargoTypes.split(",");
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


    $scope.choose = function(ele,item){
        if(ele === 'cargoTypes'){
            var position = $scope.transportation[ele].indexOf(item);
            if(position === -1){
                $scope.transportation[ele].push(item);
            }else {
                $scope.transportation[ele].splice(position,1);
            }
        }else {
            if($scope.transportation[ele] !== item){
                $scope.transportation[ele] = item;
            }else {
                $scope.transportation[ele] = null;
            }
        }
    };

    $scope.check = function(ele,item){
        if(ele == 'cargoTypes'){
            return $scope.transportation[ele] !== undefined && $scope.transportation[ele].indexOf(item) > -1
        }else {
            return $scope.transportation[ele] !== undefined && $scope.transportation[ele] === item;
        }

    };

    $scope.confirm = function(){
        $scope.transportation.cargoTypes = $scope.transportation.cargoTypes.join(",");
        if($stateParams.id === undefined || $stateParams.id === ""){
            $http.post('/background/transportation/create', $scope.transportation).success(function (data) {
                $.gritter.add({
                    title: '提示信息：',
                    text: '新增成功！'
                });
                $scope.transportationInit();
            }).error(function (data) {
                $scope.transportation.cargoTypes = $scope.transportation.cargoTypes.split(",");
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
            $http.put('/background/transportation/update', $scope.transportation).success(function (data) {
                $.gritter.add({
                    title: '提示信息：',
                    text: '保存成功！'
                });
                $scope.transportation.cargoTypes = $scope.transportation.cargoTypes.split(",");
            }).error(function (data) {
                $scope.transportation.cargoTypes = $scope.transportation.cargoTypes.split(",");
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
