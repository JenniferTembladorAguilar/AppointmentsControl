global class closeCitasBatchSchedule implements Schedulable {
   global void execute(SchedulableContext sc) {
      closeCitasBatch b = new closeCitasBatch(); 
      database.executebatch(b);
   }
}