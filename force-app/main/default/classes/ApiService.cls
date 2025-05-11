/**
 * @description This class will use the factory class to get the appropriate handler, then make the callout and process the response.
 * @author Jonathan Lyles
 * @date May 4, 2025
 */

public with sharing class ApiService {

    public static void execute(String apiName, HttpRequest request ){
        
        ApiCalloutHandler handler = ApiHandlerFactory.getHandler(apiName);
        HttpResponse response = handler.makeCallout(request);
        handler.handleResponse(response);
    }
}