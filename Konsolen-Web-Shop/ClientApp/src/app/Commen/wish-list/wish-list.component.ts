import { Component } from '@angular/core';

@Component({
  selector: 'app-WishList',
  templateUrl: './wish-list.component.html'
})
export class WishListComponent {
  public currentCount = 0;

  public incrementCounter() {
    this.currentCount++;
  }
}
