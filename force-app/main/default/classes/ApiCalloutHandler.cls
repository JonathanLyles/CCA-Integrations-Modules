/**
 * @description Abstract class to standardize the way callouts are made
 * @author Jonathan Lyles
 * @date May 4, 2025
 */

public abstract class ApiCalloutHandler {
    public abstract HttpResponse makeCallout(HttpRequest request);
    public abstract void handleResponse(HttpResponse response);

    // Shared method for logging requests
    public void logRequest(HttpRequest request){
        Logger.info('Request method: ' + request.getMethod());
        Logger.info('Request endpoint: ' + request.getEndpoint());
        Logger.info('Request body: ' + request.getBody());
    }

    // Shared method for logging responses
    public void logResponse(HttpResponse response){
        Logger.info('Response status code: ' + response.getStatusCode());
        Logger.info('Response body: ' + response.getBody());
    }

    // Shared method for handling common errors
    public void handleCommonErrors(HttpResponse response) {
        if (response.getStatusCode() >= 400) {
            throw new CalloutException('HTTP Error: ' + response.getStatusCode() + ' - ' + response.getStatus());
        }
    }



    // Custom exception for callout errors
    public class CalloutException extends Exception {}
}