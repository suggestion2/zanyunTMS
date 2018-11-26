var adminApp = angular.module('adminApp', ['ui.router', 'ui.bootstrap', 'chieffancypants.loadingBar', 'ngTable', 'angularFileUpload', 'textAngular','chart.js']);

//loading bar
adminApp.config(['cfpLoadingBarProvider', function (cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = false;
}]);
adminApp.config(function ($provide) {
    $provide.decorator('taOptions', ['taRegisterTool', '$delegate', '$uibModal', function (taRegisterTool, taOptions, $uibModal) {
        taRegisterTool('uploadImage', {
            buttontext: "上传图片",
            iconclass: "fa fa-image",
            action: function (deferred, restoreSelection) {
                $uibModal.open({
                    controller: 'uploadImageModal',
                    templateUrl: 'templates/uploadModal.html'
                }).result.then(
                    function (result) {
                        restoreSelection();
                        document.execCommand('insertImage', true, result);
                        deferred.resolve();
                    },
                    function () {
                        deferred.resolve();
                    }
                );
                return false;
            }
        });
        taOptions.toolbar[1].push('uploadImage');
        return taOptions;
    }]);
});
/**
 * 由于整个应用都会和路由打交道，所以这里把$state和$stateParams这两个对象放到$rootScope上，方便其它地方引用和注入。
 * 这里的run方法只会在angular启动的时候运行一次。
 * @param  {[type]} $rootScope
 * @param  {[type]} $state
 * @param  {[type]} $stateParams
 * @return {[type]}
 */
adminApp.run(function ($rootScope, $state, $stateParams, syncService) {
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;

    $rootScope.navList = [];
    $rootScope.uploadParams = {};

    $rootScope.$on("$stateChangeStart", function (event, toState, toParams, fromState) {
        syncService.uploadOpts(function (data) {
            $rootScope.uploadParams = data;
        });
        if (toState.checkAuth !== undefined && !toState.checkAuth) {
            return;
        } else if ($rootScope.navList.length === 0) {
            syncService.authNav(function (data) {
                $rootScope.navList = data.list;
                checkAuth($rootScope.navList, toState, event, fromState);
            });
        } else {
            checkAuth($rootScope.navList, toState, event, fromState);
        }
    });

    $rootScope.$on('$stateChangeSuccess', function(event, toState, toParams, fromState, fromParams){
        if(toState.name === "index"){
            $rootScope.$broadcast('goIndex');
        }

    });

    function checkAuth(list, toState, event, fromState) {
        if (list.some(function (item) {
                return item.uri !== undefined && item.uri === toState.name;
            })) {
            return;
        }
        event.preventDefault();

        $.gritter.add({
            title: '提示信息：',
            text: '无访问该页面权限'
        });
    }
});

/**
 * 配置路由。
 * 注意这里采用的是ui-router这个路由，而不是ng原生的路由。
 * ng原生的路由不能支持嵌套视图，所以这里必须使用ui-router。
 * @param  {[type]} $stateProvider
 * @param  {[type]} $urlRouterProvider
 * @return {[type]}
 */
