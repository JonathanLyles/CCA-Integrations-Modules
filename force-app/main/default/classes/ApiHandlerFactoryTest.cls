@IsTest
public with sharing class ApiHandlerFactoryTest {
    
    @IsTest
    static void getHandlerPositiveTest(){
        
        String apiName = 'OpenAI';

        Test.startTest();

        Try{
            ApiCalloutHandler handler = ApiHandlerFactory.getHandler(apiName);
            System.assert(true,'Pass: Handler found');
        }catch(Exception e){
            System.assert(false,'Fail: Handler not found');
        }

        Test.stopTest();
    }

    @IsTest
    static void getHandlerNegativeTest(){
        
        String apiName = 'OpenAIR';

        Test.startTest();

        Try{
            ApiCalloutHandler handler = ApiHandlerFactory.getHandler(apiName);
            System.assert(false,'Fail: Expected exception not thrown');
        }catch(Exception e){
            System.assert(true,'Pass: As expected, handler not found and exception thrown');
        }
        
        Test.stopTest();
    }
}