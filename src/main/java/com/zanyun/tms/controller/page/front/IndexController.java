package com.zanyun.tms.controller.page.front;

import com.sug.core.platform.web.pagination.PaginationView;
import com.zanyun.tms.context.front.SessionContext;
import com.zanyun.tms.domain.background.Advertisement;
import com.zanyun.tms.domain.background.Article;
import com.zanyun.tms.domain.background.Banner;
import com.zanyun.tms.domain.background.Notice;
import com.zanyun.tms.domain.front.Driver;
import com.zanyun.tms.mapper.*;
import com.zanyun.tms.service.OSSService;
import com.zanyun.tms.view.front.TruckView;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import static com.zanyun.tms.constants.DriverConstant.DRIVER_COMPLETE;
import static com.zanyun.tms.constants.DriverConstant.DRIVER_INCOMPLETE;
import static com.zanyun.tms.constants.UrlConstants.PAGE_WEB;
import static com.zanyun.tms.constants.UrlConstants.PAGE_WECHAT;

@Controller
public class IndexController {
    private final Logger logger = LoggerFactory.getLogger(IndexController.class);

    @Autowired
    private DriverMapper driverMapper;

    @Autowired
    private NoticeMapper noticeMapper;

    @Autowired
    private ArticleMapper articleMapper;

    @Autowired
    private OSSService ossService;

    @Autowired
    private SessionContext sessionContext;

    @Autowired
    private OrderMapper orderMapper;

    @Autowired
    private OwnerMapper ownerMapper;

    @Autowired
    private AdvertisementMapper advertisementMapper;

    @Autowired
    private BannerMapper bannerMapper;

    @Value("${aliyun.upload.ads.host:@null}")
    private String adsHost;

