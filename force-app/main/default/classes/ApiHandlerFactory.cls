/**
 * @description This factory class dynamically returns the appropriate handler based on the API being called. This makes it easy to add new APIs in the future without modifying existing code. 
 * @author Jonathan Lyles
 * @date May 4, 2025
 */

public with sharing class ApiHandlerFactory {

    /**
     * @description Method returns appropriate handler
     * @param String apiName
     */

    public static ApiCalloutHandler getHandler(String apiName) {

        try{
            if (apiName == 'OpenAI') {
                Logger.info('apiName: ' + apiName);
                Logger.info('Returning OpenAICalloutHandler()');
                return new OpenAICalloutHandler();
            } else {
                Logger.info('apiName: ' + apiName);
                throw new ApiHandlerFactoryException('No handler found for API: ' + apiName);
            }
            // Add other APIs here

        }catch(ApiHandlerFactoryException e){
            Logger.error('Error: ' + e.getMessage());
            throw e;
        }
    }

    public class ApiHandlerFactoryException extends Exception{}
}