/**
 * Created by DreamTomb on 2017/2/23.
 */
import java.io.IOException;
import java.io.OutputStream;
import java.io.File;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;
public class GetEverythingPrepared {

    public static String LOGIN_URL = "http://sso.jwc.whut.edu.cn/Certification//login.do";

    private String cerlogin;
    private String jsessionid;
    private int content_length;

    public void login(String studyNumber, String password, String type) {

        String postContent = "systemId=&xmlmsg=&userName="+studyNumber+"&password="+password+"&type="+type+"&imageField.x=60&imageField.y=24";
        content_length = postContent.length();  //请求消息长度

        List<String> cookie = null;

        try {
            HttpURLConnection huc = (HttpURLConnection) new URL(LOGIN_URL).openConnection();
            huc.setDoOutput(true);
            huc.setRequestMethod("POST");
            huc.setReadTimeout(6000);
            loginSetRequestProperty(huc);

            OutputStream postOS = huc.getOutputStream();
            postOS.write(postContent.getBytes());

            Map<String, List<String>> headerFields = huc.getHeaderFields();
            cookie = headerFields.get("Set-Cookie");
            cerlogin = cookie.get(0);
            jsessionid = cookie.get(1);
        } catch (MalformedURLException e) {
            System.out.println("ERROR 1");
            e.printStackTrace();
        } catch (IOException e) {
            System.out.println("ERROR 2");
            e.printStackTrace();
        }
    }

    public String getCerlogin() {
//        System.out.println(cerlogin);
        return cerlogin;
    }

    public String getJsessionid() {
//        System.out.println(jsessionid);
        return jsessionid;
    }

    private void loginSetRequestProperty(HttpURLConnection huc) {
        huc.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
        huc.setRequestProperty("Accept-Encoding", "gzip, deflate");
        huc.setRequestProperty("Accept-Language", "zh-CN,zh;q=0.8");
        huc.setRequestProperty("Cache-Control", "max-age=0");
        huc.setRequestProperty("Connection", "keep-alive");
        huc.setRequestProperty("Content-Length", String.valueOf(content_length));
        huc.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        huc.setRequestProperty("Host", "sso.jwc.whut.edu.cn");
        huc.setRequestProperty("Origin", "http://sso.jwc.whut.edu.cn");
        huc.setRequestProperty("Referer", "http://sso.jwc.whut.edu.cn/Certification//toIndex.do");
        huc.setRequestProperty("Upgrade-Insecure-Requests", "1");
        huc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36");
    }

    public static void main(String[] args) {
        File file=new File("D:\\google download\\course_page.html");
        GetEverythingPrepared pre =new GetEverythingPrepared();
        pre.login("0121510870325","15140107151171","xs");
//        pre.login("0121510870311","19971023hanbk..","xs");
        Pages page=new Pages(pre.getCerlogin(),pre.getJsessionid());
        page.getCoursePage(file);
    }
}
