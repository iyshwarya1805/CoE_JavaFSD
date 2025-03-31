import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { TripsComponent } from './trips.component'; // ✅ Import TripsComponent
import { WishlistComponent } from '../pages/wishlist/wishlist.component'; // ✅ Import WishlistComponent

@NgModule({
  imports: [
    CommonModule,
    TripsComponent,       // ✅ Importing standalone component
    WishlistComponent,    // ✅ Importing standalone component
    RouterModule.forChild([{ path: '', component: TripsComponent }])
  ]
})
export class TripsModule { }
