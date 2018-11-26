package com.zanyun.tms.service;

import com.sug.core.platform.web.rest.exception.InvalidRequestException;
import com.zanyun.tms.domain.front.Order;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/10/21.
 */
@Service
public class ExcelService {

    public HSSFWorkbook generateOrderExcel(List<Order> list) throws Exception {
        InputStream inputStream = this.getClass().getResourceAsStream("/templates/excelTemplate/orderTemplate.xls");

        HSSFWorkbook hssfWorkbook = new HSSFWorkbook(inputStream);

        Sheet sheet = hssfWorkbook.getSheetAt(0);

        Row row = sheet.getRow(0);

        int first = row.getFirstCellNum();
        int last = row.getLastCellNum();

        if(first == last){
            throw new InvalidRequestException("ExcelTemplateError","excel模板为空");
        }

        for(int i = 0;i < list.size();i ++){
            row = sheet.getRow(i + 1);
            if(row == null){
                sheet.createRow(i + 1);
                row = sheet.getRow(i + 1);
            }
            setOrderCells(list.get(i),first,last,row);
        }

        return hssfWorkbook;
    }

    private void setOrderCells(Order order,Integer first,Integer last,Row row) throws Exception {
        List<String> list = generateOrderCellList(order);
        for(int i = first;i < last; i ++){
            Cell cell = row.getCell(i);
            if(cell == null){
                cell = row.createCell(i);
            }
            cell.setCellValue(list.get(i));
        }
    }

    private List<String> generateOrderCellList(Order order) throws Exception {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        DecimalFormat decimalFormat = new DecimalFormat("#.##");

        List<String> list = new ArrayList<>();
        list.add(order.getNumber());
        list.add(order.getOwnerName());
        list.add(order.getOwnerPhone());
        list.add(order.getOriProvince());
        list.add(order.getOriCity());
        list.add(order.getOriCounty());
        list.add(order.getArrProvince());
        list.add(order.getArrCity());
        list.add(order.getArrCounty());
        list.add(simpleDateFormat.format(order.getLoadTime()));
        list.add(decimalFormat.format(order.getCargoValue()) + "元");
        list.add(decimalFormat.format(order.getOwnerFreight()) + "元");
        list.add(simpleDateFormat.format(order.getCreateTime()));

        return list;
    }
}
