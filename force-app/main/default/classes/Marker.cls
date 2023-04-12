public virtual class Marker {
    protected String markerName;
    public Marker(String name){
        this.markerName = name;
    }
    protected virtual void write(){
        System.debug(markerName+' is Writing ');
    }
    protected virtual void errase(){
        System.debug(markerName+' is errasing ');
    }
    protected void paint(){
        System.debug(markerName+' is painting ');
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