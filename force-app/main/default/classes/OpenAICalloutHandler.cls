/**
 * @description Class that makes the callout to OpenAI and handles the response
 * @author Jonathan Lyles
 * @date May 9, 2025
 */
public with sharing class OpenAICalloutHandler extends ApiCalloutHandler {
    
    public override HttpResponse makeCallout(HttpRequest request){

        Http http = new Http();
        HttpResponse response = new HttpResponse();
        
        try{
            response = http.send(request);
        }catch(Exception e){
            System.debug(e.getMessage());
        }        
        return response;
    }

    public override Object handleResponse(HttpResponse response){

        Map<String, Object> responseMap = new Map<String, Object>();
        
        if(response.getStatusCode() == 200){
            // Deserialize the response
            responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> choicesList = (List<Object>) responseMap.get('choices');
            Map<String, Object> firstChoice = (Map<String, Object>) choicesList.get(0);
            Map<String, Object> message = (Map<String, Object>) firstChoice.get('message');
            String contentJson = (String) message.get('content');

            // Clean and deserialize the content JSON
            contentJson = contentJson.replace('```json', '').replace('`','').trim();
            Map<String, Object> contentMap = (Map<String, Object>) JSON.deserializeUntyped(contentJson);
            List<Object> recordsList = (List<Object>) contentMap.get('records');
            
            // Lists to hold parent and child records
            List<Problem__c> problemsToInsert = new List<Problem__c>();
            List<Answer__c> answersToInsert = new List<Answer__c>();
            List<Resource__c> resourcesToInsert = new List<Resource__c>();
            
            // Outer loop: Iterate over problems
            for(Object recordObj : recordsList){
                Map<String, Object> record = (Map<String, Object>) recordObj;
                
                // Create the parent problem record
                Problem__c problem = new Problem__c();
                problem.Name = (String) record.get('Name');
                problem.Category__c = (String) record.get('Category__c');
                problem.Question__c = (String) record.get('Question__c');
                problem.Explanation__c = (String) record.get('Explanation__c');

                problemsToInsert.add(problem);
            }
            
            Database.insert(problemsToInsert, true);

            // Map to store problem names and their corresponding IDs
            Map<String, Id> problemIdMap = new Map<String, Id>();
            for(Problem__c problem : problemsToInsert){
                problemIdMap.put(problem.Name, problem.Id);
            }

            // Associate child answer and resource records with parent problem IDs
            for(Object recordObj : recordsList){
                Map<String, Object> record = (Map<String, Object>) recordObj;
                String problemName = (String) record.get('Name');
                Id parentProblemId = problemIdMap.get(problemName);

                // Associate answers with the parent problem
                List<Object> answersList = (List<Object>) record.get('Answers__r');
                for(Object answerObj : answersList){
                    Map<String, Object> answer = (Map<String, Object>) answerObj;

                    // Create the related answer record
                    Answer__c answerRecord = new Answer__c();
                    answerRecord.Answer__c = (String) answer.get('Answer__c');
                    answerRecord.Answer_Key__c = (String) answer.get('Answer_Key__c');
                    answerRecord.Solution__c = (Boolean) answer.get('Solution__c');
                    answerRecord.Problem__c = parentProblemId; // Link the answer to the parent problem
                    answersToInsert.add(answerRecord);
                }
                
                // Associate resources to the parent problem
                List<Object> resourcesList = (List<Object>) record.get('Resources__r');
                for(Object resourceObj : resourcesList){
                    Map<String, Object> resource = (Map<String, Object>) resourceObj;

                    // Create the related resource record
                    Resource__c resourceRecord = new Resource__c();
                    resourceRecord.Title__c = (String) resourceRecord.get('Title__c');
                    resourceRecord.URL__c = (String) resourceRecord.get('URL__c');
                    resourceRecord.Problem__c = parentProblemId; // Link the answer to the parent problem
                    resourcesToInsert.add(resourceRecord);
                }
            }
        // Insert child Answer and Resource records
        Database.insert(answersToInsert, false);
        Database.insert(resourcesToInsert, false);    
            
        } else {
            throw new OpenAICalloutHandlerException('Error: Received status code ' + response.getStatusCode());
        }
        return null;

        //TODO: ApiService is calls handleResponse and is expecting ApiResponse to be returned. Is ApiResponse necessary?
    }

    /**
     *@description Exception class for handling errors specific to OpenAI API callouts. 
     *              This exception is thrown when issues occur during the execution of 
     *              OpenAI API requests or response processing.
     *@date May 4, 2025
     */

    public class OpenAICalloutHandlerException extends Exception{}
}