adminApp.controller('chart', function ($scope,$http) {
    $scope.labels = [];
    $scope.series = ['待发货','运输中','已到达'];

    $scope.paidCount = [];
    $scope.transportCount = [];
    $scope.completeCount = [];

    $scope.data = [
        $scope.paidCount,
        $scope.transportCount,
        $scope.completeCount
    ];

    $scope.labels1 = [];
    $scope.series1 = ['成交量'];
    $scope.data1 = [
        $scope.paidCount
    ];

    $scope.driverCount = [];
    $scope.ownerCount = [];

    $scope.labels2 = [];
    $scope.series2 = ['司机','货主'];
    $scope.data2 = [
        $scope.driverCount,
        $scope.ownerCount
    ];

    $scope.datasetOverride = [{
        yAxisID: 'y-axis-1'
    }];
    $scope.options = {
        scales: {
            yAxes: [
                {
                    id: 'y-axis-1',
                    type: 'linear',
                    display: true,
                    position: 'left',
                    ticks: {
                        beginAtZero: true
                    }
                }
            ]
        },
        elements: {
            line: {
                fill: false
            }
        }
    };

    $http.get('/background/common/report').success(function (data) {
        $scope.result1 = data.orderCountList;
        $scope.result2 = data.customerCountList;
        angular.forEach($scope.result1,function(value){
            $scope.labels.push(value.createTime);
            $scope.labels1.push(value.createTime);
            $scope.paidCount.push(value.paidCount);
            $scope.transportCount.push(value.transportCount);
            $scope.completeCount.push(value.completeCount);
        });

        angular.forEach($scope.result2,function(value){
            $scope.labels2.push(value.createTime);
            $scope.driverCount.push(value.driverCount);
            $scope.ownerCount.push(value.ownerCount);
        })
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


});