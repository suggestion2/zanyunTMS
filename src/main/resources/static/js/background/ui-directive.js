adminApp.directive('fowPanel', function () {

    var arr = [];
    arr.push('<div class="panel edyd-panel-2">');
    arr.push('  <header class="panel-heading">');
    arr.push('{{title}}');
    arr.push('      <span class="tools pull-right">');
    arr.push('          <a href="javascript:;" ng-class="up?\'fa-chevron-down\' : \'fa-chevron-up\'" class="fa" ng-click="toggle($event);"></a>');
    arr.push('          <a href="javascript:;" class="fa fa-times" ng-click="onClose()"></a>');
    arr.push('      </span>');
    arr.push('  </header>');
    arr.push('  <div class="panel-body" style="display: block;" ng-transclude>');
    arr.push('  </div>');
    arr.push('</div>');

    return {
        scope: {
            onClose:'&',
            title:'@'
        },
        restrict: 'AE',
        template: arr.join(''),
        transclude : true,

        link: function (scope, elem, attrs, ctrl) {
            scope.up =false;

            scope.toggle = function(e){
                var el = $(e.target).parents(".panel").children(".panel-body");

                if(scope.up){
                    el.slideDown(200);
                }
                else{
                    el.slideUp(200);
                }
                scope.up = !scope.up;
            };


      /*      $(elem).find('.todo-check label').click(function () {
                $(this).parents('li').children('.todo-title').toggleClass('line-through');
            });*/

        }

    };
});