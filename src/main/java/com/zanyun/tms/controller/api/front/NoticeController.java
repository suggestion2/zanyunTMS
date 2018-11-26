package com.zanyun.tms.controller.api.front;

import com.sug.core.platform.web.pagination.PaginationView;
import com.zanyun.tms.domain.background.Notice;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.NoticeMapper;
import com.zanyun.tms.request.background.NoticeListForm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;

import static com.zanyun.tms.constants.UrlConstants.*;

@RestController
@RequestMapping("/api/notice")
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

    @RequestMapping(value = ID,method = RequestMethod.GET)
    @LoginRequired
    @AuthRequired
    public Notice getById(@PathVariable Integer id){
        return noticeMapper.selectById(id);
    }
}