    @RequestMapping(value = "/testTool", method = RequestMethod.GET)
    public String testTool(Map<String, Object> model, HttpServletRequest request) {
        model.put("request", request);
        return "testTool";
    }

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index(ModelMap modelMap) {
        List<Advertisement> advList = advertisementMapper.selectList(null);
        advList.forEach(a->a.setImageUrl(StringUtils.hasText(a.getImageUrl()) ? adsHost + "/" + a.getImageUrl() : null));
        modelMap.put("advertisementList",advList);

        List<Banner> bannerList = bannerMapper.selectList(null);
        bannerList.forEach(b->b.setBannerUrl(StringUtils.hasText(b.getBannerUrl()) ? adsHost + "/" + b.getBannerUrl() : null));
        modelMap.put("bannerList",bannerList);

        modelMap.put("carsView", getTruckViewList());
        modelMap.put("newsView", getArticleList());
        modelMap.put("noticesView", getNoticeList());
        return PAGE_WEB + "/index";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String webLogin() {
        if(Objects.nonNull(sessionContext.getDriverId())){
            Driver driver = driverMapper.selectById(sessionContext.getDriverId());
            if(driver.getStatus().equals(DRIVER_INCOMPLETE)){
                return "redirect:/driver/completeInfo";
            }
            return "redirect:/driver/center";
        }
        if(Objects.nonNull(sessionContext.getOwnerId())){
            return "redirect:/owner/center";
        }
        return PAGE_WEB + "/login";
    }

    //选择注册类型
    @RequestMapping(value = "/selectAccType", method = RequestMethod.GET)
    public String webSelectAccType() {
        return PAGE_WEB + "/selectAccType";
    }

    @RequestMapping(value = "/contact", method = RequestMethod.GET)
    public String webContact() {
        return PAGE_WEB + "/contact";
    }

    @RequestMapping(value = "/cooperation", method = RequestMethod.GET)
    public String webCooperations() {
        return PAGE_WEB + "/cooperation";
    }

    @RequestMapping(value = "/relation", method = RequestMethod.GET)
    public String webRelation() {
        return PAGE_WEB + "/relation";
    }

    @RequestMapping(value = "/specialLine", method = RequestMethod.GET)
    public String wechatSpecialLine() {
        return PAGE_WECHAT + "/specialLine";
    }
    @RequestMapping(value = "/productIntro", method = RequestMethod.GET)
    public String wechatProductIntro() {
        return PAGE_WECHAT + "/productIntro";
    }

    //分享
    @RequestMapping(value = "/share", method = RequestMethod.GET)
    public String wechatShare() {
        return PAGE_WECHAT + "/share";
    }


    @RequestMapping(value = "/helpCenter", method = RequestMethod.GET)
    public String helpCenter() {

        return getPath() + "/helpCenter";
    }

    @RequestMapping(value = "/404", method = RequestMethod.GET)
    public String Error404() {
        return "/404";
    }

    @RequestMapping(value = "/500", method = RequestMethod.GET)
    public String Error500() {
        return "/500";
    }


    @RequestMapping(value = "/news/list", method = RequestMethod.GET)
    public String newsList(ModelMap modelMap) {
        modelMap.put("newsView", getArticleList());
        modelMap.put("active","news");
        return getPath() + "/news";
    }

    @RequestMapping(value = "/notices/list", method = RequestMethod.GET)
    public String webNoticesList(ModelMap modelMap) {
        modelMap.put("noticesView", getNoticeList());
        modelMap.put("active","notices");
        return getPath() + "/news";
    }

    @RequestMapping(value = "/news/detail/{id}", method = RequestMethod.GET)
    public String news(@PathVariable Integer id, ModelMap modelMap) {
        Article article = articleMapper.selectById(id);
        if (Objects.nonNull(article)) {
            article.setReadCount(article.getReadCount() + 1);
            articleMapper.updateCount(article);
            article.setCoverImageUrl(StringUtils.hasText(article.getCoverImageUrl()) ? adsHost + "/" + article.getCoverImageUrl() : null);
        }
        modelMap.put("newsView", article);
        return getPath() + "/newsDetail";
    }

    @RequestMapping(value = "/notices/detail/{id}", method = RequestMethod.GET)
    public String notices(@PathVariable Integer id, ModelMap modelMap) {
        modelMap.put("noticesView", noticeMapper.selectById(id));
        return getPath() + "/noticeDetail";
    }
    //车源列表
    @RequestMapping(value = "/cars/list", method = RequestMethod.GET)
    public String webCarsList(ModelMap modelMap) {
        modelMap.put("carsView", getTruckViewList());

        return getPath() + "/cars";
    }
    //车源详情
    @RequestMapping(value = "/cars/detail/{id}", method = RequestMethod.GET)
    public String webCars(@PathVariable Integer id, ModelMap modelMap) {
        TruckView truckView = driverMapper.selectTruckViewById(id);
        if(Objects.nonNull(truckView)){
            truckView.setdLicenseUrl(StringUtils.hasText(truckView.getdLicenseUrl()) ? ossService.getImage(truckView.getdLicenseUrl()) : null);
        }
        modelMap.put("carsView",truckView );

        return getPath() + "/carsDetail";
    }

    private PaginationView<TruckView> getTruckViewList() {
        Map<String, Object> query = new HashMap<>();
        query.put("status",DRIVER_COMPLETE);
        query.put("startIndex", 0);
        query.put("pageSize", 10);

        PaginationView<TruckView> view = new PaginationView<>();
        List<TruckView> list = driverMapper.selectTruckViewList(query);
        list.forEach(v -> v.setdLicenseUrl(StringUtils.hasText(v.getdLicenseUrl()) ? ossService.getImage(v.getdLicenseUrl()) : null));
        view.setList(list);
        view.setCount(driverMapper.selectCount(query));

        return view;
    }

    private PaginationView<Article> getArticleList() {
        Map<String, Object> query = new HashMap<>();
        query.put("startIndex", 0);
        query.put("pageSize", 10);

        PaginationView<Article> view = new PaginationView<>();
        List<Article> list = articleMapper.selectList(query);
        list.forEach(a -> a.setCoverImageUrl(StringUtils.hasText(a.getCoverImageUrl()) ? adsHost + "/" + a.getCoverImageUrl() : null));
        view.setList(list);
        view.setCount(articleMapper.selectCount(query));
        return view;
    }

    private PaginationView<Notice> getNoticeList() {
        Map<String, Object> query = new HashMap<>();
        query.put("startIndex", 0);
        query.put("pageSize", 10);

        PaginationView<Notice> view = new PaginationView<>();
        view.setList(noticeMapper.selectList(query));
        view.setCount(noticeMapper.selectCount(query));
        return view;
    }

    private String getPath(){
        return sessionContext.getWeChatBrowser() ? PAGE_WECHAT : PAGE_WEB;
    }

    @RequestMapping(value = "/led", method = RequestMethod.GET)
    public String led(ModelMap modelMap) {

        /*Map<String, Object> map = new HashMap<>();
        map.put("status", VALIDATE_STATUS);
        map.put("startIndex",sessionContext.getLedIndex() * 10);
        map.put("pageSize",10);

        List<OrderUnpaidListView> list = orderMapper.selectUnpaidListView(map);
        int count = orderMapper.selectCount(map);

        if((sessionContext.getLedIndex() * 10 + 10) < count){
            sessionContext.setLedIndex(sessionContext.getLedIndex() + 1);
        }else {
            sessionContext.setLedIndex(0);
        }

        modelMap.put("list",list);
        modelMap.put("count",count);*/

        return "/led";
    }



}
