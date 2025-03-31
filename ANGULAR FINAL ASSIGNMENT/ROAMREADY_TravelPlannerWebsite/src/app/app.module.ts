import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule} from '@angular/forms';
import { AppRoutingModule } from './app-routing.module';

import { HttpClientModule } from '@angular/common/http';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';  // ✅ Import CommonModule
import { ReactiveFormsModule } from '@angular/forms'; 
// Import root component
import { AppComponent } from './app.component';

// Import non-standalone components
import { HomeComponent } from './pages/home/home.component';
import { MenuBarComponent } from './components/menu-bar/menu-bar.component';
import { TripListComponent } from './pages/trip-list/trip-list.component';

import { EditTripComponent } from './pages/edit-trip/edit-trip.component';
import { LoginComponent } from './pages/login/login.component';

// Import directives
import { LocalStorageDirective } from './directives/local-storage.directive';
import { HighlightDirective } from './directives/highlight.directive';
import { DestinationsComponent } from './pages/destinations/destinations.component';

import { DashboardComponent } from './pages/dashboard/dashboard.component';
import { BeachGetawaysComponent } from './pages/home/beach-getaways/beach-getaways.component';
import { MountainAdventuresComponent } from './pages/home/mountain-adventures/mountain-adventures.component';
import { UrbanEscapesComponent } from './pages/home/urban-escapes/urban-escapes.component';
import { AboutUsComponent } from './pages/home/about-us/about-us.component';
import { WishlistComponent } from './pages/wishlist/wishlist.component';
import { TripService } from './services/trip.service';
import { BaliDetailsComponent } from './pages/destinations/bali-details/bali-details.component';
import { GrandCanyonDetailsComponent } from './pages/destinations/grand-canyon-details/grand-canyon-details.component';
import { DubaiDetailsComponent } from './pages/destinations/dubai-details/dubai-details.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    MenuBarComponent,
    TripListComponent,
    
    EditTripComponent,
    LoginComponent,
    LocalStorageDirective,
    HighlightDirective,
    DestinationsComponent,
    
    DashboardComponent,
    BeachGetawaysComponent,
    MountainAdventuresComponent,
    UrbanEscapesComponent,
    AboutUsComponent,
    WishlistComponent,
    BaliDetailsComponent,
    GrandCanyonDetailsComponent,
    DubaiDetailsComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,  // ✅ Required for template-driven forms
    ReactiveFormsModule,
    CommonModule  // ✅ Required for reactive forms
  ],
  providers: [TripService],
  bootstrap: [AppComponent]
})
export class AppModule { }
