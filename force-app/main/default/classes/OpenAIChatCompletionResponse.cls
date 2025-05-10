public with sharing class OpenAIChatCompletionResponse implements ApiResponse {
    public String id;
    public String objectType;
    public List<String> messages;
    
    public String getResponseType(){
        return 'OpenAIChatCompletion';
    }
}