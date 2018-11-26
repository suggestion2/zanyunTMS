//图片预览
adminApp.directive('ngThumb', function ($window) {
    var helper = {
        isImage: function (file) {
            if(file === undefined || file.type == undefined){
                return false;
            }
            var type = '|' + file.type.slice(file.type.lastIndexOf('/') + 1) + '|';
            return '|jpg|png|jpeg|bmp|gif|pdf|'.indexOf(type) !== -1;
        }
    };

    return {
        restrict: 'A',
        template: '<canvas/>',
        link: function (scope, element, attributes) {
            console.log('draw canvas');
            var params = scope.$eval(attributes.ngThumb);

            if (!helper.isImage(params.file)) return;

            var canvas = element.find('canvas');
            var reader = new FileReader();

            reader.onload = onLoadFile;
            reader.readAsDataURL(params.file);

            function onLoadFile(event) {
                var img = new Image();
                img.onload = onLoadImage;
                img.src = event.target.result;
            }

            function onLoadImage() {
                var width = params.width || this.width / this.height * params.height;
                var height = params.height || this.height / this.width * params.width;
                canvas.attr({width: width, height: height});
                canvas[0].getContext('2d').drawImage(this, 0, 0, width, height);
            }
        }
    };
});


//权限验证
/*adminApp.directive('navAuth', function (navAuthList, syncService) {
    return {
        restrict: 'A',
        scope: {
            uri: '@uiSref',
            auth: '=ngShow'
        },
        link: function (scope, iElement, iAttrs) {
            scope.auth = 0;
            if (navAuthList.some(function (item) {
                    return item.uri !== undefined && item.uri.indexOf(scope.uri) > -1;
                })) scope.auth = 1;
        }
    };
});*/

