import java.io.*;
import java.net.MalformedURLException;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * Created by DreamTomb on 2017/2/23.
 */

public class Pages {

    private String cerlogin;
    private String jsessionid;

    private String JSESSION_TRANS;
    private String LOCATION_TRANS;

    public Pages(String cerlogin, String jsessionid) {
        this.cerlogin = cerlogin;
        this.jsessionid = jsessionid;
    }

    public void getCourseRootPage() {
        try {
            URL courseURL = new URL("http://202.114.90.180/Course");
            HttpURLConnection.setFollowRedirects(false);
            HttpURLConnection huc = (HttpURLConnection) courseURL.openConnection();
            courseSetRequestProperty(huc);

            InputStream is = huc.getInputStream();
            String location = huc.getHeaderField("Location");

            URL courseURL2 = new URL(location);
            HttpURLConnection huc2 = (HttpURLConnection) courseURL2.openConnection();
            courseSetRequestProperty(huc2);

            InputStream is2 = huc2.getInputStream();
            String location2 = huc2.getHeaderField("Location");
            String JSESSIONcookie = huc2.getHeaderField("Set-Cookie").split(";")[0];
            JSESSION_TRANS = JSESSIONcookie;

            URL courseURL3 = new URL(location2);
            HttpURLConnection huc3 = (HttpURLConnection) courseURL3.openConnection();
            courseSetRequestProperty(huc3);
            huc3.setRequestProperty("Cookie", cerlogin.split(";")[0]);

            InputStream is3 = huc3.getInputStream();
            String location3 = huc3.getHeaderField("Location");

            URL courseURL4 = new URL(location3);
            HttpURLConnection huc4 = (HttpURLConnection) courseURL4.openConnection();
            courseSetRequestProperty(huc4);
            huc4.setRequestProperty("Cookie", jsessionid.split(";")[0]+";"+cerlogin.split(";")[0]);

            InputStream is4 = huc4.getInputStream();
            String location4 = huc4.getHeaderField("Location");
            LOCATION_TRANS = location4;

            URL courseURL5 = new URL(location4);
            HttpURLConnection huc5 = (HttpURLConnection) courseURL5.openConnection();
            courseSetRequestProperty(huc5);
            huc5.setRequestProperty("Cookie", JSESSIONcookie);
            InputStream is5 = huc5.getInputStream();
        } catch (MalformedURLException e) {
            System.out.println("ERROR 3");
            e.printStackTrace();
        } catch (IOException e) {
            System.out.println("ERROR 4");
            e.printStackTrace();
        }
    }

    public void getCoursePage(File coursePage){

        getCourseRootPage();

        long queryDate = System.currentTimeMillis();
        URL courseURL6;
        try {
            courseURL6 = new URL("http://202.114.90.180/Course/grkbList.do?_="+queryDate);
            HttpURLConnection huc6 = (HttpURLConnection) courseURL6.openConnection();
            course6setRP(huc6);
            BufferedReader br = new BufferedReader(new InputStreamReader(huc6.getInputStream(), "utf-8"));
            String mess;
            PrintWriter pw = new PrintWriter(new OutputStreamWriter(new FileOutputStream(coursePage), "gb2312"), true);
            while((mess=br.readLine())!=null){
                System.out.println(mess);
                pw.println(mess);
            }
        } catch (MalformedURLException e) {
            System.out.println("ERROR 5");
            e.printStackTrace();
        } catch (IOException e) {
            System.out.println("ERROR 6");
            e.printStackTrace();
        }

    }

    private void courseSetRequestProperty(HttpURLConnection huc) {
        huc.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8");
        huc.setRequestProperty("Accept-Encoding", "gzip, deflate, sdch");
        huc.setRequestProperty("Accept-Language", "zh-CN,zh;q=0.8");
        huc.setRequestProperty("Connection", "keep-alive");
        huc.setRequestProperty("Host", "202.114.90.180");
        huc.setRequestProperty("Referer", "http://sso.jwc.whut.edu.cn/Certification//login.do");
        huc.setRequestProperty("Upgrade-Insecure-Requests", "1");
        huc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36");
    }

    private void course6setRP(HttpURLConnection huc) {
        huc.setRequestProperty("Accept", "*/*");
        huc.setRequestProperty("Accept-Encoding", "gzip, deflate, sdch");
        huc.setRequestProperty("Accept-Language", "zh-CN,zh;q=0.8");
        huc.setRequestProperty("Connection", "keep-alive");
        huc.setRequestProperty("Cookie", JSESSION_TRANS);
        huc.setRequestProperty("Host", "202.114.90.180");
        huc.setRequestProperty("Referer", LOCATION_TRANS);
        huc.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.87 Safari/537.36");
        huc.setRequestProperty("X-Requested-With", "XMLHttpRequest");
    }

}

