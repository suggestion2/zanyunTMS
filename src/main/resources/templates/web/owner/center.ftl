<#include "/common/ownerCenterHeaderWeb.ftl"/>
<#--<input value="${driverId}" class="hide driverId">-->
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
                        <h5>待接单</h5>
                        <p>${count.created}</p>
                    </div>
                    <span class="more" onclick="openList(0)">查看更多</span>
                </div>
            </li>
            <li class="col-sm-3 col-xs-6">
                <div class="order_li unOrder clearfix">
                    <div class="status_ico pull-left">
                        <img src="/images/web/unOrder.png">
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
                    <i class="status_ico pull-left">
                        <img src="/images/web/ordering.png">
                    </i>
                    <div class="status_data text-right pull-right">
                        <h5>运输中</h5>
                        <p>${count.transport}</p>
                    </div>
                    <span class="more" onclick="openList(4)">查看更多</span>
                </div>
            </li>
            <li class="col-sm-3 col-xs-6">
                <div class="order_li success clearfix">
                    <div class="status_ico pull-left">
                        <img src="/images/web/success.png">
                    </div>
                    <div class="status_data text-right pull-right">
                        <h5>全部订单</h5>
                        <p>${count.all}</p>
                    </div>
                    <span class="more" onclick="openList(10)">查看更多</span>
                </div>
            </li>
        </ul>
        <div class="center_tab">
            <ul class="nav nav-tabs">
                <li class="active">
                    <a href="#info" data-toggle="tab">个人资料</a>
                </li>
                <li>
                    <a href="#course" data-toggle="tab">货主网站使用教程</a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade in active" id="info">
                    <ul class="info_list">
                        <li class="item">
                            <label class="label_fix">登录账号：</label>
                            <span>${owner.phone}</span>
                        </li>
                        <li class="item">
                            <label class="label_fix">真实姓名：</label>
                            <span>${owner.name?default(owner.phone)}</span>
                        </li>
                        <li class="item">
                            <label class="label_fix">手机号码：</label>
                            <span>${owner.phone}</span>
                        </li>
                        <li>
                            <a class="btn btn-danger" href="/owner/center/setting">修改密码</a>
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
                            <li data-target="#webCourse" data-slide-to="6">7</li>
                            <li data-target="#webCourse" data-slide-to="7">8</li>
                            <li data-target="#webCourse" data-slide-to="8">9</li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="item active">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">1</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">请填写货主的手机号、手机验证码以及密码进行赵霞物流货主账号注册。如有登录账号可直接进入登录界面登录</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/owner/webStep-1.png" width="100%">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">2</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">根据已有账号，登录赵霞智慧物流平台，没有则前往注册</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/owner/webStep-2.png" width="100%">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">3</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">进入个人中心，点击创建运单，即可进行运单创建。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/owner/webStep-3.png" width="100%">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">4</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">第一步选择运单类型，分为企业主委托人和个体委托人两种类型。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/owner/webStep-4.png" width="100%">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">5</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">作为企业委托人则需要填写企业信息和委托人信息，个体则填写委托人信息。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/owner/webStep-5.png" width="100%">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">6</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">填写订车信息，发货地址弹窗中填写发货信息，卸货地址弹窗中填写卸货地址信息，完成所有信息填写后，提交认证，运单创建成功，等待后台人员审核。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/owner/webStep-6.png" width="100%">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">7</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">运单创建完成可查看订单详情，和联系客服了解订单审核进度。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/owner/webStep-7.png" width="100%">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">8</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">查看订单详情</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/owner/webStep-8.png" width="100%">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>PC端教程</span><span class="current">9</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">进入个人中心，可查看不同状态订单，以及修改个人信息等操作</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8">
                                        <img src="/images/web/course/owner/webStep-9.png" width="100%">
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
                            <li data-target="#wechatCourse" data-slide-to="5">9</li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="item active">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">1</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">微信搜索“赵霞智慧物流”，关注赵霞智慧物流微信公众号。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/owner/wechatStep-1.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">2</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">选择货主入口，选择“登录/注册”</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/owner/wechatStep-2.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">3</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">填写货主个人电话号码，以及收到的验证码，填写密码注册成为赵霞智慧物流货主，如果有账号前往登录页面直接登录。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/owner/wechatStep-3.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">4</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">填写已有的账号密码进行登录，如果没有则前往注册。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/owner/wechatStep-4.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">5</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">公众号页面选择创建运单，选择运单类型，有企业主委托，个体委托两种。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/owner/wechatStep-5.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">6</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">填写运单相关信息，企业填写企业信息以及委托人信息，个体填写委托人信息。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/owner/wechatStep-6.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">7</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">填写订车信息，发货地址弹窗中填写发货信息，卸货地址弹窗中填写卸货地址信息，完成所有信息填写后，提交认证，运单创建成功，等待后台人员审核。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/owner/wechatStep-7.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">8</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">创建完成后，可查看订单详情，路线规划等。</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/owner/wechatStep-8.png" height="400px">
                                    </div>
                                </div>
                            </div>
                            <div class="item ">
                                <div class="row">
                                    <div class="col-sm-4">
                                        <div class="carousel-text">
                                            <h2 class="carousel-t clearfix"><span>微信公众号教程</span><span class="current">9</span><span>/</span><span>9</span></h2>
                                            <p class="carousel-p">进入个人中心，可查看不同状态订单，以及修改个人信息等操作</p>
                                        </div>
                                    </div>
                                    <div class="col-sm-8 text-center">
                                        <img src="/images/web/course/owner/wechatStep-9.png" height="400px">
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
        tools.navigate('/owner/order/list/'+status);
    }
</script>
<#include "/common/centerFooterWeb.ftl"/>

