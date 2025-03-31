import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common'; // Import this
import { Trip } from '../models/trip.model';
import { TripService } from '../services/trip.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-trips',
  standalone: true, // 🚀 Standalone component
  imports: [CommonModule], // ✅ Include CommonModule to use ngFor, ngIf
  templateUrl: './trips.component.html',
  styleUrls: ['./trips.component.css'],
})
export class TripsComponent implements OnInit {
  trips: Trip[] = [];

  constructor(private tripService: TripService, private router: Router) {}

  ngOnInit() {
    this.tripService.getTrips().subscribe((data) => {
      this.trips = data.slice(0, 10);
    });
  }

  addToWishlist(trip: Trip) {
    this.tripService.addToWishlist(trip);
  }

  viewWishlist() {
    this.router.navigate(['/wishlist']);
  }
}
