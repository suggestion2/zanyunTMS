package com.zanyun.tms.context.background;

import com.zanyun.tms.domain.background.Action;
import com.zanyun.tms.domain.background.Auth;
import com.zanyun.tms.domain.background.Nav;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Component("BackgroundSessionContext")
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

    public void setUserId(Integer userId){
        httpSession.setAttribute("userId",userId);
    }

    public Integer getUserId(){
        return httpSession.getAttribute("userId") == null ? null : (int)httpSession.getAttribute("userId");
    }

    public void setDepartmentId(Integer departmentId){
        httpSession.setAttribute("departmentId",departmentId);
    }

    public Integer getDepartmentId(){
        return httpSession.getAttribute("departmentId") == null ? null : (int)httpSession.getAttribute("departmentId");
    }

    public void setAdmin(boolean admin){
        httpSession.setAttribute("admin",admin);
    }

    public Boolean isAdmin(){
        return httpSession.getAttribute("admin") == null ? null : (boolean)httpSession.getAttribute("admin");
    }

    public void setAvailable(boolean available){
        httpSession.setAttribute("available",available);
    }

    public Boolean isAvailable(){
        return httpSession.getAttribute("available") == null ? null : (boolean)httpSession.getAttribute("available");
    }

    public void setNavList(List<Nav> list){
        httpSession.setAttribute("navList",list);
    }

    public List<Nav> getNavList(){
        return httpSession.getAttribute("navList") == null ? null : (ArrayList<Nav>)httpSession.getAttribute("navList");
    }

    public void setActionList(List<Action> list){
        httpSession.setAttribute("actionList",list);
    }

    public List<Action> getActionList(){
        return httpSession.getAttribute("actionList") == null ? null : (ArrayList<Action>)httpSession.getAttribute("actionList");
    }

    public void setAuthList(List<Auth> list){
        httpSession.setAttribute("authList",list);
    }

    public List<Auth> getAuthist(){
        return httpSession.getAttribute("authList") == null ? null : (ArrayList<Auth>)httpSession.getAttribute("authList");
    }
}
