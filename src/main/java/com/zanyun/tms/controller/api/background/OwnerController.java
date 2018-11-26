package com.zanyun.tms.controller.api.background;

import com.sug.core.platform.exception.ResourceNotFoundException;
import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.front.Owner;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.OwnerMapper;
import com.zanyun.tms.request.background.OwnerListForm;
import com.zanyun.tms.request.background.UnbundledForm;
import com.zanyun.tms.view.background.OwnerListView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.ID;
import static com.zanyun.tms.constants.UrlConstants.LIST;

@RestController("OwnerBackgroundController")
@RequestMapping("/background/owner")
public class OwnerController {
    @Autowired
    private OwnerMapper ownerMapper;

    @Autowired
    private SessionContext sessionContext;

    @RequestMapping(value = LIST,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public OwnerListView list(@Valid @RequestBody OwnerListForm form){
        OwnerListView view = new OwnerListView();
        view.setList(ownerMapper.selectList(form.getQueryMap()));
        view.setCount(ownerMapper.selectCount(form.getQueryMap()));

        return view;
    }

    @RequestMapping(value = ID,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public Owner getById(@PathVariable Integer id){
        Owner owner = ownerMapper.selectById(id);
        if(Objects.isNull(owner)){
            throw new ResourceNotFoundException("货主不存在");
        }
        return owner;
    }

    @RequestMapping(value = "/unbundled",method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public String unbundled(@Valid @RequestBody UnbundledForm form){

        Owner owner = ownerMapper.selectByPhone(form.getPhone());
        if(Objects.isNull(owner)){
            throw new ResourceNotFoundException("账号不存在");
        }

        owner.setWechatPubOpenId(null);

        ownerMapper.update(owner);

        return "success";
    }
}
