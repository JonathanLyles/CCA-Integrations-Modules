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

        if(response.getStatusCode() == 200){
            // Deserialize the body
        } else {
            throw new OpenAICalloutHandlerException('Error: Received status code ' + response.getStatusCode());
        }
        return null;
    }

    /**
     *@description Exception class for handling errors specific to OpenAI API callouts. 
     *              This exception is thrown when issues occur during the execution of 
     *              OpenAI API requests or response processing.
     *@date May 4, 2025
     */

    public class OpenAICalloutHandlerException extends Exception{}
}