<#include "/common/headerWechat.ftl"/>
<header class="bar bar-nav">
    <h3 class="title">赵霞专线</h3>
    <a href="javascript:;" onclick="javascript:history.back(-1);" class="goBack">
        <i class="fa fa-angle-left"></i>
    </a>
    <a href="/owner/center" class="userBtn">
        <i class="fa fa-user-circle-o"></i>
    </a>
</header>
<section class="content">
    <div class="content_body line_box">
        <p class="line_count text-center">3条物流专线</p>
        <ul class="lineList">
            <li class="weui-flex" data-id="0">
                <div class="car_img ">
                    <img src="/images/wechat/cars/car.jpg">
                </div>
                <div class="line_info weui-flex__item">
                    <h4 style="font-size: 14px"><span class="start">平邑县地方镇（赵霞物流）</span>  >>  <span class="end">临沂金兰物流园F1区113号</span></h4>
                    <p>#专线  #厢式货车 #每日发车</p>
                </div>
            </li>
            <li class="weui-flex" data-id="1">
                <div class="car_img ">
                    <img src="/images/wechat/cars/car2.jpg">
                </div>
                <div class="line_info weui-flex__item">
                    <h4 style="font-size: 14px"><span class="start">平邑县地方镇（赵霞物流）</span>  >>  <span class="end">东北专线（沈阳、长春、哈尔滨）</span></h4>
                    <p>#专线  #半挂  #每日发车</p>
                </div>
            </li>
            <li class="weui-flex" data-id="2">
                <div class="car_img ">
                    <img src="/images/wechat/cars/car2.jpg">
                </div>
                <div class="line_info weui-flex__item">
                    <h4 style="font-size: 14px"><span class="start">平邑县朝霞国际保税物流园</span>  >>  <span class="end">青岛、日照、连云港集装箱专线</span></h4>
                    <p>#专线  #厢式货车  #每日发车</p>
                </div>
            </li>
        </ul>
    </div>
</section>
<#--查看车辆图片-->
<div id="line_detail" class="weui-popup__container">
    <div class="weui-popup__overlay"></div>
    <div class="weui-popup__modal">
        <i class="closeBtn close-popup"></i>
        <div class="viewImgBox">
            <div class="view_title text-center">
                <h5>专线物流详情</h5>
            </div>
            <div class="view_body">
                <img src="" class="carImg">
                <div class="weui-form-preview">
                    <div class="weui-form-preview__bd" style="padding: 10px 0">
                        <div class="arr_item">
                            <div class="weui-form-preview__item add">
                                <label class="weui-form-preview__label">发货地址</label>
                                <span class="weui-form-preview__value"></span>
                            </div>
                            <div class="weui-form-preview__item num">
                                <label class="weui-form-preview__label">发货地联系方式</label>
                                <span class="weui-form-preview__value"></span>
                            </div>
                        </div>

                        <div class="dis_item" style="margin-top: 20px">
                            <div class="weui-form-preview__item add">
                                <label class="weui-form-preview__label">收货地址</label>
                                <span class="weui-form-preview__value"></span>
                            </div>
                            <div class="weui-form-preview__item num">
                                <label class="weui-form-preview__label">收货地联系方式</label>
                                <span class="weui-form-preview__value"></span>
                            </div>
                        </div>

                        <div class="other_item" style="margin-top: 20px">
                            <div class="weui-form-preview__item type">
                                <label class="weui-form-preview__label">车型</label>
                                <span class="weui-form-preview__value"></span>
                            </div>
                            <div class="weui-form-preview__item date">
                                <label class="weui-form-preview__label">周期</label>
                                <span class="weui-form-preview__value"></span>
                            </div>
                        </div>
                    </div>
                    <div class="weui-form-preview__ft">
                        <a class="weui-form-preview__btn weui-form-preview__btn_primary" style="color: #045684" onclick="call()" >联系客服，获取报价</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
        /*详情*/
        $(".lineList li").on('click',function () {
            var id=$(this).data('id');
            var src=$(this).find('.car_img img').attr('src');
            var start=$(this).find('.start').text();
            var end=$(this).find('.end').text();
            $('#line_detail .carImg').attr('src',src);
            $('.arr_item .add .weui-form-preview__value').text(start);
            $('.dis_item .add .weui-form-preview__value').text(end);

            if(id==0){
                $('.arr_item .num .weui-form-preview__value').html('0539-4395888<br>0539-4391162<br>13608992028<br>13165286769');
                $('.dis_item .num .weui-form-preview__value').html('0539-2772791<br>0539-2772792<br>13608992028<br>15806929888');
                $('.other_item .type .weui-form-preview__value').html('厢式货车');
                $('.other_item .date .weui-form-preview__value').html('每日发车');
            }else if(id==1){
                $('.arr_item .num .weui-form-preview__value').html('0539-4395888<br>0539-4391162<br>13608992028');
                $('.dis_item .num .weui-form-preview__value').html('15806929888<br>13165286769<br>15866991917');
                $('.other_item .type .weui-form-preview__value').html('半挂');
                $('.other_item .date .weui-form-preview__value').html('每日发车');
            }else if(id==2){
                $('.arr_item .num .weui-form-preview__value').html('0539-4395888<br>13608992028');
                $('.dis_item .num .weui-form-preview__value').html('15806929888<br>15854918866');
                $('.other_item .type .weui-form-preview__value').html('半挂');
                $('.other_item .date .weui-form-preview__value').html('每日发车');
            }
            $("#line_detail").popup();
        });
    });
    function call() {
        $.confirm({
            title: '确认拨打客服电话？',
            text: '您确定拨打客服热线tel：05394395888 ？',
            onOK: function () {
                window.location.href = "tel:05394395888";
            },
            onCancel: function () {}
        });
    }
</script>
<#include "/common/footerWechat.ftl"/>

