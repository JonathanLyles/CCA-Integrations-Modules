/**
 * @description Handles scheduling of queueable callouts
 * @author Jonathan Lyles
 * @date May 11, 2025
 */

public with sharing class ApiCalloutSchedulable implements Schedulable{
    public void execute(SchedulableContext sc){
        if (sc != null) {
            System.enqueueJob(new ApiCalloutQueueable());
            Logger.info('SchedulableContext is not null. ApiCalloutQueueable() has been queued to run.');
        } else {
            Logger.info('SchedulableContext is null, but proceeding with ApiCalloutQueueable() job.');
            System.enqueueJob(new ApiCalloutQueueable());
        }
        Logger.saveLog();
    }
}