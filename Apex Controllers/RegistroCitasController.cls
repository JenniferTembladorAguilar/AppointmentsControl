public class RegistroCitasController {
    public Cita__c cita { get;  set;}
    public List<SelectOption> statusOption{set;}
    public String selectedStatus{get;set;}
    public List<SelectOption> getStatusOption () {
        Schema.DescribeFieldResult picklistStatusonCita = Cita__c.Status__c.getDescribe();
        Schema.sObjectField newPicklistStatus = picklistStatusonCita.getSObjectField();
        List<PicklistEntry> opcionStatus = newPicklistStatus.getDescribe().getPicklistValues();
        List<SelectOption> options = new List<SelectOption>();
       
        for(PicklistEntry s : opcionStatus) {        
            if(s.getLabel() == 'Confirmada' || s.getlabel() == 'Pendiente' )
                options.add(new SelectOption(s.getValue(),s.getLabel()));
            }
        return options;
    }
    
    public RegistroCitasController() {
        cita = new Cita__c ();
    }
    
    public PageReference save() {
        if((cita.Fecha_y_Hora__c==null)||(String.isBlank(cita.Doctor__c))||(String.isBlank(cita.Paciente__c))){
           cita.Paciente__c.addError('Completa los campos obligatorios (*)');
            
        }else{
           
            try {
                cita.Status__c = selectedStatus;
                upsert(cita);
            } catch(System.DMLException e) {
                ApexPages.addMessages(e);
                return null;
            }
        //  After successful Save, navigate to the default view page
       	clear();
       	return (null);
           
            
    	}
 		return (null);
    } 
     
     public PageReference clear() {
        cita = new Cita__c ();
        return null;
    }
   
}