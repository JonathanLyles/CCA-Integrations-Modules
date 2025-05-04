/**
 * @author Prompt:
 * @author Code:
 * @description 
 * 
 */

public with sharing class OpenAICompletionCallout {

    /**
     * @description 
     * 
     */
    public class OpenAICompletionCalloutException extends Exception{}


    public OpenAICompletionCallout() {

    }
    
    public static HttpResponse getCompletionResults(){

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:OpenAICompletions');
        request.setTimeout(20000);
        String payload = '{' +
            '"model": "gpt-4.1",' +
            '"messages": [' +
                '{' +
                '"role": "user",' +
                '"content": "You are an experienced Salesforce instructor helping new Salesforce professionals pass their certification exams. Create mock Salesforce exam questions and answers related to the administrator, developer, and consultant exam. Provide an explanation and resources for the answer.\\nRequirements\\n\\n-   Do not use real company names, make up company names if needed.\\n-   Do not have process builder as a solution but you can have this as an answer option\\n-   Do not have aura components as a solution but you can have this as an answer option\\n-   Do not always select A as the correct answer. Randomize the correct answer\\n-   You can have multiple correct answers for a question but most of the time there will be only one correct answer\\n-   You can have multiple resources for a question but there should be a minimum of 1 and a maximum of 3 resources\\n-   Choose from one of the question types below\\n-   Resources should be from reputable sources like Salesforce documentation, Salesforce Stack Exchange, Salesforce Ben, and other reputable sources\\n-   Create a unique question for each category\\n-   The category should be Administrator, Developer, or Consultant\\n-   The name should be question summary less than 80 characters\\n-   You can have at least 4 answers for each questions but not more than 6 answers, most of the time there will be 4 answers\\n\\nQuestion Types\\nScenario-Based: These questions describe a real-world scenario and ask for the best solution within Salesforce.\\nProblem Identification (Find the Problem): These questions provide code or configuration details and require the candidate to identify what’s wrong or missing.\\nVocabulary/Definition: These questions test understanding of key Salesforce terms or technical components.\\nConfiguration-Based: These questions are centered around how to implement specific features or configure Salesforce tools.\\nImplementation Selection (Feature or Tool): These questions ask which Salesforce tool or feature should be used to meet specific requirements.\\nCode Logic and Flow: These questions present a code scenario, asking the candidate to find the issue or describe how to implement functionality.\\nData Relationships (Dependency): These questions involve ensuring proper data relationships, like dependent fields or validation.\\n\\nReturn the output in json format below\\n\\n```json\\n{\\n  \\"records\\": [\\n    {\\n      \\"Name\\": \\"Example Name\\",\\n      \\"Category__c\\": \\"Example Category\\",\\n      \\"Question__c\\": \\"Example Question\\",\\n      \\"Explanation__c\\": \\"Example Explanation\\",\\n      \\"Answers__r\\": [\\n        {\\n          \\"Answer__c\\": \\"Example Answer\\",\\n          \\"Solution__c\\": true,\\n          \\"Answer_Key__c\\": \\"A\\"\\n        },\\n        {\\n          \\"Answer__c\\": \\"Example Answer\\",\\n          \\"Solution__c\\": false,\\n          \\"Answer_Key__c\\": \\"B\\"\\n        },\\n        {\\n          \\"Answer__c\\": \\"Example Answer\\",\\n          \\"Solution__c\\": false,\\n          \\"Answer_Key__c\\": \\"D\\"\\n        },\\n        {\\n          \\"Answer__c\\": \\"Example Answer\\",\\n          \\"Solution__c\\": false,\\n          \\"Answer_Key__c\\": \\"C\\"\\n        }\\n      ],\\n      \\"Resources__r\\": [\\n        {\\n          \\"Title__c\\": \\"Example Record\\",\\n          \\"URL__c\\": \\"Example URL\\"\\n        }\\n      ]\\n    }\\n  ]\\n}\\n```"' +
                '}' +
            ']' +
        '}';

        request.setBody(payload);
        try{
            HttpResponse response = http.send(request);
            if(response.getStatusCode() == 200){
            return response;
            } else {
            // Handle non-200 status codes 
            throw new OpenAICompletionCalloutException('Error: Received status code ' + response.getStatusCode());
            }
        }catch(Exception e){
            // Log the exception details
            System.debug('Exception occurred: ' + e.getMessage());
            throw new OpenAICompletionCalloutException('An error occurred while making the HTTP callout: ' + e.getMessage());
        }
    }
}

//TODO: THIS ERROR - 23:33:58.134 (10140456830)|EXCEPTION_THROWN|[1]|OpenAICompletionCallout.OpenAICompletionCalloutException: An error occurred while making the HTTP callout: Read timed out