adminApp.config(function ($stateProvider, $urlRouterProvider, $httpProvider) {
    //Defines a path that is used when an invalid route is requested.
    $urlRouterProvider.otherwise('/login/index');
    $stateProvider.state('login', {
        url: '/login/:returnUrl',
        views: {
            '': {
                templateUrl: '/templates/login.html'
            }
        },
        checkAuth: false
    }).state('initPwd', {
        url: '/initPwd/:returnUrl',
        views: {
            '': {
                templateUrl: '/templates/initPwd.html'
            }
        },
        checkAuth: false
    }).state('index', {
        url: '/index',
        views: {
            '': {
                templateUrl: '/templates/home.html'
            },
            'nav@index': {
                templateUrl: '/templates/nav.html'
            },
            'main@index': {
                templateUrl: '/templates/index.html'
            }
        },
        checkAuth: false
    }).state('index.home', {
        url: '/',
        views: {
            'main@index': {
                templateUrl: '/templates/index.html'
            }
        },
        checkAuth: false
    }).state('index.userInfo', {
        url: '/userInfo',
        views: {
            'main@index': {
                templateUrl: '/templates/userInfo.html'
            }
        },
        checkAuth: false
    }).state('index.departmentMng', {
        url: '/department/list',
        views: {
            'main@index': {
                templateUrl: '/templates/departmentMng.html'
            }
        },
        checkAuth: true
    }).state('index.userMng', {
        url: '/user/list',
        views: {
            'main@index': {
                templateUrl: '/templates/userMng.html'
            }
        },
        checkAuth: true
    }).state('index.userLogMng', {
        url: '/userLog/list',
        views: {
            'main@index': {
                templateUrl: '/templates/userLogMng.html'
            }
        },
        checkAuth: true
    }).state('index.driverMng', {
        url: '/driver/list',
        views: {
            'main@index': {
                templateUrl: '/templates/driverMng.html'
            }
        },
        checkAuth: true
    }).state('index.ownerMng', {
        url: '/owner/list',
        views: {
            'main@index': {
                templateUrl: '/templates/ownerMng.html'
            }
        },
        checkAuth: true
    }).state('index.validateOrder', {
        url: '/order/list/validate',
        views: {
            'main@index': {
                templateUrl: '/templates/orderMng.html'
            }
        },
        checkAuth: true
    }).state('index.unpaidOrder', {
        url: '/order/list/unpaid',
        views: {
            'main@index': {
                templateUrl: '/templates/orderMng.html'
            }
        },
        checkAuth: true
    }).state('index.transportOrder', {
        url: '/order/list/transport',
        views: {
            'main@index': {
                templateUrl: '/templates/orderMng.html'
            }
        },
        checkAuth: true
    }).state('index.completeOrder', {
        url: '/order/list/complete',
        views: {
            'main@index': {
                templateUrl: '/templates/orderMng.html'
            }
        },
        checkAuth: true
    }).state('index.doneOrder', {
        url: '/order/list/done',
        views: {
            'main@index': {
                templateUrl: '/templates/orderMng.html'
            }
        },
        checkAuth: true
    }).state('index.cancelOrder', {
        url: '/order/list/cancel',
        views: {
            'main@index': {
                templateUrl: '/templates/orderMng.html'
            }
        },
        checkAuth: true
    }).state('index.paymentMng', {
        url: '/payment/list',
        views: {
            'main@index': {
                templateUrl: '/templates/paymentMng.html'
            }
        },
        checkAuth: true
    }).state('index.insertDepartment', {
        url: '/department/create',
        views: {
            'main@index': {
                templateUrl: '/templates/departmentForm.html'
            }
        },
        checkAuth: true
    }).state('index.updateDepartment', {
        url: '/department/:id',
        views: {
            'main@index': {
                templateUrl: '/templates/departmentForm.html'
            }
        },
        checkAuth: true
    }).state('index.insertUser', {
        url: '/user/create',
        views: {
            'main@index': {
                templateUrl: '/templates/userForm.html'
            }
        },
        checkAuth: true
    }).state('index.updateUser', {
        url: '/user/:id',
        views: {
            'main@index': {
                templateUrl: '/templates/userForm.html'
            }
        },
        checkAuth: true
    }).state('index.driverForm', {
        url: '/driver/:id',
        views: {
            'main@index': {
                templateUrl: '/templates/driverForm.html'
            }
        },
        checkAuth: true
    }).state('index.orderForm', {
        url: '/order/:id',
        views: {
            'main@index': {
                templateUrl: '/templates/orderForm.html'
            }
        },
        checkAuth: true
    }).state('index.transportationMng', {
        url: '/transportation/list',
        views: {
            'main@index': {
                templateUrl: '/templates/transportationMng.html'
            }
        },
        checkAuth: true
    }).state('index.insertTransportation', {
        url: '/transportation/create',
        views: {
            'main@index': {
                templateUrl: '/templates/transportationForm.html'
            }
        },
        checkAuth: true
    }).state('index.transportationDetail', {
        url: '/transportation/:id',
        views: {
            'main@index': {
                templateUrl: '/templates/transportationForm.html'
            }
        },
        checkAuth: true
    }).state('index.advertisementMng', {
        url: '/advertisement/list',
        views: {
            'main@index': {
                templateUrl: '/templates/advertisementMng.html'
            }
        },
        checkAuth: true
    }).state('index.updateAdvertisement', {
        url: '/advertisement/:id',
        views: {
            'main@index': {
                templateUrl: '/templates/advertisementForm.html'
            }
        },
        checkAuth: true
    }).state('index.bannerMng', {
        url: '/banner/list',
        views: {
            'main@index': {
                templateUrl: '/templates/bannerMng.html'
            }
        },
        checkAuth: true
    }).state('index.updateBanner', {
        url: '/banner/:id',
        views: {
            'main@index': {
                templateUrl: '/templates/bannerForm.html'
            }
        },
        checkAuth: true
    }).state('index.stationMng', {
        url: '/station/list',
        views: {
            'main@index': {
                templateUrl: '/templates/stationMng.html'
            }
        },
        checkAuth: true
    }).state('index.insertStation', {
        url: '/station/create',
        views: {
            'main@index': {
                templateUrl: '/templates/stationForm.html'
            }
        },
        checkAuth: true
    }).state('index.updateStation', {
        url: '/station/:id',
        views: {
            'main@index': {
                templateUrl: '/templates/stationForm.html'
            }
        },
        checkAuth: true
    }).state('index.noticeMng', {
        url: '/notice/list',
        views: {
            'main@index': {
                templateUrl: '/templates/noticeMng.html'
            }
        },
        checkAuth: true
    }).state('index.insertNotice', {
        url: '/notice/create',
        views: {
            'main@index': {
                templateUrl: '/templates/noticeForm.html'
            }
        },
        checkAuth: true
    }).state('index.updateNotice', {
        url: '/notice/:id',
        views: {
            'main@index': {
                templateUrl: '/templates/noticeForm.html'
            }
        },
        checkAuth: true
    }).state('index.articleMng', {
        url: '/article/list',
        views: {
            'main@index': {
                templateUrl: '/templates/articleMng.html'
            }
        },
        checkAuth: true
    }).state('index.insertArticle', {
        url: '/article/create',
        views: {
            'main@index': {
                templateUrl: '/templates/articleForm.html'
            }
        },
        checkAuth: true
    }).state('index.updateArticle', {
        url: '/article/:id',
        views: {
            'main@index': {
                templateUrl: '/templates/articleForm.html'
            }
        },
        checkAuth: true
    }).state('index.financeChart', {
        url: '/finance',
        views: {
            'main@index': {
                templateUrl: '/templates/financeChart.html'
            }
        },
        checkAuth: true
    }).state('index.offlineOrderMng', {
        url: '/offlineOrder/list',
        views: {
            'main@index': {
                templateUrl: '/templates/offlineOrderMng.html'
            }
        },
        checkAuth: true
    }).state('index.insertOfflineOrder', {
        url: '/offlineOrder/create',
        views: {
            'main@index': {
                templateUrl: '/templates/offlineOrderForm.html'
            }
        },
        checkAuth: true
    }).state('index.updateOfflineOrder', {
        url: '/offlineOrder/:id',
        views: {
            'main@index': {
                templateUrl: '/templates/offlineOrderForm.html'
            }
        },
        checkAuth: true
    });

    $httpProvider.interceptors.push('httpRequestInterceptor');
});

