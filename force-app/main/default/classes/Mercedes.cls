public class Mercedes implements IVehicle, IDML, Database.Stateful, Database.AllowsCallouts {
    // method implementations
    public void start(){
        System.debug('Start');
    }
    // method implementations
    public void stop(){
        System.debug('stop');
    }
    // method implementations
    public String changeGear(){
        System.debug('change gear');
        return '';
    }
    // method implementations
    public Boolean openDoor(String doorType){
        return true;
    }
}