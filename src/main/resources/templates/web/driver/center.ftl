<#include "/common/driverCenterHeaderWeb.ftl"/>
<input value="${driverId}" class="hide driverId">
<div class="panel">
    <div class="panel-heading">
        <h5 class="panel-title"><i></i>会员中心</h5>
    </div>
    <div class="panel-body">
        <ul class="row order_list">
            <li class="col-sm-3 col-xs-6">
                <div class="order_li wait clearfix">
                    <div class="status_ico pull-left">
                        <img src="/images/web/wait.png">
                    </div>
                    <div class="status_data text-right pull-right">
                        <h5>待运输</h5>
                        <p>${count.accept}</p>
                    </div>
                    <span class="more" onclick="openList(3)">查看更多</span>
                </div>
            </li>
            <li class="col-sm-3 col-xs-6">
                <div class="order_li ordering clearfix">
                    <div class="status_ico pull-left">
                        <img src="/images/web/ordering.png">
                    </div>
                    <div class="status_data text-right pull-right">
                        <h5>运输中</h5>
                        <p>${count.transport}</p>
                    </div>
                    <span class="more" onclick="openList(4)">查看更多</span>
                </div>
            </li>
            <li class="col-sm-3 col-xs-6">
                <div class="order_li cancel clearfix">
                    <i class="status_ico pull-left">
                        <img src="/images/web/cancel.png">
                    </i>
                    <div class="status_data text-right pull-right">
                        <h5>订单取消</h5>
                        <p>${count.cancel}</p>
                    </div>
                    <span class="more" onclick="openList(-1)">查看更多</span>
                </div>
            </li>
            <li class="col-sm-3 col-xs-6">
                <div class="order_li success clearfix">
                    <div class="status_ico pull-left">
                        <img src="/images/web/success.png">
                    </div>
                    <div class="status_data text-right pull-right">
                        <h5>完成订单</h5>
                        <p>${count.complete}</p>
                    </div>
                    <span class="more" onclick="openList(5)">查看更多</span>
                </div>
            </li>
        </ul>
        <div class="center_tab">
            <ul class="nav nav-tabs">
                <li class="active">
                    <a href="#info" data-toggle="tab">个人资料</a>
                </li>
                <li >
                    <a href="#course" data-toggle="tab">司机使用教程</a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="info">
                    <ul class="info_list">
                        <li class="item">
                            <label class="label_fix">登录账号：</label>
                            <span>${driver.phone?default('')}</span>
                        </li>
                        <li class="item">
                            <label class="label_fix">真实姓名：</label>
                            <span>${driver.name?default('')}</span>
                        </li>
                        <li class="item">
                            <label class="label_fix">性别：</label>
                            <span>${driver.gender?default('')}</span>
                        </li>
                        <li class="item">
                            <label class="label_fix">手机号码：</label>
                            <span>${driver.phone?default('')}</span>
                        </li>
                        <li class="item">
                            <label class="label_fix">所在地址：</label>
                            <span>${driver.province?default('')+driver.city?default('')+driver.county?default('')}</span>
                        </li>
                        <li class="item">
                            <label class="label_fix">认证状态：</label>
                            <span class="status"><#if driver.status==3>认证已通过<#elseif driver.status==0>认证未通过，请<a href="/driver/completeInfo">重新填写认证信息</a><#else>认证申请已提交，待审核</#if></span>
                        </li>
                        <li>
                            <a class="btn btn-danger" href="/driver/center/setting">修改密码</a>
                        </li>
                    </ul>
                </div>
                <div class="tab-pane fade in courseTab " id="course">
                    <div id="webCourse" class="carousel slide show" data-tab="0">
                        <ol class="carousel-indicators">
                            <li data-target="#webCourse" data-slide-to="0" class="active">1</li>
                            <li data-target="#webCourse" data-slide-to="1">2</li>
                            <li data-target="#webCourse" data-slide-to="2">3</li>
                            <li data-target="#webCourse" data-slide-to="3">4</li>
                            <li data-target="#webCourse" data-slide-to="4">5</li>
                            <li data-target="#webCourse" data-slide-to="5">6</li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="item active">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">1</span><span>/</span><span>6</span></h2>
                                            <p class="carousel-p">请填写司机的手机号、手机验证码以及密码进行赵霞物流司机账号注册。如有登录账号可直接进入登录界面登录</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/driver/webStep-1.png" width="100%">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">2</span><span>/</span><span>6</span></h2>
                                            <p class="carousel-p">根据已有账号，登录赵霞智慧物流平台，如果是第一次登录，需要完成司机信息验证。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/driver/webStep-2.png" width="100%">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">3</span><span>/</span><span>6</span></h2>
                                            <p class="carousel-p">请如实填写司机本人信息，并上传驾驶证、行驶证以及车身照片，成功提交信息之后等待后台人员的信息验证！</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/driver/webStep-3.png" width="100%">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">4</span><span>/</span><span>6</span></h2>
                                            <p class="carousel-p">审核通过后，可进入货源大厅，进行抢单操作，点击“查看详情”之后可查看该货源的部分货源信息。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/driver/webStep-4.png" width="100%">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">5</span><span>/</span><span>6</span></h2>
                                            <p class="carousel-p">进入货源详情之后，点击“支付信息费并接单”，微信扫码支付完成后可查看货源全部信息（发货地、卸货地等），并可导航具体路线！</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/driver/webStep-5.png" width="100%">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">6</span><span>/</span><span>6</span></h2>
                                            <p class="carousel-p">进入个人中心，可查看个人信息，全部订单状态以及设置修改密码等。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/driver/webStep-6.png" width="100%">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a class="carousel-control left" href="#webCourse" data-slide="prev">&lsaquo;</a>
                        <a class="carousel-control right" href="#webCourse" data-slide="next">&rsaquo;</a>
                    </div>
                    <div id="wechatCourse" class="carousel slide" data-tab="1">
                        <ol class="carousel-indicators">
                            <li data-target="#wechatCourse" data-slide-to="0" class="active">1</li>
                            <li data-target="#wechatCourse" data-slide-to="1">2</li>
                            <li data-target="#wechatCourse" data-slide-to="2">3</li>
                            <li data-target="#wechatCourse" data-slide-to="3">4</li>
                            <li data-target="#wechatCourse" data-slide-to="4">5</li>
                            <li data-target="#wechatCourse" data-slide-to="5">6</li>
                            <li data-target="#wechatCourse" data-slide-to="5">7</li>
                            <li data-target="#wechatCourse" data-slide-to="5">8</li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="item active">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">1</span><span>/</span><span>8</span></h2>
                                            <p class="carousel-p">微信搜索“赵霞智慧物流”，关注赵智慧物流微信公众号。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/driver/wechatStep-1.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">2</span><span>/</span><span>8</span></h2>
                                            <p class="carousel-p">选择司机入口，选择“登录/注册”</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/driver/wechatStep-2.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">3</span><span>/</span><span>8</span></h2>
                                            <p class="carousel-p">填写司机个人电话号码，以及收到的验证码，填写密码注册成为赵霞智慧物流司机，如果有账号前往登录页面直接登录。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/driver/wechatStep-3.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">4</span><span>/</span><span>8</span></h2>
                                            <p class="carousel-p">填写已有的账号密码进行登录，如果没有则前往注册。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/driver/wechatStep-4.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">5</span><span>/</span><span>8</span></h2>
                                            <p class="carousel-p">第一次登录或者注册完毕需要完善司机个人信息，如实填写信息，上传驾驶证、行驶证和车辆照片等，提交认证，等待后台人员审核，审核通过即可接单。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/driver/wechatStep-5.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">6</span><span>/</span><span>8</span></h2>
                                            <p class="carousel-p">公众号进入货源大厅，点击可查看部分货源详情</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/driver/wechatStep-6.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">7</span><span>/</span><span>8</span></h2>
                                            <p class="carousel-p">详情里点击“支付信息费并接单”，支付完成即可完成抢单操作，可查看货源全部信息，包括发货地卸货地等，并可线路导航。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/driver/wechatStep-7.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">8</span><span>/</span><span>8</span></h2>
                                            <p class="carousel-p">进入个人中心，可查看个人信息，全部订单状态以及设置修改密码等。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/driver/wechatStep-8.png" height="400px">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a class="carousel-control left" href="#wechatCourse" data-slide="prev">&lsaquo;</a>
                        <a class="carousel-control right" href="#wechatCourse" data-slide="next">&rsaquo;</a>
                    </div>
                    <div class="courseNav">
                        <h4>司机使用教程</h4>
                        <ul class="nav">
                            <li class="active" data-id="0"><a>pc平台</a></li>
                            <li data-id="1"><a>微信公众号</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
        /*pc教程轮播*/
        $('#webCourse').carousel({
            interval: false,
            pause:true,
            wrap:false
        });
        /*wechat教程轮播*/
        $('#wechatCourse').carousel({
            interval: false,
            pause:true,
            wrap:false
        });
        $(".courseNav li").on('click',function () {
            $(this).addClass('active').siblings().removeClass('active');
            var tabId=$(this).attr('data-id');
            $('.carousel').each(function () {
                if($(this).data('tab')==tabId){
                    $(this).addClass('show').siblings().removeClass('show');
                }
            })

        })
    });
    function openList(status) {
        tools.navigate('/driver/order/list/'+status);
    }
</script>
<#include "/common/centerFooterWeb.ftl"/>

