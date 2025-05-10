/**
 * @description This interface defines a base class for responses. It ensures that all responses, regardless of the APi, can be processed in a consistent manner. 
 * @author Jonathan Lyles
 * @date May 4, 2025
 */

public interface ApiResponse {
    String getResponseType();
}