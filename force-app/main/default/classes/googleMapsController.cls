public with sharing class googleMapsController{
    private static final String API_KEY = 'AIzaSyB9hcQ0eFDS5u-T2Mazy9BI-Eh8P6hq7cU';
    // Your name, Base64 encoded
    private static String vHash = EncodingUtil.base64Encode(Blob.valueOf('Anil Abburi')); 

    @AuraEnabled
    public static Map<String, String> directionsFunctionality(String origin, String destination, String mode) {
        // Call the Google Maps Directions API
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://maps.googleapis.com/maps/api/directions/json?origin=' + EncodingUtil.urlEncode(origin, 'UTF-8') + '&destination=' + EncodingUtil.urlEncode(destination, 'UTF-8') + '&mode=' + mode + '&key=' + API_KEY);
        System.debug(request.getEndpoint());
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        // Parse the response
        if (response.getStatusCode() == 200) {
            Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> routes = (List<Object>) responseData.get('routes');
            Map<String, Object> route = (Map<String, Object>) routes.get(0);
            List<Object> legs = (List<Object>) route.get('legs');
            Map<String, Object> leg = (Map<String, Object>) legs.get(0);
            Map<String, Object> myMap = (Map<String, Object>) leg.get('distance');
            String myText = (String) myMap.get('text');
            Integer myValue = Integer.valueOf(myMap.get('value')); // distance in meters
            Map<String, Object> durationMap = (Map<String, Object>) leg.get('duration');
            String durationText = (String) durationMap.get('text');
            Double rate; 
          Cost_Caluation__mdt costRecord = [SELECT Cost__c FROM Cost_Caluation__mdt WHERE Type__c = :mode LIMIT 1];
          rate=costRecord.Cost__c;

                
            Double cost = ((myValue / 1609.34)*rate).setScale(2); // convert distance from meters to miles
            

            // Prepare the data to return
            Map<String, String> responseDataToSend = new Map<String, String>();
            responseDataToSend .put('distance', myText);
            responseDataToSend .put('time', durationText);
            responseDataToSend .put('cost', String.valueOf(cost));

            return responseDataToSend ;
        }
        return null;
    }
    @AuraEnabled
    public static List<String> autofillFunctionality(String input) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' + EncodingUtil.urlEncode(input, 'UTF-8') + '&key=' + API_KEY);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> responseData = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> possibilities = (List<Object>) responseData.get('predictions');
            List<String> responseSuggestions = new List<String>();
            for (Object prediction : possibilities) {
                Map<String, Object> resultMap = (Map<String, Object>) prediction;
                responseSuggestions.add((String) resultMap.get('description'));
            }
            return responseSuggestions;
        }
        return null;
    }
}