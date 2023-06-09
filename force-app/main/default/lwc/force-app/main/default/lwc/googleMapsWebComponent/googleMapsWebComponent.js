import { LightningElement, track } from 'lwc';
import directionsFunctionality from '@salesforce/apex/googleMapsController.directionsFunctionality';
import autofillFunctionality from '@salesforce/apex/googleMapsController.autofillFunctionality';

export default class DirectionsLWC extends LightningElement {
    @track origin = '';
    @track destination = '';
    @track sourceList = [];
    @track endList = [];
    @track finalResult;
 handleOriginChange(event) {
        this.origin = event.target.value;
    }
    @track mode = 'Driving';

    modeOptions = [
        { label: 'Driving', value: 'Driving' },
        { label: 'Walking', value: 'Walking' },
        { label: 'Transit', value: 'Transit' },
        { label: 'Bicycling', value: 'Bicycling' },
    ];

   

    TransportSelect(event) {
        this.mode = event.detail.value;
    }

    sourceChange(event) {
        autofillFunctionality({ input: event.target.value })
        .then(result => {
            this.sourceList = result;
        })
        .catch(error => {
            console.error('We can\'t get AutomaticDirections', error);
        });
    }

    handleSourceClick(event) {
        this.origin = event.target.textContent;
        this.sourceList = []; // clear the suggestions
    }

    DestinationChange(event) {
        this.destination = event.target.value;
    }

    DestinationKeyup(event) {
        autofillFunctionality({ input: event.target.value })
        .then(result => {
            this.endList = result;
        })
        .catch(error => {
            console.error('Error in getting place autocomplete', error);
        });
    }

    DestinationAutoComplete(event) {
        this.destination = event.target.textContent;
        this.endList = []; // clear the suggestions
    }

    getDirectionsClick() {
        directionsFunctionality({ origin: this.origin, destination: this.destination, mode: this.mode })
        .then(result => {
            this.finalResult = result;
        })
        .catch(error => {
            console.error('Error in getting directions', error);
        });
    }
}