package com.zanyun.tms.controller.api.background;


import com.sug.core.platform.exception.ResourceNotFoundException;
import com.sug.core.platform.web.rest.exception.InvalidRequestException;
import com.sug.core.rest.view.SuccessView;
import com.zanyun.tms.context.background.SessionContext;
import com.zanyun.tms.domain.front.Payment;
import com.zanyun.tms.interceptor.background.AuthRequired;
import com.zanyun.tms.interceptor.background.LoginRequired;
import com.zanyun.tms.mapper.PaymentMapper;
import com.zanyun.tms.request.background.PaymentListForm;
import com.zanyun.tms.request.background.PaymentRefundForm;
import com.zanyun.tms.view.background.PaymentListView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.Map;
import java.util.Objects;

import static com.zanyun.tms.constants.PaymentConstants.*;
import static com.zanyun.tms.constants.UrlConstants.*;

@RestController("PaymentBackgroundController")
@RequestMapping("/background/payment")
public class PaymentController {
    @Autowired
    private PaymentMapper paymentMapper;

    @Autowired
    private SessionContext sessionContext;

    @RequestMapping(value = LIST,method = RequestMethod.POST)
    @LoginRequired
    @AuthRequired
    public PaymentListView list(@Valid @RequestBody PaymentListForm form){
        PaymentListView view = new PaymentListView();
        Map<String,Object> map = form.getQueryMap();
        view.setList(paymentMapper.selectList(map));
        view.setCount(paymentMapper.selectCount(map));

        return view;
    }

    @RequestMapping(value = ID,method = RequestMethod.GET)
    @LoginRequired
    public Payment getById(@PathVariable Integer id){
        return paymentMapper.selectById(id);
    }

    @RequestMapping(value = REFUND,method = RequestMethod.PUT)
    @LoginRequired
    @AuthRequired
    @Transactional
    public SuccessView refund(@RequestBody @Valid PaymentRefundForm form){

        Payment payment = paymentMapper.selectById(form.getPaymentId());
        if(Objects.isNull(payment)){
            throw new ResourceNotFoundException("payment not found");
        }
        if(!payment.getStatus().equals(PAID_STATUS)){
            throw new InvalidRequestException("invalid status");
        }
        payment.setStatus(REFUND_STATUS);
        payment.setRefundNum(form.getRefundNum());
        payment.setRemark(form.getRemark());
        payment.setUpdateBy(sessionContext.getUserId());

        paymentMapper.update(payment);

        return new SuccessView();
    }
}
