public class JWTUtils {
    
    public static String response		{ set; get; }
    public static String access_token	{ set; get; }
    public static String scope			{ set; get; }
    public static String instance_url	{ set; get; }
    public static String id				{ set; get; }
    public static String token_type		{ set; get; }
    
    public static String retrievePKContent(){
        ContentVersion base64Content = [SELECT Title, VersionData FROM ContentVersion where Title='server' ORDER BY Title LIMIT 1];
        String keyContents = base64Content.VersionData.tostring();
        System.debug(keyContents);
        keyContents = keyContents.replace('-----BEGIN RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('-----END RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('\n', '');
        return keyContents;
    }
    
    public static String createHeader(String algName){
        JSONGenerator header = JSON.createGenerator(false);
        header.writeStartObject();
        header.writeStringField('alg', algName);
        header.writeEndObject();
        String encodedHeader = base64URLencode(Blob.valueOf(header.getAsString()));
        return encodedHeader;
    }

    public static String base64URLencode(Blob input){ 
        String output = encodingUtil.base64Encode(input);
        output = output.replace('+', '-');
        output = output.replace('/', '_');
        while ( output.endsWith('=')){
            output = output.subString(0,output.length()-1);
        }
        return output;
    }
    
    public static String generateJsonBody(){
        JSONGenerator body = JSON.createGenerator(false);
        body.writeStartObject();
        body.writeStringField('iss', '3MVG9n_HvETGhr3COGSBZ2RGw0UCthndmDcWklbdHdn08L0Idmk3gMp8P7c6iNsTnhM_61ZuvP3rrAqOcpHi5');
        body.writeStringField('sub','sfdcpanther+hindi@gmail.com');
        body.writeStringField('aud','https://login.salesforce.com');
        DateTime rightNow = System.now();
        rightNow = rightNow.addMinutes(3);
        Long expiry = rightNow.getTime();
        body.writeNumberField('exp', expiry);
        System.debug('After 3 mins - '+expiry);
        body.writeEndObject();
        String encodeJWTClaims = base64URLencode(Blob.valueOf(body.getAsString()));        
        return encodeJWTClaims;
    }
    
    public static String combineJWTHeader_Claimset(string encoded_JWT_Header,String encoded_JWT_Claims_Set){
        System.debug(encoded_JWT_Header + '.' + encoded_JWT_Claims_Set);
        return encoded_JWT_Header + '.' + encoded_JWT_Claims_Set;
    }
    
    public static String signPkey(String jwt){
        Blob privateKey = EncodingUtil.base64Decode(retrievePKContent());
        Blob signature  = Crypto.sign('rsa-sha256', Blob.valueOf(jwt), privateKey);
        jwt += '.' + base64URLencode(signature);  
        return jwt;
    }
    
    public static void fetchToken(string jwtValue){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://login.salesforce.com/services/oauth2/token?grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion='+jwtValue);
        system.debug('URL ---- '+'https://login.salesforce.com/services/oauth2/token?grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion='+jwtValue);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug(res.getBody());
        response = res.getBody();
        System.debug('response - '+response);
        System.debug(res);
        JSONParser parser = JSON.createParser(response);
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                JWTResponse jwtr = (JWTResponse)parser.readValueAs(JWTResponse.class);
                access_token = '----'+jwtr.access_token+'----';
                scope = jwtr.scope;
                instance_url = jwtr.instance_url;
                id = jwtr.id;
                token_type = jwtr.token_type;
                parser.skipChildren();
            }
        }
    }
    
    public static void doInit(){
        String jwt = JWTUtils.signPkey( 
            JWTUtils.combineJWTHeader_Claimset( 
                JWTUtils.createHeader('RS256'), 
                JWTUtils.generateJsonBody() 
            ) 
        );
        System.debug('---'+jwt+'---');
        JWTUtils.fetchToken(jwt);
    }

    public class JWTResponse {
        public String access_token;
        public String scope;
        public String instance_url;
        public String id;
        public String token_type;
    } 
}