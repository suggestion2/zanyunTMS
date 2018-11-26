package com.zanyun.tms.request.wechat;

import com.sug.core.platform.wechat.form.WeChatMsgData;

public class WeChatOrderMsgData extends WeChatMsgData{
    private WeChatMsgDataForm first;
    private WeChatMsgDataForm keyword1;
    private WeChatMsgDataForm keyword2;
    private WeChatMsgDataForm remark;

    public WeChatMsgDataForm getFirst() {
        return first;
    }

    public void setFirst(WeChatMsgDataForm first) {
        this.first = first;
    }

    public WeChatMsgDataForm getKeyword1() {
        return keyword1;
    }

    public void setKeyword1(WeChatMsgDataForm keyword1) {
        this.keyword1 = keyword1;
    }

    public WeChatMsgDataForm getKeyword2() {
        return keyword2;
    }

    public void setKeyword2(WeChatMsgDataForm keyword2) {
        this.keyword2 = keyword2;
    }

    public WeChatMsgDataForm getRemark() {
        return remark;
    }

    public void setRemark(WeChatMsgDataForm remark) {
        this.remark = remark;
    }
}
