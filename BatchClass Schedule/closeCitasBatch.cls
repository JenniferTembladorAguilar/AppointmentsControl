public class closeCitasBatch implements Database.Batchable<Sobject> {
    public final String Query;
    
    public closeCitasBatch(){
        Query='SELECT id, fecha_y_hora__c, status__c FROM Cita__c where Fecha_y_Hora__c <TOMORROW AND status__c!=\'Cancelada\' AND status__c!=\'Finalizada\'';
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Cita__c> scope){
        for(Cita__c s : scope){
             s.status__c='Perdida';
        }
        update scope;
    }
    
    public void finish(Database.BatchableContext BC){
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = new String[] { 'jennifer.temblador@gmail.com'};
        message.subject = 'Citas Terminadas';
        message.plainTextBody = 'Se ejecutó el codigo de terminar citas';
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
            Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
        
        if (results[0].success) 
        {
            System.debug('The email was sent successfully.');
        } else 
        {
            System.debug('The email failed to send: ' + results[0].errors[0].message);
        }
    }
}