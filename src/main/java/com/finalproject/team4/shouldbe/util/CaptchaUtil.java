package com.finalproject.team4.shouldbe.util;

// 네이버 캡차 API 예제 - 키발급

import java.io.*;
import java.net.*;
import java.util.*;
import org.json.JSONObject;

public class CaptchaUtil {
    public static String clientId = "lm5g3zx9ad";
    public static String clientSecret = "mtO7Cz9bk12SX2LRxcXYxVTYOWkwVVIPu1LrjrOd";
    private static final String CAPTCHA_DIR = "/../captcha/";
    public static String[] APICaptchaCombined() {
        try {
            String IKey = APICaptchakey(); // 키 발급
            String SKey=APICaptchakeySound();
            String imagePath = APICaptchaImage(IKey); // 이미지 캡차 생성
            String audioPath = APICaptchaAudio(SKey); // 음성 캡차 생성
            return new String[]{imagePath, audioPath, IKey, SKey};
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }
    public static String APICaptchakey() {
        try {
            String code = "0"; // 키 발급시 0, 캡차 이미지 비교시 1로 세팅
            String apiURL = "https://naveropenapi.apigw.ntruss.com/captcha/v1/nkey?code=" + code;
            HttpURLConnection con = setupConnection(apiURL, "GET");
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 오류 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response);
            JSONObject jsonResponse = new JSONObject(response.toString());
            return jsonResponse.getString("key"); // JSON 응답에서 "key" 값을 추출
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }

    public static String APICaptchakeySound() {
        try {
            String code = "0"; // 키 발급시 0, 캡차 이미지 비교시 1로 세팅
            String apiURL = "https://naveropenapi.apigw.ntruss.com/scaptcha/v1/skey?code=" + code;
            HttpURLConnection con = setupConnection(apiURL, "GET");
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 오류 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response);
            JSONObject jsonResponse = new JSONObject(response.toString());
            return jsonResponse.getString("key"); // JSON 응답에서 "key" 값을 추출
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }

    public static String APICaptchaImage(String key) {
        String filePath = "이미지_" + key + ".jpg"; // 파일 저장 위치 지정
        try {
            String apiURL = "https://naveropenapi.apigw.ntruss.com/captcha-bin/v1/ncaptcha?key=" + key + "&X-NCP-APIGW-API-KEY-ID=" + clientId;
            HttpURLConnection con = setupConnection(apiURL, "GET");
            int responseCode = con.getResponseCode();
            if (responseCode == 200) { // 정상 호출
                readStreamAndSaveToFile(con.getInputStream(), filePath);
            } else {  // 오류 발생
                handleErrorResponse(con);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        filePath = CAPTCHA_DIR +"이미지_" + key + ".jpg";
        return filePath;
    }

    public static String APICaptchaAudio(String key) {
        String filePath = "음성_" + key + ".wav"; // 파일 저장 위치 지정
        try {
            String apiURL = "https://naveropenapi.apigw.ntruss.com/scaptcha-bin/v1/scaptcha?key=" + key + "&X-NCP-APIGW-API-KEY-ID=" + clientId;
            HttpURLConnection con = setupConnection(apiURL, "GET");
            int responseCode = con.getResponseCode();
            if (responseCode == 200) { // 정상 호출
                readStreamAndSaveToFile(con.getInputStream(), filePath);
            } else {  // 오류 발생
                handleErrorResponse(con);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        filePath=CAPTCHA_DIR +"음성_" + key + ".wav";
        return filePath;
    }

    public static boolean APICaptchakeyResult(String key, String value) {
        try {
            String code = "1"; // 캡차 이미지 비교시 1로 세팅
            String apiURL = "https://naveropenapi.apigw.ntruss.com/captcha/v1/nkey?code=" + code + "&key=" + key + "&value=" + value;
            HttpURLConnection con = setupConnection(apiURL, "GET");
            int responseCode = con.getResponseCode();
            if (responseCode == 200) { // 정상 호출
                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String line;
                StringBuilder response = new StringBuilder();
                while ((line = br.readLine()) != null) {
                    response.append(line);
                }
                br.close();

                JSONObject jsonResponse = new JSONObject(response.toString());
                return jsonResponse.getBoolean("result"); // 캡차 검증 결과 반환
            } else { // 오류 발생
                System.out.println("imeagecaptchaerror");
                handleErrorResponse(con);
                return false;
            }
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

    public static boolean APICaptchakeyResultSound(String key, String value) {
        try {
            String code = "1"; // 캡차 이미지 비교시 1로 세팅
            String apiURL = "https://naveropenapi.apigw.ntruss.com/scaptcha/v1/skey?code=" + code + "&key=" + key + "&value=" + value;
            HttpURLConnection con = setupConnection(apiURL, "GET");
            int responseCode = con.getResponseCode();
            if (responseCode == 200) { // 정상 호출
                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
                String line;
                StringBuilder response = new StringBuilder();
                while ((line = br.readLine()) != null) {
                    response.append(line);
                }
                br.close();

                JSONObject jsonResponse = new JSONObject(response.toString());
                return jsonResponse.getBoolean("result"); // 캡차 검증 결과 반환
            } else { // 오류 발생
                System.out.println("soundcaptchaterror");
                handleErrorResponse(con);
                return false;
            }
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

    private static void printResponse(InputStream inputStream) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(inputStream));
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();
        System.out.println(response);
    }

    private static HttpURLConnection setupConnection(String urlStr, String method) throws IOException {
        URL url = new URL(urlStr);
        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod(method);
        con.setRequestProperty("X-NCP-APIGW-API-KEY-ID", clientId);
        con.setRequestProperty("X-NCP-APIGW-API-KEY", clientSecret);
        return con;
    }

    private static void readStreamAndSaveToFile(InputStream is, String filePath) throws IOException {
        int read;
        byte[] bytes = new byte[1024];
        String absolutePath = "C:\\Users\\cje\\shouldbe\\src\\main\\webapp\\captcha\\" + filePath;
        File f = new File(absolutePath);
        f.getParentFile().mkdirs();
        f.createNewFile();
        System.out.println(absolutePath+" create!");
        try (OutputStream outputStream = new FileOutputStream(f)) {
            while ((read = is.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
        }catch (Exception e) {
            e.printStackTrace(); // 오류 출력
        }
    }

    private static void handleErrorResponse(HttpURLConnection con) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
        String inputLine;
        StringBuffer response = new StringBuffer();
        while ((inputLine = br.readLine()) != null) {
            response.append(inputLine);
        }
        br.close();
        System.out.println(response);
    }
}
