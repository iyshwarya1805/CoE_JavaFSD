import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';
import { TripsComponent } from './trips.component';  // ✅ Import TripsComponent
import { WishlistComponent } from '../pages/wishlist/wishlist.component';  // ✅ Import WishlistComponent

@NgModule({
  declarations: [WishlistComponent],  // ✅ Declare WishlistComponent
  imports: [
    CommonModule,
    RouterModule.forChild([{ path: '', component: TripsComponent }]) // ✅ Routing for TripsComponent
  ],
  exports: [WishlistComponent]  // ✅ Export WishlistComponent for use in other modules
})
export class TripsModule {}
