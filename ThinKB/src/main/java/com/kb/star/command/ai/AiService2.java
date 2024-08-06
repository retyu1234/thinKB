package com.kb.star.command.ai;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Service
@PropertySource("classpath:/application.properties")
public class AiService2 {

	@Value("${openai.api.key}")
	private String apiKey;
	private final String apiUrl = "https://api.openai.com/v1/chat/completions";
    @PostConstruct
    public void init() {
        System.out.println("AiService initialized with API key: " + apiKey);
    }

	public String getAiResponse(String userInput) {
		System.out.println("NAVER API 키 : " + apiKey);
		HttpClient httpClient = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(apiUrl);
		httpPost.setHeader("Authorization", "Bearer " + apiKey);
		httpPost.setHeader("Content-Type", "application/json");

		Map<String, Object> requestBody = new HashMap<>();
		requestBody.put("model", "gpt-4");

		List<Map<String, String>> messages = new ArrayList<>();
		Map<String, String> message = new HashMap<>();
		message.put("role", "user");
		message.put("content", userInput);
		messages.add(message);

		requestBody.put("messages", messages);
		requestBody.put("max_tokens", 1000);

		Gson gson = new Gson();
		String jsonBody = gson.toJson(requestBody);

		try {
			StringEntity entity = new StringEntity(jsonBody, "UTF-8");
			httpPost.setEntity(entity);

			HttpResponse response = httpClient.execute(httpPost);
			String responseBody = EntityUtils.toString(response.getEntity());

			Type mapType = new TypeToken<Map<String, Object>>() {
			}.getType();
			Map<String, Object> responseMap = gson.fromJson(responseBody, mapType);

			if (responseMap != null && responseMap.containsKey("choices")) {
				List<Map<String, Object>> choices = (List<Map<String, Object>>) responseMap.get("choices");
				if (choices != null && !choices.isEmpty()) {
					return ((Map<String, Object>) choices.get(0).get("message")).get("content").toString().trim();
				} else {
					return "AI가 응답을 생성하지 못했습니다.";
				}
			} else {
				return "API 응답이 예상과 다릅니다: " + responseBody;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "오류가 발생했습니다: " + e.getMessage();
		}
	}

}