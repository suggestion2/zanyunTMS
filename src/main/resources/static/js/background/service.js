adminApp.service('httpService', ['$http', 'cfpLoadingBar', function ($http, cfpLoadingBar) {
    //loading加载的方法见js文件的解释  /framework/adminEX/js/mask.js
    function buildSuccess(success) {
        if (success !== null) {
            success.message = success.message === null ? '操作' : success.message;
            success.title = success.title === null ? '操作成功' : success.title;
            success.prompts = success.prompts === null ? false : success.prompts;
        }
    }

    function buildError(error) {
        if (error !== null) {
            error.message = error.message === null ? '操作' : error.message;
            error.title = error.title === null ? '操作失败' : error.title;
            error.prompts = error.prompts === null ? true : error.prompts;
        }
    }

    function successFunc(success) {
        buildSuccess(success);

        if (success.prompts) {
            $.gritter.add({
                title: success.title,
                text: success.message
            });
        }

        if (success !== null && success.execute) {
            success.execute();
        }
        cfpLoadingBar.complete();
    }

    function errorFunc(error) {
        buildError(error);

        if (error.prompts) {
            $.gritter.add({
                title: error.title,
                text: error.message
            });
        }


        if (error !== null && error.execute) {
            error.execute();
        }
        cfpLoadingBar.complete();
    }

    this.get = function (uri, success, error) {
        cfpLoadingBar.start();
        $http.get(uri).success(function () {

            successFunc(success);
        }).error(function () {

            errorFunc(error);
        });
    };

    this.post = function (uri, form, success, error) {
        cfpLoadingBar.start();
        $http.post(uri, form).success(function () {

            successFunc(success);
        }).error(function () {

            errorFunc(error);
        });
    };

    this.put = function (uri, form, success, error) {
        cfpLoadingBar.start();
        $http.put(uri, form).success(function () {

            successFunc(success);
        }).error(function () {

            errorFunc(error);
        });
    };

    this.delete = function (uri, success, error) {
        cfpLoadingBar.start();
        $http.delete(uri).success(function () {
            successFunc(success);

        }).error(function () {

            errorFunc(error);
        });
    };

}]);

adminApp.service('syncService', ['$http', '$q',function ($http, $q) {
    this.authNav = function (callback) {
        var deferred = $q.defer();//声明承诺
        $http.get("/background/nav/list").success(function (data) {
            callback(data);
            deferred.resolve(data);//请求成功
        }).error(function (data) {
            deferred.reject(data); //请求失败
        });
        return deferred.promise;   // 返回承诺
    };
    this.uploadOpts = function (callback) {
        var deferred = $q.defer();//声明承诺
        $http.get("/background/common/uploadParams").success(function (data) {
            callback(data);
            deferred.resolve(data);//请求成功
        }).error(function (data) {
            deferred.reject(data); //请求失败
        });
        return deferred.promise;   // 返回承诺
    };
}]);

/*adminApp.service('fileService', function () {
    this.getFileName = function () {
        var currentTime = new Date();

        var dateStr = padStr(currentTime.getFullYear()) +
            padStr(1 + currentTime.getMonth()) +
            padStr(currentTime.getDate()) +
            padStr(currentTime.getHours()) +
            padStr(currentTime.getMinutes()) +
            padStr(currentTime.getSeconds()) + Math.floor((Math.random() * 10000) + 1);

        return dateStr;
    };

    function padStr(i) {
        return (i < 10) ? "0" + i : "" + i;
    }
});

adminApp.service('dateFormatService', function () {
    this.getFormatString = function (date) {
        Date.prototype.yyyymmdd = function () {
            var yyyy = this.getFullYear().toString();
            var mm = (this.getMonth() + 1).toString(); // getMonth() is zero-based
            var dd = this.getDate().toString();
            return yyyy + "-" + (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]) + " 00:00:00"; // padding
        };
        return date.yyyymmdd();
    };
});

adminApp.service('verifyService', function () {
    this.verifyString = function (data) {
        return data !== undefined && data !== null && data !== "";
    };
});

adminApp.service('syncService', ['$http', '$q', 'navAuthList','uploadOpt',function ($http, $q,navAuthList,uploadOpt) {

    this.authNav = function () {
        var deferred = $q.defer();//声明承诺
        $http.get("/adminNavigation").success(function (data) {
            angular.extend(navAuthList,data);
            deferred.resolve(data);//请求成功
        }).error(function (data) {
            deferred.reject(data); //请求失败
        });
        return deferred.promise;   // 返回承诺
    };
    this.uploadOpts = function () {
        var deferred = $q.defer();//声明承诺
        $http.get("/uploadParams").success(function (data) {
            angular.extend(uploadOpt,data);
            deferred.resolve(data);//请求成功
        }).error(function (data) {
            deferred.reject(data); //请求失败
        });
        return deferred.promise;   // 返回承诺
    };
}]);

adminApp.service('sortingService', function () {
    this.getSorting = function (data) {

        var arr = [];
        var keys = Object.keys(data);
        for(var k = 0; k < keys.length;k ++){
            var key = keys[k];
            var value = data[key];
            arr.push(key + " " + value);
        }

        return arr;
    };
});*/
