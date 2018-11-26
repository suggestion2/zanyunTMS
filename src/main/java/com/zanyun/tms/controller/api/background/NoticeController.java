package com.zanyun.tms.controller.api.background;

import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.web.pagination.PaginationView;
import com.sug.core.rest.view.SuccessView;
import com.zanyun.tms.domain.background.Notice;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.NoticeMapper;
import com.zanyun.tms.request.background.NoticeCreateForm;
import com.zanyun.tms.request.background.NoticeListForm;
import com.zanyun.tms.request.background.NoticeUpdateForm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Objects;

import static com.zanyun.tms.constants.UrlConstants.*;

@RestController("NoticeBackgroundController")
@RequestMapping("/background/notice")
public class NoticeController {
    private static final Logger logger = LoggerFactory.getLogger(NoticeController.class);

    @Autowired
    private NoticeMapper noticeMapper;

    @RequestMapping(value = LIST,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public PaginationView<Notice> list(@Valid @RequestBody NoticeListForm form){
        PaginationView<Notice> view = new PaginationView<>();
        view.setList(noticeMapper.selectList(form.getQueryMap()));
        view.setCount(noticeMapper.selectCount(form.getQueryMap()));
        return view;
    }

    @RequestMapping(value = DETAIL + ID,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public Notice getById(@PathVariable Integer id){
        return noticeMapper.selectById(id);
    }

    @RequestMapping(value = CREATE,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public SuccessView create(@Valid @RequestBody NoticeCreateForm form){
        Notice notice = new Notice();
        BeanUtils.copyProperties(form,notice);

        noticeMapper.insert(notice);

        return new SuccessView();
    }

    @RequestMapping(value = UPDATE,method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    public SuccessView update(@Valid @RequestBody NoticeUpdateForm form){
        Notice notice = noticeMapper.selectById(form.getId());

        if(Objects.isNull(notice)){
            throw new ResourceNotFoundException("notice is not exists");
        }
        BeanUtils.copyProperties(form,notice);

        noticeMapper.update(notice);

        return new SuccessView();
    }
}
