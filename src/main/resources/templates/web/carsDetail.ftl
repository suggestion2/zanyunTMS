<#include "/common/headerWeb.ftl"/>
<#include "/common/navWeb.ftl"/>
<section class="main_section">
    <section class="center_section detail_section">
        <div class="container center_body">
            <div class="panel panel_info">
                <div class="panel-heading">
                    <h5 class="panel-title">车源详情</h5>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="carImg">
                                <img src="${carsView.dLicenseUrl?default('/images/web/no_img.png')}">
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <form class="form-horizontal detail_form" role="form">
                                <div class="form-group">
                                    <label class="col-xs-4">司机姓名：</label>
                                    <div class="col-xs-8 ">${carsView.name?default('暂无信息')}</div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4">车型：</label>
                                    <div class="col-xs-8 ">${carsView.model?default('暂无信息')}</div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4">驾龄：</label>
                                    <div class="col-xs-8 ">${carsView.drivingExp?default('暂无信息')}</div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4">所在地址：</label>
                                    <div class="col-xs-8 ">${(carsView.province+carsView.city+carsView.county)?default('暂无地址信息')}</div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-4">专线信息：</label>
                                    <div class="col-xs-8">
                                        <div style="color: #F31415;margin-bottom: 16px">专线1：<#if carsView.taskAddress1??&&carsView.taskAddress1!=''>${carsView.taskAddress1}<#else>（未填写）</#if>---<#if carsView.taskAddress2??&&carsView.taskAddress2!=''>${carsView.taskAddress2}<#else>（未填写）</#if></div>
                                        <div style="color: #F31415">专线2：<#if carsView.taskAddress3??&&carsView.taskAddress3!=''>${carsView.taskAddress3}<#else>（未填写）</#if>---<#if carsView.taskAddress4??&&carsView.taskAddress4!=''>${carsView.taskAddress4}<#else>（未填写）</#if></div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</section>
<#include "/common/footerWeb.ftl"/>

