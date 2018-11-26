<#include "/common/headerWeb.ftl"/>
<#include "/common/navWeb.ftl"/>
<section class="main_section">
    <section class="contact_section center_section">
        <div class="container">
            <div class="row">
                <div class="panel panel_info">
                    <div class="panel-heading">
                        <h5 class="panel-title">人工询价</h5>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="contactImg text-center">
                                    <img src="/images/web/kefu.png">
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="contact-info">
                                    <h3>客服中心</h3>
                                    <p>如果您想询问某个订单价格或者您有任何疑问</p>
                                    <p>可拨打后台客服电话，可为您在线解答！</p>
                                    <p><label>邮箱：</label>15806929888@163.com</p>
                                    <p><label>电话：</label>0539-4395888&nbsp;&nbsp;15806929888</p>
                                    <a class="btn btn-danger contactBtn">联系客服</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</section>
<script>
    $(function () {
        $('.contactBtn').on('click',function () {
            if(navigator.userAgent.match(/(iPhone|iPod|Android|ios)/i)){
                tools.confirm('联系客服：05394395888',function () {
                    location.href('tel:05394395888');
                });
            }else{
                tools.confirm('联系客服：05394395888');
            }
        })
    })
</script>
<#include "/common/footerWeb.ftl"/>

