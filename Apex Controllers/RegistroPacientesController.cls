public class RegistroPacientesController {
    public Paciente__c paciente { get;  set;}
    
    public RegistroPacientesController() {
        paciente = new Paciente__c ();
    }
    
    public PageReference save() {
        if((String.isBlank(Paciente.Name))|| (String.isBlank(Paciente.Apellido_Paterno__c))||(String.isBlank(Paciente.email__c))||(String.isBlank(Paciente.Genero__c))){
            Paciente.Genero__c.addError('Completa los campos obligatorios (*)');
            
        }else{
            
        
      
        try {
            upsert(paciente);
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            Paciente.Genero__c.addError('El paciente ya esta dado de alta');
            return null;
        }
        //  After successful Save, navigate to the default view page
        clear();
        return (null);
            
    }
 return (null);
        }
    
    public PageReference clear() {
        paciente = new Paciente__c ();
        return null;
    }
}