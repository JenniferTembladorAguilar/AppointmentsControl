public class RegistroDoctoresController {
    public Doctor__c doctor { get;  set;}
    
    public RegistroDoctoresController() {
        doctor = new Doctor__c ();
    }
    
    public PageReference save() {
        if((String.isBlank(doctor.Name))|| (String.isBlank(doctor.Apellido_Paterno__c))||(String.isBlank(doctor.email__c))||(String.isBlank(doctor.Especialidad__c))||(String.isBlank(doctor.Doctor__c))){
            doctor.Doctor__c.addError('Completa los campos obligatorios (*)');
            
        }else{
           
            try {
                upsert(doctor);
            } catch(System.DMLException e) {
                ApexPages.addMessages(e);
                doctor.Doctor__c.addError('El doctor ya esta dado de alta');
                return null;
            }
        //  After successful Save, navigate to the default view page
       	clear();
       	return (null);
           
            
    	}
 		return (null);
    } 
     
     public PageReference clear() {
        doctor = new Doctor__c ();
        return null;
    }
   
}