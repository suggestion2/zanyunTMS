adminApp.controller('uploadImageModal', function($scope, $uibModalInstance,$rootScope,FileUploader){
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
                $scope.fileName = new Date().getTime() + "" + Math.floor(Math.random() * 100) + "." + item.type.slice(item.type.lastIndexOf('/') + 1);
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
        $.gritter.add({
            title: '提示信息：',
            text: '上传成功！'
        });
        $uibModalInstance.close($rootScope.uploadParams.url + "/" + $scope.fileName);
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

    $scope.uploadImage = function(){
        if ($scope.localFile !== null) {
            $scope.localFile.upload();
        }else {
            $.gritter.add({
                title: '提示信息：',
                text: '请选择图片！'
            });
        }
    };
});