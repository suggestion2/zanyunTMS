adminApp.controller('advertisementMngCtrl', function ($scope, $http, ngTableParams, $state) {

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
                $http.get("/background/advertisement/list").success(function (data) {
                    $defer.resolve(data.list);
                });
            }
        }
    );

});

adminApp.controller('advertisementFormCtrl', function ($scope, $http, $stateParams, $rootScope, FileUploader) {
    $scope.getById = function () {
        $http.get('/background/advertisement/detail/' + $stateParams.id).success(function (data) {
            $scope.advertisement = data;
            $scope.advertisement.imageUrl = $scope.advertisement.imageUrl === null ? null : $scope.advertisement.imageUrl + '?' + new Date().getTime();
            $scope.originFileName = "adv" + $stateParams.id;
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

    $scope.getById();

    $scope.localFile = null;

    $scope.uploader = new FileUploader({
        url: $rootScope.uploadParams.url,
        queueLimit: 2
    });

    $scope.uploader.filters.push({
        name: 'imageFilter',
        fn: function (item) {
            var type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|';
            var isImage = '|jpg|png|jpeg|'.indexOf(type) !== -1;
            if (isImage) {
                $scope.fileName = $scope.originFileName + "." + item.type.slice(item.type.lastIndexOf('/') + 1);
            }
            return isImage;
        }
    });

    $scope.uploader.filters.push({
        name: 'sizeFilter',
        fn: function (item) {
            return item.size <= 1024 * 1024;
        }
    });

    $scope.uploader.onAfterAddingFile = function (fileItem) {
        $scope.uploader.url = $rootScope.uploadParams.url;
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

        if ($scope.uploader.queue.length > 1)
            $scope.uploader.removeFromQueue(0);
    };

    $scope.uploader.onSuccessItem = function () {
        $scope.localFile = null;
        $scope.uploader.clearQueue();
        $scope.getById();
        $.gritter.add({
            title: '提示信息：',
            text: '上传成功！'
        });
    };

    $scope.uploader.onErrorItem = function (fileItem, response, status) {
        if (status == 401) {
            window.location = '/';
            return;
        }
        $.gritter.add({
            title: '提示信息：',
            text: '上传失败！'
        });
    };

    $scope.confirm = function () {
        $scope.advertisement.imageUrl = $scope.fileName;
        $http.put('/background/advertisement/update', $scope.advertisement).success(function (data) {
            $.gritter.add({
                title: '提示信息：',
                text: '更新成功！'
            });
            if ($scope.localFile !== null) {
                $scope.localFile.upload();
            }else {
                $scope.getById();
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
});

