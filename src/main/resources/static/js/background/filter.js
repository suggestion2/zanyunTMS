/**
 * Created by user on 2016/3/29.
 */
adminApp.filter('navFilter', function () {
    return function (items, id) {
        var result = [];

        if (id === undefined) {
            return items;
        }

        function getParams(parentId){
            while (parentId !== 0 && parentId != id){
                angular.forEach(items, function (parent){
                    if(parent.id == parentId){
                        parentId = parent.parentId;
                    }
                });
            }
            return parentId == id;
        }

        angular.forEach(items, function (item) {
            if (getParams(item.parentId))
                result.push(item);
        });

        return result;
    }
});