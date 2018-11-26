(function(){
         var opt = {
            'type' : 1,
            'pageShow' : function(){},
            'pageHide' : function(){},
            'useShakeDevice' : {
                'speed' : 30,
                'callback' : function(){}
            },
            'useParallax' : true,
            'useArrow' : true,
            'useAnimation' : true,
            'useMusic' : {
                'autoPlay' : true,
                'loopPlay' : true,
                'src' : 'http://img.zxotms.com/web/bgmusic%20.mp3'
            }
         };
         window.H5FullscreenPage = {
            'init' : function(option){
                $.extend(opt,option);
                initDom(opt);
                initEvent(opt);
            }
         };
         
         var obj = {
             '1' : {
                 'upDrag' : function(percentage, item){
                     var translateY = 1 - 0.7*percentage;//浣嶇疆绯绘暟锛屽彲浠ュ井璋�
                     item.next().css('-webkit-transform', 'translate3d(0,'+translateY*100+'%,0)'); //涓嬩竴涓猧tem涓婄Щ鍔�
                 },
                 'downDrag' : function(percentage, item){
                     var translateY = -(0.7*percentage);
                     item.prev().css('-webkit-transform', 'translate3d(0,'+(translateY*100 - 100)+'%,0)');
                     item.css('-webkit-transform', 'translate3d(0,'+translateY*100+'%,0)');//褰撳墠item涓嬬Щ鍔�
                 },
                 'nextSlide' : function(item){
                     item.css('-webkit-transform', 'translate3d(0,-100%,0)'); 
                     item.next().css('-webkit-transform', 'translate3d(0,0,0)');
                 },
                 'prevSlide' : function(item){
                     item.prev().css('-webkit-transform', 'scale(1)'); 
                     item.css('-webkit-transform', 'translate3d(0,100%,0)'); 
                 },
                 'showSlide' : function(item){
                     item.css('-webkit-transform', 'scale(1)'); 
                     item.next().css('-webkit-transform', 'translate3d(0,100%,0)'); 
                 }
             },
             '2' : {
                 'upDrag' : function(percentage, item){
                     var scale = 1 - 0.2*percentage;//缂╂斁绯绘暟锛屽彲浠ュ井璋�
                     var translateY = 1 - 0.7*percentage;//浣嶇疆绯绘暟锛屽彲浠ュ井璋�
                     item.css('-webkit-transform', 'scale('+scale+')');//褰撳墠item缂╁皬
                     item.next().css('-webkit-transform', 'translate3d(0,'+translateY*100+'%,0)'); //涓嬩竴涓猧tem涓婄Щ鍔�
                 },
                 'downDrag' : function(percentage, item){
                     var scale = 0.8 - 0.2*percentage;
                     var translateY = -(0.7*percentage);
                     item.css('-webkit-transform', 'translate3d(0,'+translateY*100+'%,0)');//褰撳墠item涓嬬Щ鍔�
                     item.prev().css('-webkit-transform', 'scale('+scale+')');//鍓嶄竴涓猧tem鏀惧ぇ
                 },
                 'nextSlide' : function(item){
                     item.css('-webkit-transform', 'scale(.8)'); 
                     item.next().css('-webkit-transform', 'translate3d(0,0,0)');
                 },
                 'prevSlide' : function(item){
                     item.prev().css('-webkit-transform', 'scale(1)'); 
                     item.css('-webkit-transform', 'translate3d(0,100%,0)'); 
                 },
                 'showSlide' : function(item){
                     item.css('-webkit-transform', 'scale(1)'); 
                     item.next().css('-webkit-transform', 'translate3d(0,100%,0)'); 
                 }
             },
             '3' : {
                 'upDrag' : function(percentage, item){
                     var translateY = 1 - 0.4*percentage;//浣嶇疆绯绘暟锛屽彲浠ュ井璋�
                     item.css('-webkit-transform', 'translate3d(0,'+(translateY*100 - 100)+'%,0)');
                     item.next().css('-webkit-transform', 'translate3d(0,'+translateY*100+'%,0)'); //涓嬩竴涓猧tem涓婄Щ鍔�
                 },
                 'downDrag' : function(percentage, item){
                     var translateY = -(0.4*percentage);
                     item.prev().css('-webkit-transform', 'translate3d(0,'+(translateY*100 - 100)+'%,0)');
                     item.css('-webkit-transform', 'translate3d(0,'+translateY*100+'%,0)');//褰撳墠item涓嬬Щ鍔�
                 },
                 'nextSlide' : function(item){
                     item.css('-webkit-transform', 'translate3d(0,-100%,0)'); 
                     item.next().css('-webkit-transform', 'translate3d(0,0,0)');
                 },
                 'prevSlide' : function(item){
                     item.prev().css('-webkit-transform', 'scale(1)'); 
                     item.css('-webkit-transform', 'translate3d(0,100%,0)'); 
                 },
                 'showSlide' : function(item){
                     item.css('-webkit-transform', 'scale(1)'); 
                     item.next().css('-webkit-transform', 'translate3d(0,100%,0)'); 
                 }
             },
             '4' : {
                 'upDrag' : function(percentage, item){
                     var translateY = 1 - 0.4*percentage;//浣嶇疆绯绘暟锛屽彲浠ュ井璋�
                     item.css('-webkit-transform', 'translate3d(0,'+(translateY*100 - 100)+'%,0)');
                     item.next().css('-webkit-transform', 'translate3d(0,'+translateY*100+'%,0)'); //涓嬩竴涓猧tem涓婄Щ鍔�
                 },
                 'downDrag' : function(percentage, item){
                     var translateY = -(0.4*percentage);
                     item.prev().css('-webkit-transform', 'translate3d(0,'+(translateY*100 - 100)+'%,0)');
                     item.css('-webkit-transform', 'translate3d(0,'+translateY*100+'%,0)');//褰撳墠item涓嬬Щ鍔�
                 },
                 'nextSlide' : function(item){
                     item.addClass('zindex');
                     setTimeout(function(){
                         item.removeClass('no-animation').css('-webkit-transform', 'translate3d(0,-100%,0)');
                         item.next().removeClass('zindex').addClass('no-animation').css('-webkit-transform', 'translate3d(0,0,0)');
                     },100);
                     
                 },
                 'prevSlide' : function(item){
                     
                     item.prev().css('-webkit-transform', 'translate3d(0,0,0)'); 
                     item.next().css('-webkit-transform', 'translate3d(0,100%,0)'); 
                     item.removeClass('zindex');
                 },
                 'showSlide' : function(item){
                     item.css('-webkit-transform', 'scale(1)'); 
                     item.next().css('-webkit-transform', 'translate3d(0,100%,0)'); 
                 }
             }
         };
         var dragThreshold = 0.15; //涓寸晫鍊�
         var dragStart = null;//寮€濮嬫姄鍙栨爣蹇椾綅
         var percentage = 0;//鎷栧姩閲忕殑鐧惧垎姣�
         var currentItem;
          
         function touchStart(event) {
            if (dragStart !== null) return;
            var item = $(event.target).closest('.item');
             if (!item.length) {
                 $('.overlay').hide();
                 return;
             }
            if (event.touches) {
                event = event.touches[0];
            }
             //鎶撳彇鏃剁殑鎵€鍦ㄤ綅缃�
            dragStart = event.clientY;
            
             //鍒嗗埆鍏抽棴item鐨勫姩鐢绘晥鏋�,鍔ㄧ敾鏁堟灉鍙湪鏉惧紑鎶撳彇鏃跺嚭鐜�
            item.addClass('no-animation');
            item.next().addClass('no-animation');
            item.prev().addClass('no-animation');

         }
          
         function touchMove (event) {
             //console.log(33);
            //闃叉ios鎷栧姩浜嬩欢
            event.preventDefault();
            
            if (dragStart === null) return;
            var item = $(event.target).closest('.item');
             if (!item.length) {
                 $('.overlay').hide();
                 return;
             }
            if (event.touches) {
                event = event.touches[0];
            }
             //寰楀埌鎶撳彇寮€濮嬫椂浜庤繘琛屼腑鐨勫樊鍊肩殑鐧惧垎姣�
            percentage = (dragStart - event.clientY) / window.screen.height;//
             
            if (percentage > 0) {
                // //鍚戜笂鎷栧姩
                var scale = 1 - 0.5*percentage;//缂╂斁绯绘暟锛屽彲浠ュ井璋�
                // var translateY = 1 - 0.4*percentage;//浣嶇疆绯绘暟锛屽彲浠ュ井璋�
                // $(event.target).css('-webkit-transform', 'scale('+scale+')');//褰撳墠item缂╁皬
                // $(event.target).next().css('-webkit-transform', 'translateY('+translateY*100+'%)'); //涓嬩竴涓猧tem涓婄Щ鍔�
                 //$(event.target).css('opacity', ''+scale+'');//褰撳墠item缂╁皬
                 obj[opt.type].upDrag(percentage, item);
                 
            } else if (item.prev()) {
                //鍚戜笅鎷栧姩
                // var scale = 0.8 - 0.2*percentage;
                // var translateY = -(0.4*percentage);
                // $(event.target).css('-webkit-transform', 'translateY('+translateY*100+'%)');//褰撳墠item涓嬬Щ鍔�
                // $(event.target).prev().css('-webkit-transform', 'scale('+scale+')');//鍓嶄竴涓猧tem鏀惧ぇ
                 obj[opt.type].downDrag(percentage, item);
            }
            
         }
          
         function touchEnd (event) {
            //闃叉澶氭婊氬姩锛屾晠澧炲姞涓€涓鐩栧眰
            $('.overlay').show();
            dragStart = null;
            var item = $(event.target).closest('.item');
             if (!item.length) {
                 $('.overlay').hide();
                 return;
             }
            item.removeClass('no-animation');
            item.next().removeClass('no-animation');
            item.prev().removeClass('no-animation');
            
            //鎶撳彇鍋滄鍚庯紝鏍规嵁涓寸晫鍊煎仛鐩稿簲鍒ゆ柇
            if (percentage >= dragThreshold) {
                nextSlide(item);
            } else if ( Math.abs(percentage) >= dragThreshold ) {
                prevSlide(item);
            } else {
                showSlide(item);
            }
             //閲嶇疆percentage
            percentage = 0;

         }
         function swipeUp(event){
            var item = $(event.target).closest('.item');
            if (!item.length) {
                return;
            }
             nextSlide(item);
             //$(event.target).css('-webkit-transform', 'translateY(-101%)'); 
             //$(event.target).next().css('-webkit-transform', 'translateY(0)'); 
         }
         function swipeDown(event){
            var item = $(event.target).closest('.item');
            if (!item.length) {
                return;
            }
             prevSlide(item);
             //$(event.target).css('-webkit-transform', 'translateY(101%)'); 
             //$(event.target).prev().css('-webkit-transform', 'translateY(0)'); 
         }
         function nextSlide(item){
            //$(event.target).removeClass('parallax-item');
            //鎭㈠鍒板師鏍凤紝鎴栬€呭睍绀轰笅涓€item
            if (item.next().length) { 
                item.attr('state','prev');
                item.siblings('.item').removeAttr('state');
                
                currentItem = item.next();
                currentItem.attr('state','next');

                orderPart(item.next());
                obj[opt.type].nextSlide(item);
            } else {
                obj[opt.type].showSlide(item);
            }
            
         }
         function prevSlide(item){
            //$(event.target).removeClass('parallax-item');
            if (item.prev().length) {

                item.attr('state','prev');
                item.siblings('.item').removeAttr('state');
                currentItem = item.prev();
                currentItem.attr('state','next');
                obj[opt.type].prevSlide(item);
            } else {
                obj[opt.type].showSlide(item);
            }
            
         }
         function showSlide(item){
            //$(event.target).removeClass('parallax-item');
             obj[opt.type].showSlide(item);
         }
         function initDom(opt){
            $('body').addClass('H5FullscreenPage');
            currentItem = $('.item').first();
            currentItem.attr('state','next');
            if (opt.useAnimation) {
                var items = $('.item');
                items.find('.part').addClass('hide');
                orderPart(items.first());
            }
            $('body').append('<div class="overlay"></div>');
            if (opt.useArrow) {
                $('.item').slice(0,$('.item').length-1).append('<span class="arrow"></span>');
            }
            if (opt.useMusic) {
                var autoplay = opt.useMusic.autoPlay ? 'autoplay="autoplay"' : '';
                var loopPlay = opt.useMusic.loopPlay ? 'loop="loop"' : '';
                var src = opt.useMusic.src;
                $('body').append('<span class="music play"><audio id="audio" src='+src+' '+autoplay+' '+loopPlay+'></audio></span>');
            }
         }
         function orderPart(dom){
            var parts = $(dom).find('.part');
            parts.forEach(function(item){
                var time = $(item).attr('data-delay') || 100;
                setTimeout(function(){
                    $(item).removeClass('hide');
                },time);
            });
         }
         function initEvent(opt){
            if (opt.useParallax) {

                var orginData = {x:0,y:0};
                window.addEventListener('deviceorientation',function(event){
                    var gamma = event.gamma;
                    var beta = event.beta;

                    var x = -gamma;
                    var y = -beta;
                    
                    if (Math.abs(Math.abs(x) - Math.abs(orginData.x)) < 0.1 || Math.abs(Math.abs(y) - Math.abs(orginData.y)) < 0.1) {
                        orginData.x = x;
                        orginData.y = y;
                        return;
                    } else {
                        orginData.x = x;
                        orginData.y = y;
                    }
                    
                    var halfWidth = window.innerWidth / 2;  
                    var halfHeight = window.innerHeight / 2;  
                 
                    
                    var max = 5;
                    var items = $('.parallax');
                    items.forEach(function(item){
                        var dx = (item.getBoundingClientRect().width/max)*(x / halfWidth);
                        var dy = (item.getBoundingClientRect().width/max)*(y / halfHeight);
                        
                        if ($(item).hasClass('item')) {
                            //$(item).addClass('parallax-item');
                            dx = -dx/1 + 50;
                            dy = -dy/1 + 50;
                            item.style['background-position'] = ''+dx+'% '+dy+'%';
                            //$(item).removeClass('parallax-item');
                        } else {
                            item.style['transform'] = item.style['-webkit-transform'] = 'translate3d('+dx+'px,'+dy+'px,0)'; 
                        }
                    });
                }, false);
            }
            if (opt.useShakeDevice && opt.useShakeDevice.speed) {
                var x = y = z = lastX = lastY = lastZ = 0;
                if (window.DeviceMotionEvent) {
                        window.addEventListener('devicemotion',function(eventData){
                            var acceleration =event.accelerationIncludingGravity;
                                        x = acceleration.x;
                                        y = acceleration.y;
                                        z = acceleration.z;
                                        if(Math.abs(x-lastX) > opt.useShakeDevicespeed || Math.abs(y-lastY) > opt.useShakeDevicespeed || Math.abs(z-lastZ) > opt.useShakeDevicespeed) {
                                            //shake
                                            opt.useShakeDevice.callback && opt.useShakeDevice.callback(currentItem);
                                            
                                        }
                                        lastX = x;
                                        lastY = y;
                                        lastZ = z;
                        }, false);  
                    }
            }
            $('.music').on('tap',function(){
                $(this).toggleClass('play');
                var audio = document.getElementById('audio');
                if (audio.paused) {
                    audio.play();
                } else {
                    audio.pause();
                }
            });
            // 缁戝畾浜嬩欢
            $(document).on('touchmove', function(e){
                e.preventDefault();
            });
            if (opt.type > 4) {
                opt.type = opt.type - 4;
                $('.item').on({
                    'swipeUp': swipeUp,
                    'swipeDown': swipeDown
                });
            } else {
                $('.item').on({
                   'touchstart': touchStart,
                   'touchmove': touchMove,
                   'touchend': touchEnd,
                   'touchcancel': touchEnd
                });
            }
            
            $('.item').on('tap', function(){
                //瑕嗙洊灞傞殣钘�
                $('.overlay').hide();
            });
            $('.item').on('transitionend webkitTransitionEnd', function(event){
               //瑕嗙洊灞傞殣钘�
               $('.overlay').hide();
               //console.log($(event.target).attr('state'));
               if ($(event.target).attr('state') == 'next') {
                    opt.pageShow(event.target);
               } else {
                    opt.pageHide(event.target);
               }
               // opt.pageComplete(event.target);
               // debugger;
            });
            $('.overlay').on('tap', function(){
                //瑕嗙洊灞傞殣钘�
                $('.overlay').hide();
            });
         }
         
    })();