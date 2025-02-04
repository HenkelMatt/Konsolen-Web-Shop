import { Component } from '@angular/core';

@Component({
  selector: 'app-countertest',
  templateUrl: './counter-test.component.html'
})
export class CounterTestComponent {
  public currentCount = 0;

  public incrementCounter() {
    this.currentCount++;
  }
}
