public class YellowMarker extends Marker {
    protected String message;
    public YellowMarker(String name, String color, String message){
        super(name);
    }
    public void main(){
        this.message = 'This is simple message';
        // markerName = RED
        super.markerName = 'Yellow';
        // markerName = Yellow
        this.write();
        super.paint();
    }
    /* Method Overriding */
    public override void write(){
        System.debug('Marker color is '+super.markerName);
    }
}
/*
public virtual class Marker {
    public String markerName;
    public Marker(String name){
        this.markerName = name;
    }
    public virtual void write(){
        String name = 'ABC';
        System.debug(markerName+' is Writing ');
    }
}
/*
 * AWS S3/EC2/Emails/Worflows/Lamda
 * 	Authenticate - Common
 * SharePoint
 * 	Authenticate - Common
 * Legacy Database
 * 	Authenticate - Common
 */