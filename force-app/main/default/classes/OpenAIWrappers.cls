public with sharing class OpenAIWrappers {
    public class ChatCompletionResponse{
        String id;
        @JsonName('object') public String objectType;
        Integer created;
        String model;
        List<String> choices;
        Map<String, Object> usage;
        String service_tier;
        String system_fingerprint;    
    }
}