//表单验证
var FLOAT_REGEXP = /^\-?\d+((\.|\,)\d+)?$/;
var PHONE_REGEXP = /^1[3-8]{1}\d{9}$/;
var REGEX_CHINESE = /^[\u4E00-\u9FA5]+$/;
var REGEX_IDCARD = /^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\d{4}((((19|20)?\d{2})(0[13-9]|1[012])(0[1-9]|[12]\d|30))|(((19|20)?\d{2})(0[13578]|1[02])31)|(((19|20)?\d{2})02(0[1-9]|1\d|2[0-8]))|((((19|20)?([13579][26]|[2468][048]|0[48]))|(2000))0229))\d{3}(\d|X|x)?$/;
var REGEX_EMAIL = /^[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?/;
var REGEX_BUSINESS = /^([0-9ABCDEFGHJKLMNPQRTUWXY]{2})(\d{6})([0-9ABCDEFGHJKLMNPQRTUWXY]{10})$/;

adminApp.directive('smartPattern', function () {
    return {
        require: 'ngModel',
        link: function (scope, elem, attr, ngModel) {
            //For DOM -> model validation
            var type = attr.smartPattern;
            var pattern = FLOAT_REGEXP;

            if ("float" === type) {
                pattern = FLOAT_REGEXP;
            }

            if ("phone" === type) {
                pattern = PHONE_REGEXP;
            }

            if ("chinese" === type) {
                pattern = REGEX_CHINESE;
            }

            if ("idCard" == type) {
                pattern = REGEX_IDCARD;
            }

            if ("email" == type) {
                pattern = REGEX_EMAIL;
            }

            if ("business" == type) {
                pattern = REGEX_BUSINESS;
            }

            ngModel.$parsers.unshift(function (value) {
                var valid = pattern.test(value);
                ngModel.$setValidity(type, valid);
                return valid ? value : undefined;
            });

            //For model -> DOM validation
            ngModel.$formatters.unshift(function (value) {
                ngModel.$setValidity(type, pattern.test(value));
                return value;
            });
        }
    };
});


//表单验证提示
adminApp.directive('attention', function () {
    return {
        restrict: 'E',
        replace: true,
        transclude: true,
        template: function (elem, attr) {
            return ('<div class="validatebox" ng-class="[{' + "'" + 'has-success' + "'" + ':' + attr.formName + '.' + attr.name + '.$dirty&&' + attr.formName + '.' + attr.name + '.$valid},{' + "'" + 'has-error' + "'" + ': ' + attr.formName + '.' + attr.name + '.$dirty&&' + attr.formName + '.' + attr.name + '.$invalid}]">'
                    //return '<div ng-class="[{' + "'" + 'has-success' + "'" + ':form.' + attr.name + '.$dirty&&form.' + attr.name + '.$valid},{' + "'" + 'has-error' + "'" + ': form.' + attr.name + '.$dirty&&form.' + attr.name + '.$invalid}]">'
                + '<div ng-transclude class="vinput"></div>'
                + '<div class="vresult error" ng-if="' + attr.formName + '.' + attr.name + '.$dirty&&' + attr.formName + '.' + attr.name + '.$invalid">'
                + '<span ng-if="' + attr.formName + '.' + attr.name + '.$error.required" class="help-block"><i class="fa fa-warning"></i> 不能为空</span>'
                + '<span ng-if="' + attr.formName + '.' + attr.name + '.$error.maxlength" class="help-block"><i class="fa fa-warning"></i> 最大长度为{{maxlength}}字</span>'
                + '<span ng-if="' + attr.formName + '.' + attr.name + '.$error.minlength" class="help-block"><i class="fa fa-warning"></i> 最小长度为{{minlength}}字</span>'
                + '<span ng-if="' + attr.formName + '.' + attr.name + '.$error.float" class="help-block"><i class="fa fa-warning"></i> 整数或小数</span>'
                + '<span ng-if="' + attr.formName + '.' + attr.name + '.$error.phone" class="help-block"><i class="fa fa-warning"></i> 手机号格式错误</span>'
                + '<span ng-if="' + attr.formName + '.' + attr.name + '.$error.customerExists" class="help-block"><i class="fa fa-warning"></i> 该信息用户已存在</span>'
                + '<span ng-if="' + attr.formName + '.' + attr.name + '.$error.chinese" class="help-block"><i class="fa fa-warning"></i> 含有非中文字符</span>'
                + '<span ng-if="' + attr.formName + '.' + attr.name + '.$error.idCard" class="help-block"><i class="fa fa-warning"></i> 身份证号格式错误</span>'
                + '<span ng-if="' + attr.formName + '.' + attr.name + '.$error.email" class="help-block"><i class="fa fa-warning"></i> 邮箱格式错误</span>'
                + '<span ng-if="' + attr.formName + '.' + attr.name + '.$error.business" class="help-block"><i class="fa fa-warning"></i> 企业证件格式错误</span>'
                + '</div>'
                + '<div class="vresult success"><span ng-if="' + attr.formName + '.' + attr.name + '.$dirty&&' + attr.formName + '.' + attr.name + '.$valid" class="help-block"><i class="fa fa-check"></i> 验证通过</span></div>'
                + '</div>');
        },
        link: function (scope, element, attrs) {
            if (attrs.maxlength !== undefined) {
                scope.maxlength = attrs.maxlength;
            }
            if (attrs.minlength !== undefined) {
                scope.minlength = attrs.minlength;
            }
        }
    };
});


//回车响应
adminApp.directive('myEnter', function () {
    return function (scope, element, attrs) {
        element.bind("keydown keypress", function (event) {
            if (event.which === 13) {
                scope.$apply(function () {
                    scope.$eval(attrs.myEnter);
                });
                event.preventDefault();
            }
        });
    };
});


//时间插件
adminApp.directive('ngTime',function () {
   return{
       restrict:'A',
       require : '?ngModel',
       link:function ($scope, $element, $attrs, $ngModel) {
           if(!$ngModel){
               return;
           }
           $('.form_datetime').datetimepicker({
               language:  'zh',
               weekStart: 1,
               todayBtn:  1,
               clearBtn : 1,
               autoclose: 1,
               todayHighlight: 1,
               startView: 2,
               forceParse: 0,
               showMeridian: 1
           });
           $('.form_date').datetimepicker({
               language:  'zh',
               weekStart: 1,
               todayBtn:  1,
               clearBtn : 1,
               autoclose: 1,
               todayHighlight: 1,
               startView: 2,
               minView: 2,
               forceParse: 0
           });
           $('.form_time').datetimepicker({
               language:  'zh',
               weekStart: 1,
               todayBtn:  1,
               autoclose: 1,
               todayHighlight: 1,
               startView: 1,
               minView: 0,
               maxView: 1,
               forceParse: 0
           });
           $('.form_mouth').datetimepicker({
               language:  'zh',
               weekStart: 1,
               autoclose: 1,
               startView: 3,
               minView: 3,
               forceParse: 0
           });
       }
   }
});

adminApp.directive('onFinishRender', function ($timeout) {
    return {
        restrict: 'A',
        link: function (scope, element, attr) {
            if (scope.$last === true) {
                $timeout(function () {
                    scope.$emit(attr.onFinishRender);
                });
            }
        }
    }
});