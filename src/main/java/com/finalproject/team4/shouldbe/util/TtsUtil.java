package com.finalproject.team4.shouldbe.util;

import java.io.*;
import java.net.*;
import java.nio.charset.StandardCharsets;
import java.util.Date;

public class TtsUtil {

    private static final String clientId = "w324kofoc2";
    private static final String clientSecret = "Pz3wpGLfFQtCYf4giwOh3flFVIgwPAV4X9x2AaKJ";
    private static final String SOUND_DIR = "/../sound/";
    public static String APITTS(String plainText, String region) {
        String tempname = null;
        try {
            String text = URLEncoder.encode(plainText, StandardCharsets.UTF_8);
            String apiURL = "https://naveropenapi.apigw.ntruss.com/tts-premium/v1/tts";
            HttpURLConnection con = setupConnection(apiURL, "POST");
            String speaker;
            if ("ko".equals(region)) {
                speaker = "nara"; // 한국어, 여성 음색
            } else if ("en".equals(region)) {
                speaker = "clara"; // 영어, 여성 음색
            } else if ("ja".equals(region)) {
                speaker = "shinji"; // 일본어, 남성 음색
            } else if ("ch-ZN".equals(region) || "ch-CN".equals(region)) {
                speaker = "meimei"; // 중국어, 여성 음색
            } else if ("sp".equals(region)) {
                speaker = "jose"; // 스페인어, 남성 음색
            } else {
                return "error";
            }
            String postParams = "speaker=" + speaker + "&volume=0&speed=0&pitch=0&format=mp3&text=" + text;
            con.setDoOutput(true);
            tempname = Long.valueOf(new Date().getTime()).toString();
            try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
                wr.writeBytes(postParams);
                wr.flush();
            }
            int responseCode = con.getResponseCode();
            if (responseCode == 200) { // 정상 호출
                try (InputStream is = con.getInputStream()) {
                    readStreamAndSaveToFile(is, tempname + ".mp3");
                } catch (Exception e) {
                    e.printStackTrace();
                }

            } else {  // 오류 발생
                handleErrorResponse(con);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return SOUND_DIR + tempname + ".mp3";
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
        byte[] bytes = new byte[1024];
        String absolutePath = "C:\\Users\\cje\\shouldbe\\src\\main\\webapp\\sound\\" + filePath;
        File f = new File(absolutePath);
        f.getParentFile().mkdirs();
        f.createNewFile();
        System.out.println(absolutePath+" create!");
        try (OutputStream outputStream = new FileOutputStream(f)) {
            int read;
            while ((read = is.read(bytes)) != -1) {
                outputStream.write(bytes, 0, read);
            }
        }catch (Exception e){
            e.printStackTrace(); // 오류 출력
        }
    }

    private static void handleErrorResponse(HttpURLConnection con) throws IOException {
        try (BufferedReader br = new BufferedReader(new InputStreamReader(con.getErrorStream()))) {
            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            System.out.println(response);
        }
    }
}
