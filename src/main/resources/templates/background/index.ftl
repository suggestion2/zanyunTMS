<!doctype html>
<html ng-app="adminApp" on-finish-render-filters>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="赵霞物流">
    <title>后台管理系统</title>
    <link href="/images/admin/favicon.ico" rel="icon" type="image/x-icon" />
    <link rel="stylesheet" href="/lib/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="/css/common/font-awesome.min.css" />
    <!-- Ionicons -->
    <link rel="stylesheet" href="/css/common/ionicons.min.css">

    <!-- Theme style -->
    <link rel="stylesheet" href="/css/admin/AdminLTE.css">
    <link rel="stylesheet" href="/lib/admin/gritter/css/jquery.gritter.css">
    <link rel="stylesheet" href="/css/admin/skin-blue.css">

    <link rel="stylesheet" href="/lib/datetimepicker/bootstrap-datetimepicker.css">
    <#--angular富文本编辑器-->
    <link rel="stylesheet" href="/lib/admin/textAngular/css/textAngular.css">
    <link rel="stylesheet" href="/lib/admin/textAngular/css/style.css">
    <link rel="stylesheet" href="/css/admin/style.css">
    <#--<link href="/css/company_cover.css" type="text/css" rel="stylesheet">-->

    <!-- adminTLE common -->
    <script src="/lib/jquery/jquery-2.1.4.js"></script>
    <script src="/lib/bootstrap/js/bootstrap.min.js"></script>
    <!-- adminTLE common end -->

    <script src="/lib/admin/nicescroll/jquery.nicescroll.js"></script>
    <script src="/lib/admin/angular-1.4.9/angular.min.js"></script>
    <script src="/lib/admin/angular-ui-router.js"></script>
    <script src="/lib/admin/ui-bootstrap-tpls-1.1.1.min.js" type="text/javascript"></script>

    <script src="/lib/admin/angular-file-upload/angular-file-upload.js" type="text/javascript"></script>
    <script src="/lib/admin/checklist-model/checklist-model.js"></script>
    <script src="/lib/admin/crypto/core-min.js"></script>
    <script src="/lib/admin/crypto/enc-base64-min.js"></script>
    <script src="/lib/admin/loading-bar/loading-bar.js"></script>
    <script src="/lib/admin/ng-table/ngTable.js"></script>
    <script src="/lib/admin/chart/echarts.min.js"></script>
    <script src="/lib/admin/gritter/js/jquery.gritter.js"></script>
    <#--时间选择器-->
    <script src="/lib/datetimepicker/bootstrap-datetimepicker.js"></script>
    <script src="/lib/datetimepicker/moment-with-locales.min.js"></script>

    <#--Angular富文本编辑器-->
    <script src="/lib/admin/textAngular/js/textAngular-rangy.min.js"></script>
    <script src="/lib/admin/textAngular/js/textAngular-sanitize.min.js"></script>
    <script src="/lib/admin/textAngular/js/textAngular.min.js"></script>

    <script src="http://api.map.baidu.com/api?v=2.0&ak=O0QSY8RvyTGiiOWwZVNkAaqeGS4YfIZC"></script>
    <#--图表-->
    <script src="/lib/chart/Chart.min.js"></script>
    <script src="/lib/chart/angular-chart.min.js"></script>

    <script src="/js/background/app.js"></script>
    <script src="/js/background/directive.js"></script>
    <script src="/js/background/service.js"></script>
    <#--页面控制器-->
    <script src="/js/background/controller/comCtrl.js"></script>
    <script src="/js/background/controller/userInfoCtrl.js"></script>
    <script src="/js/background/controller/departmentMngCtrl.js"></script>
    <script src="/js/background/controller/userMngCtrl.js"></script>
    <script src="/js/background/controller/driverMngCtrl.js"></script>
    <script src="/js/background/controller/ownerMngCtrl.js"></script>
    <script src="/js/background/controller/orderMngCtrl.js"></script>
    <script src="/js/background/controller/paymentMngCtrl.js"></script>
    <script src="/js/background/controller/transportationMngCtrl.js"></script>
    <script src="/js/background/controller/userLogMngCtrl.js"></script>
    <script src="/js/background/controller/advertisementMngCtrl.js"></script>
    <script src="/js/background/controller/bannerMngCtrl.js"></script>
    <script src="/js/background/controller/stationMngCtrl.js"></script>
    <script src="/js/background/controller/chartCtrl.js"></script>
    <script src="/js/background/controller/uploadImageModal.js"></script>
    <script src="/js/background/controller/noticeMngCtrl.js"></script>
    <script src="/js/background/controller/articleMngCtrl.js"></script>
    <script src="/js/background/controller/offlineOrderMngCtrl.js"></script>

    <!--[if lt IE 9]>
    <script src="/lib/admin/html5shiv.js"></script>
    <script src="/lib/admin/respond.min.js"></script>
    <![endif]-->
</head>
<body class="hold-transition skin-blue  sidebar-mini  fixed">
<section style="height: 100%;">
    <div class="wrapper" ui-view>

    </div>
</section>
<script src="/lib/admin/adminlte.js"></script>
</body>
</html>