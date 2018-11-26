package com.zanyun.tms.controller.api.front;

import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.web.rest.exception.InvalidRequestException;
import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.front.Address;
import com.zanyun.tms.interceptor.front.OwnerLoginRequired;
import com.zanyun.tms.mapper.AddressMapper;
import com.zanyun.tms.request.front.*;
import com.zanyun.tms.view.front.AddressListView;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.*;

@RestController
@RequestMapping(API_ADDRESS)
public class AddressController {
    @Autowired
    private AddressMapper addressMapper;

    @Autowired
    private SessionContext sessionContext;

    @RequestMapping(value = LIST, method = RequestMethod.GET)
    @OwnerLoginRequired
    public AddressListView list() {
        AddressListView view = new AddressListView();
        view.setList(addressMapper.selectByOwnerId(sessionContext.getOwnerId()));

        return view;
    }

    @RequestMapping(value = CREATE, method = RequestMethod.POST)
    @OwnerLoginRequired
    public String create(@Valid @RequestBody AddressCreateForm form) {
        Map<String,Object> map = new HashMap<>();
        map.put("ownerId",sessionContext.getOwnerId());
        map.put("status",1);

        if(addressMapper.selectCount(map) >= 10){
            throw new InvalidRequestException("最多10个地址");
        }

        Integer primary = Objects.isNull(addressMapper.selectPrimary(sessionContext.getOwnerId())) ? 0 : 1;

        Address address = new Address();
        BeanUtils.copyProperties(form,address);
        address.setOwnerId(sessionContext.getOwnerId());
        address.setPrimary(primary);

        addressMapper.insert(address);

        return "success";
    }

    @RequestMapping(value = UPDATE, method = RequestMethod.PUT)
    @OwnerLoginRequired
    public String update(@Valid @RequestBody AddressUpdateForm form) {
        Address address = addressMapper.selectById(form.getId());

        if (Objects.isNull(address) || !address.getOwnerId().equals(sessionContext.getOwnerId())) {
            throw new ResourceNotFoundException("地址不存在");
        }

        BeanUtils.copyProperties(form,address);

        addressMapper.update(address);

        return "success";
    }

    @RequestMapping(value = DELETE, method = RequestMethod.DELETE)
    @OwnerLoginRequired
    public String update(@PathVariable Integer id) {
        Address address = addressMapper.selectById(id);

        if (Objects.isNull(address) || !address.getOwnerId().equals(sessionContext.getOwnerId())) {
            throw new ResourceNotFoundException("地址不存在");
        }

        addressMapper.deleteById(id);

        return "success";
    }
}
