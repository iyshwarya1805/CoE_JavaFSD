import { Component, OnInit } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-add-trip',
  templateUrl: './add-trip.component.html',
  styleUrls: ['./add-trip.component.css'],
  standalone: true,
  imports: [FormsModule, CommonModule]
})
export class AddTripComponent implements OnInit {
  trips: any[] = [];
  newTrip = { name: '', destination: '', date: '', experience: '', budget: '', description: '', image: '' };

  constructor() {}

  ngOnInit() {
    this.loadTripsFromLocalStorage(); // ✅ Load stored trips on component load
  }

  loadTripsFromLocalStorage() {
    const storedTrips = localStorage.getItem('trips');
    this.trips = storedTrips ? JSON.parse(storedTrips) : [];
  }

  onImageUpload(event: any) {
    const file = event.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e: any) => {
        this.newTrip.image = e.target.result; // Convert image to Base64
      };
      reader.readAsDataURL(file);
    }
  }

  addTrip() {
    if (this.newTrip.name && this.newTrip.destination && this.newTrip.date) {
      this.trips.push({ ...this.newTrip });
      localStorage.setItem('trips', JSON.stringify(this.trips)); // ✅ Save trips to local storage
      this.newTrip = { name: '', destination: '', date: '', experience: '', budget: '', description: '', image: '' };
    }
  }
}
