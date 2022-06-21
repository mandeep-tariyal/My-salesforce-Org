import { LightningElement } from 'lwc';

export default class CloneUser extends LightningElement {
    greeting = 'World';
  changeHandler(event) {
    this.greeting = event.target.value;
  }
    
}