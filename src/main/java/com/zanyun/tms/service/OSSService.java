package com.zanyun.tms.service;

import com.aliyun.oss.HttpMethod;
import com.aliyun.oss.OSSClient;
import com.aliyun.oss.model.GeneratePresignedUrlRequest;
import com.sug.core.platform.crypto.HMAC;
import com.sug.core.platform.json.JSONBinder;
import com.sug.core.util.EncodingUtils;
import com.zanyun.tms.domain.front.uploadParams.PolicyText;
import com.zanyun.tms.view.front.UploadParamsView;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
public class OSSService {

    @Value("${aliyun.upload.host}")
    private String host;

    @Value("${aliyun.upload.ads.host}")
    private String backgroundHost;

    @Value("${aliyun.appId}")
    private String appId;

    @Value("${aliyun.appKey}")
    private String appKey;

    @Value("${aliyun.upload.endPoint}")
    private String endPoint;

    @Value("${aliyun.upload.bucket}")
    private String bucket;

    private final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

    public UploadParamsView getUploadParams() throws Exception {
        UploadParamsView view = new UploadParamsView();

        String policy = getPolicy();
        view.setPolicy(policy);
        view.setUrl(host);
        view.setAppId(appId);
        view.setSignature(EncodingUtils.encryptBASE64(HMAC.encryptHMAC(policy.getBytes(),appKey)));

        return view;
    }

    public UploadParamsView getBackUploadParams() throws Exception {
        UploadParamsView view = new UploadParamsView();

        String policy = getPolicy();
        view.setPolicy(policy);
        view.setUrl(backgroundHost);
        view.setAppId(appId);
        view.setSignature(EncodingUtils.encryptBASE64(HMAC.encryptHMAC(policy.getBytes(),appKey)));

        return view;
    }

    private String getPolicy() throws Exception {
        PolicyText text = new PolicyText();
        text.setExpiration(setExpiration());
        List<Object> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();
        params.add("content-length-range");
        params.add(0);
        params.add(1048576000);
        list.add(params);
        text.setConditions(list);

        String test = JSONBinder.binder(PolicyText.class).toJSON(text);
        String base64 = EncodingUtils.encryptBASE64(test.getBytes("UTF-8"));
        return base64;
    }

    private String setExpiration(){
        Calendar calendar = Calendar.getInstance();

        calendar.add(Calendar.DAY_OF_MONTH,1);

        return dateFormat.format(calendar.getTime());
    }

    public String getImage(String key){
        OSSClient ossClient = new OSSClient(endPoint, appId, appKey);
        Date expiration = new Date(new Date().getTime() + 1000 * 60 * 30 );
        GeneratePresignedUrlRequest req = new GeneratePresignedUrlRequest(bucket, key, HttpMethod.GET);
        req.setExpiration(expiration);
        String image = ossClient.generatePresignedUrl(req).toString();
        ossClient.shutdown();
        return image;
    }

}
