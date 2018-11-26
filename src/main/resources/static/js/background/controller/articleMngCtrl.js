adminApp.controller('articleMngCtrl', function ($scope, $http, ngTableParams,$state) {
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
                $http.post("/background/article/list", search).success(function (data) {
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

adminApp.controller('articleFormCtrl', function ($scope, $http, $state, $stateParams,$rootScope,FileUploader) {

    $scope.article = {
        type : 1,
        status :1
    };

    if($stateParams.id !== undefined){
        $http.get('/background/article/detail/' + $stateParams.id).success(function (data) {
            $scope.article = data;
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
        $scope.article.status === 0 ? $scope.article.status++ : $scope.article.status--;
    };

    $scope.localFile = null;

    $scope.uploader1 = new FileUploader({
        url: $rootScope.uploadParams.url,
        queueLimit: 2
    });

    $scope.uploader1.filters.push({
        name: 'imageFilter',
        fn: function (item) {
            var type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|';
            var isImage = '|jpg|png|jpeg|'.indexOf(type) !== -1;
            if (isImage) {
                $scope.fileName = new Date().getTime() + "" + Math.floor(Math.random() * 100) + "." + item.type.slice(item.type.lastIndexOf('/') + 1);
            }
            return isImage;
        }
    });

    $scope.uploader1.filters.push({
        name: 'sizeFilter',
        fn: function (item) {
            return item.size <= 1024 * 1024;
        }
    });

    $scope.uploader1.onAfterAddingFile = function (fileItem) {
        $scope.uploader1.url = $rootScope.uploadParams.url;
        var opts = {
            'Filename': $scope.fileName,
            'key': $scope.fileName,
            'policy': $rootScope.uploadParams.policy,
            'OSSAccessKeyId': $rootScope.uploadParams.appId,
            'success_action_status': '200', //让服务端返回200,不然，默认会返回204
            'signature': $rootScope.uploadParams.signature
        };
        fileItem.formData.push(opts);

        $scope.localFile = fileItem;

        if ($scope.uploader1.queue.length > 1)
            $scope.uploader1.removeFromQueue(0);
    };

    $scope.uploader1.onSuccessItem = function () {
        $scope.localFile = null;
        $scope.uploader1.clearQueue();
        $.gritter.add({
            title: '提示信息：',
            text: '上传成功！'
        });
        $scope.article.coverImageUrl = $scope.fileName;
        $scope.send();
    };

    $scope.uploader1.onErrorItem = function (fileItem, response, status) {
        if (status == 401) {
            window.location = '/';
            return;
        }
        $.gritter.add({
            title: '提示信息：',
            text: '上传失败！'
        });
    };

    $scope.send = function(){
        if($stateParams.id === undefined || $stateParams.id === ""){
            $http.post('/background/article/create', $scope.article).success(function (data) {
                $.gritter.add({
                    title: '提示信息：',
                    text: '新增文章成功！'
                });
                $scope.article = {
                    type : 1,
                    status :1
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
            $http.put('/background/article/update', $scope.article).success(function (data) {
                $.gritter.add({
                    title: '提示信息：',
                    text: '编辑文章成功！'
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
    };

    $scope.confirm = function(){
        if($scope.localFile === null && $scope.article.coverImageUrl.indexOf("http") === -1){
            $.gritter.add({
                title: '提示信息：',
                text: '请选择封面图！'
            });
            return false;
        }
        if($scope.localFile !== null){
            $scope.localFile.upload();
        }else {
            $scope.send();
        }

    }
});
