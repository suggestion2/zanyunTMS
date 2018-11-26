package com.zanyun.tms.context.front;

import com.sug.core.platform.wechat.entity.WeChatOAuthEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import java.util.Objects;

@Component
public class SessionContext {
    private static final long CAPTCHA_EXPIRED_TIME = 120000L;

    @Autowired
    private HttpSession httpSession;

    public void invalidate(){
        httpSession.invalidate();
    }

    public void setCaptcha(String phone,String captcha){
        httpSession.setAttribute("captchaPhone",phone);
        httpSession.setAttribute("captcha",captcha);
        httpSession.setAttribute("captchaTime",System.currentTimeMillis());
    }

    public boolean validCaptcha(String phone,String captcha){
        return Objects.equals(httpSession.getAttribute("captchaPhone"),phone)
                && Objects.equals(httpSession.getAttribute("captcha"),captcha)
                && (long)httpSession.getAttribute("captchaTime") + CAPTCHA_EXPIRED_TIME > System.currentTimeMillis();
    }

    public void removeCaptcha(){
        httpSession.removeAttribute("captchaPhone");
        httpSession.removeAttribute("captcha");
    }

    public void setDriverId(Integer id){

        httpSession.setAttribute("driverId",id);
        httpSession.removeAttribute("ownerId");
    }

    public Integer getDriverId(){
        return Objects.isNull(httpSession.getAttribute("driverId")) ? null : (int)httpSession.getAttribute("driverId");
    }

    public void setOwnerId(Integer id){
        httpSession.setAttribute("ownerId",id);
        httpSession.removeAttribute("driverId");
    }

    public Integer getOwnerId(){
        return Objects.isNull(httpSession.getAttribute("ownerId")) ? null : (int)httpSession.getAttribute("ownerId");
    }

    public void setWeChatOAuthEntity(WeChatOAuthEntity entity){
        httpSession.setAttribute("weChatOAuthEntity",entity);
    }

    public WeChatOAuthEntity getWeChatOAuthEntity(){
        return (WeChatOAuthEntity)httpSession.getAttribute("weChatOAuthEntity");
    }

    public void setRemoteAddr(String remoteAddr){
        httpSession.setAttribute("remoteAddr",remoteAddr);
    }

    public String getRemoteAddr(){
        return (String)httpSession.getAttribute("remoteAddr");
    }

    public void setWeChatBrowser(boolean isWeChatBrowser){
        httpSession.setAttribute("isWeChatBrowser",isWeChatBrowser);
    }

    public Boolean getWeChatBrowser(){
        return Objects.isNull(httpSession.getAttribute("isWeChatBrowser")) ? null
                : (boolean)httpSession.getAttribute("isWeChatBrowser");
    }

    public void setPaymentId(Integer id){
        httpSession.setAttribute("paymentId",id);
    }

    public Integer getPaymentId(){
        return Objects.isNull(httpSession.getAttribute("paymentId")) ? null : (int)httpSession.getAttribute("paymentId");
    }

    public void setLedIndex(Integer index){
        httpSession.setAttribute("index",index);
    }

    public Integer getLedIndex(){
        if(Objects.isNull(httpSession.getAttribute("index"))){
            httpSession.setAttribute("index",0);
            return 0;
        }else {
            return (Integer) httpSession.getAttribute("index");
        }
    }
}
