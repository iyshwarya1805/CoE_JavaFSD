import { Component, Input, Output, EventEmitter } from '@angular/core';
import { Trip } from '../../models/trip.model';

@Component({
  selector: 'app-triplist',
  templateUrl: './triplist.component.html',
  styleUrls: ['./triplist.component.css']
})
export class TripListComponent {
  @Input() trips: Trip[] = []; // Receive trips from parent component
  @Output() wishlistUpdated = new EventEmitter<Trip[]>(); // Emit updated wishlist

  wishlist: Trip[] = []; // Store wishlist locally

  addToWishlist(trip: Trip) {
    this.wishlist = JSON.parse(localStorage.getItem('wishlist') || '[]');
    this.wishlist.push(trip); // Add trip to wishlist
    localStorage.setItem('wishlist', JSON.stringify(this.wishlist)); // Store in local storage

    this.wishlistUpdated.emit(this.wishlist); // Emit event to parent
    console.log("Added to Wishlist:", trip);
    alert(`${trip.name} has been added to your wishlist!`);
  }
}
