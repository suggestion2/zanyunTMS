package com.zanyun.tms.controller.api.background;

import com.sug.core.platform.dingtalk.service.DingtalkCommonService;
import com.sug.core.platform.web.rest.exception.InvalidRequestException;
import com.sug.core.rest.view.SuccessView;
import com.zanyun.tms.context.background.SessionContext;
import com.zanyun.tms.domain.background.Department;
import com.zanyun.tms.domain.background.User;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.DepartmentAuthMapper;
import com.zanyun.tms.mapper.DepartmentMapper;
import com.zanyun.tms.mapper.UserMapper;
import com.zanyun.tms.request.background.DepartmentCreateForm;
import com.zanyun.tms.request.background.DepartmentListForm;
import com.zanyun.tms.request.background.DepartmentUpdateForm;
import com.zanyun.tms.view.background.DepartmentListView;
import com.zanyun.tms.view.background.DepartmentView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static com.zanyun.tms.constants.UrlConstants.*;

@RestController
@RequestMapping("/background/department")
public class DepartmentController {
    private static final Logger logger = LoggerFactory.getLogger(DepartmentController.class);

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private DepartmentMapper departmentMapper;

    @Autowired
    private DepartmentAuthMapper departmentAuthMapper;

    @Autowired
    private DingtalkCommonService dingtalkCommonService;

    @Autowired
    private UserMapper userMapper;

    @Value("${dingtalk.ownerId:@null}")
    private String ownerId;

    @RequestMapping(value = CREATE, method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    @Transactional
    public SuccessView create(@Valid @RequestBody DepartmentCreateForm form) {
        Department department = departmentMapper.selectByName(form.getName());
        if (Objects.nonNull(department)) {
            throw new InvalidRequestException("部门名称已被使用");
        }

        department = new Department();
        BeanUtils.copyProperties(form, department);
        department.setCreateBy(sessionContext.getUserId());
        department.setUpdateBy(sessionContext.getUserId());

        departmentMapper.insert(department);

        List<Integer> authIdList = form.getAuthIdList();
        authIdList.removeIf(Objects::isNull);

        authIdList = new ArrayList<>(new HashSet<>(authIdList));

        departmentAuthMapper.insert(department.getId(), authIdList);

        if (StringUtils.hasText(form.getChatName()) && StringUtils.hasText(ownerId)) {
            try {
                String chatId = dingtalkCommonService.createChat(form.getChatName(), ownerId,null);
                department.setChatName(form.getChatName());
                department.setDingChatId(chatId);
                departmentMapper.update(department);
            } catch (Exception e) {
                throw new InvalidRequestException("钉钉群创建失败", e);
            }
        }

        return new SuccessView();
    }

    @RequestMapping(value = UPDATE, method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    @Transactional
    public SuccessView update(@Valid @RequestBody DepartmentUpdateForm form) {
        Department department = departmentMapper.selectByName(form.getName());
        if (Objects.nonNull(department) && !department.getId().equals(form.getId())) {
            throw new InvalidRequestException("部门名称已被使用");
        }

        department = departmentMapper.selectById(form.getId());
        boolean dingChatChange = StringUtils.hasText(department.getChatName()) && !department.getChatName().equalsIgnoreCase(form.getChatName());

        BeanUtils.copyProperties(form, department);
        department.setUpdateBy(sessionContext.getUserId());
        departmentMapper.update(department);

        List<Integer> authIdList = form.getAuthIdList();
        authIdList.removeIf(Objects::isNull);

        authIdList = new ArrayList<>(new HashSet<>(authIdList));

        departmentAuthMapper.update(department.getId(), authIdList);
        if (StringUtils.hasText(form.getChatName())) {
            if (!StringUtils.hasText(department.getDingChatId())) {
                List<User> list = userMapper.selectListByDepartmentId(department.getId());
                List<String> userIdList = list.stream().map(User::getDingUserId).collect(Collectors.toList());
                try {
                    String chatId = dingtalkCommonService.createChat(form.getChatName(), ownerId,userIdList);
                    department.setChatName(form.getChatName());
                    department.setDingChatId(chatId);
                    departmentMapper.update(department);
                } catch (Exception e) {
                    throw new InvalidRequestException("钉钉群创建失败", e);
                }
            } else if (dingChatChange) {
                try {
                    dingtalkCommonService.updateChat(department.getDingChatId(), department.getChatName(), null,null);
                } catch (Exception e) {
                    throw new InvalidRequestException("钉钉群更名失败", e);
                }
            }
        }

        return new SuccessView();
    }

    @RequestMapping(value = LIST, method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public DepartmentListView list(@Valid @RequestBody DepartmentListForm form) {
        DepartmentListView view = new DepartmentListView();
        view.setList(departmentMapper.selectList(form.getQueryMap()));
        view.setCount(departmentMapper.selectCount(form.getQueryMap()));

        return view;
    }

    @RequestMapping(value = DETAIL + ID, method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public DepartmentView getById(@PathVariable Integer id) {
        return departmentMapper.selectViewById(id);
    }
}
