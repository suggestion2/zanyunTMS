adminApp.controller('paymentMngCtrl', function ($scope, $http, ngTableParams,$state) {
    $scope.search = {};
    $scope.search.pageIndex = 0;
    $scope.search.pageSize = 10;
    $scope.count = 0;

    $scope.status = 1;

    $scope.setStatus = function (status) {
        $scope.status = status;
        $scope.tableParams.filter().content = null;
        $scope.tableReload();
    };

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
                search.status = $scope.status;
                $http.post("/background/payment/list", search).success(function (data) {
                    params.total(data.count);
                    $defer.resolve(data.list);
                    $scope.count = data.count;
                });
            }
        }
    );

    $scope.refundForm = {
        paymentId :null,
        refundNum : null,
        remark : null
    };

    $scope.showRefund = function(id){
        $scope.refundForm.paymentId = id;
        $("#confirmModal").modal("show");
    };

    $scope.refund = function(){
        $http.put('/background/payment/refund' , $scope.refundForm).success(function (data) {
            $.gritter.add({
                title: '提示信息：',
                text: '创建退款成功'
            });
            $("#confirmModal").modal("hide");
            $scope.tableParams.reload();
            $scope.refundForm = {
                paymentId :null,
                refundNum : null,
                remark : null
            };
        }).error(function (data) {
            if(data.message !== undefined){
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
});