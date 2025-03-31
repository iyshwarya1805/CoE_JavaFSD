import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Trip } from '../models/trip.model';

@Injectable({
  providedIn: 'root',
})
export class TripService {
  private apiUrl = 'http://localhost:3000/trips'; // ✅ Ensure json-server is running

  private wishlist: Trip[] = [];

  constructor(private http: HttpClient) {}

  getTrips(): Observable<Trip[]> {
    return this.http.get<Trip[]>(this.apiUrl);
  }

  addToWishlist(trip: Trip) {
    if (!this.wishlist.find(t => t.id === trip.id)) {
      this.wishlist.push(trip);
    }
  }

  
  getWishlist(): Trip[] {
    return JSON.parse(localStorage.getItem('wishlist') || '[]');
  }
  
}
