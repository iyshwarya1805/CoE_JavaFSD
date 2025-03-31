import { Component, OnInit } from '@angular/core';
import { Trip } from '../../models/trip.model';
import { TripService } from '../../services/trip.service';

@Component({
  selector: 'app-wishlist',
  templateUrl: './wishlist.component.html',
  styleUrls: ['./wishlist.component.css'],
})
export class WishlistComponent implements OnInit {
  wishlist: Trip[] = [];

  ngOnInit() {
    this.loadWishlist(); // Load wishlist on init
  }

  loadWishlist() {
    this.wishlist = JSON.parse(localStorage.getItem('wishlist') || '[]');
    console.log("Wishlist Loaded:", this.wishlist);
  }
}
