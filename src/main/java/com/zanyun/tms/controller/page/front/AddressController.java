package com.zanyun.tms.controller.page.front;


import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.front.Address;
import com.zanyun.tms.interceptor.front.PageCheckRequired;
import com.zanyun.tms.interceptor.front.PageLoginType;
import com.zanyun.tms.mapper.AddressMapper;
import com.zanyun.tms.mapper.OwnerMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

import static com.zanyun.tms.constants.UrlConstants.*;
import static com.zanyun.tms.constants.WeChatSitLoginType.OWNER;

@Controller("AddressPageController")
@RequestMapping(value = PAGE_ADDRESS)
@PageCheckRequired
public class AddressController {
    private final Logger logger = LoggerFactory.getLogger(AddressController.class);

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private AddressMapper addressMapper;

    @Autowired
    private OwnerMapper ownerMapper;

    @RequestMapping(value = LIST, method = RequestMethod.GET)
    @PageLoginType(OWNER)
    public String list(ModelMap modelMap ) {
        List<Address> list = addressMapper.selectByOwnerId(sessionContext.getOwnerId());
        modelMap.put("list",list);
        modelMap.put("active", "address");
        modelMap.put("owner", ownerMapper.selectById(sessionContext.getOwnerId()));
        return getPath() + PAGE_OWNER + "/addressBook";
    }

    @RequestMapping(value = CREATE, method = RequestMethod.GET)
    @PageLoginType(OWNER)
    public String create(ModelMap modelMap) {
        modelMap.put("ownerId",sessionContext.getOwnerId());
        return getPath() + PAGE_OWNER + "/addressCreate";
    }

    @RequestMapping(value = UPDATE + "/{id}", method = RequestMethod.GET)
    @PageLoginType(OWNER)
    public String update(@PathVariable Integer id, ModelMap modelMap) {
        Address address = addressMapper.selectById(id);
        modelMap.put("address",address);
        return getPath() + PAGE_OWNER + "/addressUpdate";
    }

    private String getPath(){
        return sessionContext.getWeChatBrowser() ? PAGE_WECHAT : PAGE_WEB;
    }
}
