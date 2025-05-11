public with sharing class ApiCalloutQueueable implements Queueable, Database.AllowsCallouts{
    public void execute(QueueableContext qc){
        try{
            Http http = new Http();
            String apiName = 'OpenAI';
            HttpRequest request = ApiRequestFactory.getRequest(apiName);
            ApiService.execute(apiName, request);
            Logger.info('ApiService.execute() called from ApiCalloutQueueable.execute()');

        }catch(Exception e){
            Logger.error(e.getMessage());
        }
        Logger.saveLog();
    }
}