adminApp.factory('httpRequestInterceptor', ['$q', '$location', '$injector', '$timeout', '$stateParams', function ($q, $location, $injector, $timeout, $stateParams) {

    return {
        'responseError': function (rejection) {
            if (rejection.status == 401) {

                console.log(rejection);

                if (rejection.data.errorCode.indexOf("UserLoginRequired") !== -1) {
                    if (window.location.hash.indexOf("login") === -1) {
                        var wordArray = CryptoJS.enc.Utf8.parse(window.location.hash);
                        $injector.get('$state').go("login", {"returnUrl": CryptoJS.enc.Base64.stringify(wordArray)});
                    }
                }
                else if (rejection.data.errorCode.indexOf("initPwdRequired") !== -1) {
                    if (window.location.hash.indexOf("initPwd") === -1) {
                        var wordArray = CryptoJS.enc.Utf8.parse(window.location.hash.indexOf("login") > -1 ? "index" : window.location.hash);
                        $injector.get('$state').go("initPwd", {"returnUrl": CryptoJS.enc.Base64.stringify(wordArray)});
                    }
                }

                /*if (window.location.hash.indexOf("login") == -1 ) {
                    var wordArray = CryptoJS.enc.Utf8.parse(window.location.hash);
                    $injector.get('$state').go("login", {"returnUrl" : CryptoJS.enc.Base64.stringify(wordArray)});

                }*/

            }
            else if (rejection.status == 500) {
                $.gritter.add({
                    title: "系统错误",
                    text: "系统错误, 请联系管理员"
                });
            }
            return $q.reject(rejection);
        }
    };
}]);
