adminApp.controller('departmentMngCtrl', function ($scope, $http, ngTableParams, $state) {
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
                $http.post("/background/department/list", search).success(function (data) {
                    params.total(data.count);
                    $defer.resolve(data.list);
                    $scope.count = data.count;
                });
            }
        }
    );


});

adminApp.controller('departmentFormCtrl', function ($scope, $http, $stateParams,$state) {
    $scope.createDepartment = function(){
        $scope.department = {
            name: null,
            desc: null,
            authIdList: [],
            authIds: '',
            dingChatId : null
        };
    };

    $scope.list = [];

    $scope.getList = function () {
        $http.get('/background/auth/list').success(function (data) {
            $scope.list = data.list;
            $scope.createDepartment();
            if($stateParams.id !== undefined){
                $scope.getDepartment();
            }
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

    $scope.getDepartment = function(){
        $http.get('/background/department/detail/' + $stateParams.id).success(function (data) {
            $scope.department = data;
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

    $scope.getList();

    $scope.checkId = function(id){
        return $scope.department.authIdList.indexOf(id) > -1;
    };

    $scope.chooseId = function (item) {
        var chosen = $scope.department.authIdList.indexOf(item.id);
        if (chosen > -1) {
            $scope.department.authIdList.splice(chosen, 1);
            $scope.removeIds(item);
        } else {
            $scope.addIds($scope.list,item.id);
        }
    };

    $scope.removeIds = function (item) {
        if(item.subList === null || item.subList.length === 0){
            return false;
        }
        for (var i = 0; i < item.subList.length; i++) {
            var subItem = item.subList[i];
            var subChosen = $scope.department.authIdList.indexOf(subItem.id);
            if(subChosen > -1){
                $scope.department.authIdList.splice(subChosen, 1);
                $scope.removeIds(subItem);
            }

        }
    };

    $scope.addIds = function (list, id) {
        if (list === null || list.length === 0) {
            return false;
        }
        var added = false;
        for (var i = 0; i < list.length; i++) {
            var item = list[i];
            if (item.id === id && $scope.department.authIdList.indexOf(item.id) === -1) {
                $scope.department.authIdList.push(item.id);
                $scope.addSubItems(item.subList);
                added = true;
                break;
            } else if ($scope.addIds(item.subList, id) && $scope.department.authIdList.indexOf(item.id) === -1) {
                $scope.department.authIdList.push(item.id);
                added = true;
                break;
            }
        }
        return added;
    };

    $scope.addSubItems = function(list){
        if(list === null || list.length === 0){
            return false;
        }
        for(var i = 0;i < list.length; i++){
            var item = list[i];
            $scope.department.authIdList.push(item.id);
            $scope.addSubItems(item.subList);
        }
    };

    $scope.findPosition = function(list,id){
        var position = -1;
        for(var i =0;i < list.length; i ++){
            if(id === list[i]){
                position = i;
                break;
            }
        }
        return position;
    };

    $scope.confirm = function(){
        if($scope.department.authIdList === null || $scope.department.authIdList.length === 0){
            $.gritter.add({
                title: '提示信息：',
                text: '请选择相应权限'
            });
            return false;
        }
        if($stateParams.id !== undefined){
            $http.put('/background/department/update',$scope.department).success(function (data) {
                $.gritter.add({
                    title: '提示信息：',
                    text: '更新成功'
                });
                $state.go('index.departmentMng');
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
            $http.post('/background/department/create',$scope.department).success(function (data) {
                $.gritter.add({
                    title: '提示信息：',
                    text: '更新成功'
                });
                $state.go('index.departmentMng');
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