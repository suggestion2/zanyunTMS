<#include "/common/headerWeb.ftl"/>
<div id="large-header" class="large-header">
    <h2 class="login_title">赵霞智慧物流</h2>
    <div class="login_box">
        <ul id="myTab" class="nav nav-tabs">
            <li class="col-xs-12 active"><a href="#selectAccType" data-toggle="tab" style="color: #333">请选择注册账号的类型</a>
        </ul>
        <div id="myTabContent" class="tab-content">
            <div class="tab-pane fade in active" id="selectAccType">
                <form class="form-horizontal type_box" role="form" id="selectType_form">
                    <label class="item item_type typeOne" for="type-1">
                        <input type="radio" class="visible hide" name="type" id="type-1" value="0">
                        <div class="type"><i></i>选择注册司机账号</div>
                    </label>
                    <label class="item item_type typeTwo" for="type-2">
                        <input type="radio" class="visible hide" name="type" id="type-2" value="1">
                        <div class="type"><i></i>选择注册货主账号</div>
                    </label>
                    <div class="item_submit">
                        <button href="javascript:;" type="button" class="btn btn-danger resLogBtn" onclick="next()">继续</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</div>
<script>
    var width,height,target;
    $(function () {
        /*背景图片 */
        initHeader();
        $(window).resize(function() {
            initHeader();
        });

        $(".item_type").on('click',function () {
            $(this).addClass('active').siblings().removeClass('active');
        });
    });

    function initHeader() {
        width=$(window).innerWidth();
        height=$(window).innerHeight();
        target={x:width/2,y:height/2}
        $(".large-header").css({'height':height+'px'});
    }
    /*继续*/
    function next() {
        var data=tools.hashToJson($("#selectType_form").serialize().substring(0).split("&"));
        if(data.type==0){
            tools.navigate("/driver/register");
        }else if(data.type==1){
            tools.navigate("/owner/register");
        }else{
            tools.msg("请选择账号类型！");
            return false;
        }
    }
</script>
</body>
</html>