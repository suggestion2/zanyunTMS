package com.zanyun.tms.controller.page.background;

import com.sug.core.platform.exception.ResourceNotFoundException;
import com.zanyun.tms.domain.front.Order;
import com.zanyun.tms.mapper.OrderMapper;
import com.zanyun.tms.service.ExcelService;
import com.zanyun.tms.view.background.ViewExcel;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/background/document")
public class DocumentController {
    private final Logger logger = LoggerFactory.getLogger(DocumentController.class);

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private ExcelService excelService;

    @RequestMapping(value="/order/excel", method = RequestMethod.GET)
    public ModelAndView monthlyExcel(ModelMap model, String beginTime, HttpServletRequest request, HttpServletResponse response){
        Map<String,Object> query = new HashMap<>();

        if(!StringUtils.hasText(beginTime)){
            throw new ResourceNotFoundException("beginTime not found");
        }


        query.put("beginTime",beginTime);

        List<Order> orderList = orderMapper.selectList(query);

        try {
            HSSFWorkbook workbook = excelService.generateOrderExcel(orderList);
            ViewExcel viewExcel = new ViewExcel();
            viewExcel.buildExcelDocument(new HashMap<>(),workbook,request,response);
            return new ModelAndView(viewExcel,model);
        } catch (Exception e) {
            throw new RuntimeException("excel generate fail");
        }
    }

}
