import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { RouterModule } from '@angular/router';

import { AppComponent } from './app.component';
import { NavMenuComponent } from './components/nav-menu/nav-menu.component';
import { HomeComponent } from './components/home/home.component';
import { CounterComponent } from './components/counter/counter.component';
import { FetchDataComponent } from './components/fetch-data/fetch-data.component';
import {TestjmabsdComponent} from "./Commen/testjmabsd/testjmabsd.component";
import {CounterTestComponent} from "./Commen/counterTest/counter-test.component";
import {WishListComponent} from "./Commen/wish-list/wish-list.component";
import {CreateArtikelComponent} from "./components/create-artikel/create-artikel.component";
import {LoginSignupComponent} from "./components/login-signup/login-signup.component";
import {ShopComponent} from "./components/Shop/Shop.component";

@NgModule({
  declarations: [
    AppComponent,
    NavMenuComponent,
    HomeComponent,
    CounterComponent,
    FetchDataComponent,
    TestjmabsdComponent,
    CounterTestComponent,
    WishListComponent,
    CreateArtikelComponent,
    LoginSignupComponent,
    ShopComponent
  ],
  imports: [
    BrowserModule.withServerTransition({ appId: 'ng-cli-universal' }),
    HttpClientModule,
    FormsModule,
    RouterModule.forRoot([
      { path: '', component: HomeComponent, pathMatch: 'full' },
      { path: 'counter', component: CounterComponent },
      { path: 'fetch-data', component: FetchDataComponent },
      { path: 'wish-list', component: WishListComponent },
      { path: 'create-artikel', component: CreateArtikelComponent },
    ])
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
