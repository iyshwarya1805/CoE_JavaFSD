import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomeComponent } from './pages/home/home.component';
import { AddTripComponent } from './pages/add-trip/add-trip.component';
import { DestinationsComponent } from './pages/destinations/destinations.component';
import { BeachGetawaysComponent } from './pages/home/beach-getaways/beach-getaways.component';
import { MountainAdventuresComponent } from './pages/home/mountain-adventures/mountain-adventures.component';
import { UrbanEscapesComponent } from './pages/home/urban-escapes/urban-escapes.component';
import { BaliDetailsComponent } from './pages/destinations/bali-details/bali-details.component';
import { GrandCanyonDetailsComponent } from './pages/destinations/grand-canyon-details/grand-canyon-details.component';
import { DubaiDetailsComponent } from './pages/destinations/dubai-details/dubai-details.component';

import { AuthGuard } from './auth.guard';
import { AboutUsComponent } from './pages/home/about-us/about-us.component';
import { WishlistComponent } from './pages/wishlist/wishlist.component';

export const routes: Routes = [
  { path: '', component: HomeComponent }, // ✅ Home Page (Login + Dashboard)
  { path: 'add-trip', component: AddTripComponent, canActivate: [AuthGuard] },
  { path: 'destinations', component: DestinationsComponent, canActivate: [AuthGuard] },
  { path: 'trips', loadChildren: () => import('./trips/trips.module').then(m => m.TripsModule) }, // Lazy loading Trips Module, canActivate: [AuthGuard] },
  { path: 'beach-getaways', component: BeachGetawaysComponent },
  { path: 'mountain-adventures', component: MountainAdventuresComponent },
  { path: 'urban-escapes', component: UrbanEscapesComponent },
  { path: 'destinations/bali', component: BaliDetailsComponent },
  { path: 'destinations/grand-canyon', component: GrandCanyonDetailsComponent },
  { path: 'destinations/dubai', component: DubaiDetailsComponent },
  { path: 'about-us', component: AboutUsComponent },
  { path: 'wishlist', component: WishlistComponent },
  { path: '**', redirectTo: '', pathMatch: 'full' }  
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
