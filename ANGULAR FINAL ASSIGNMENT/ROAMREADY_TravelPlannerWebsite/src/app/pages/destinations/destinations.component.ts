import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';  // ✅ Import FormsModule
import { DestinationService } from '../../services/destination.service';
import { HighlightPipe } from '../../pipes/highlight.pipe';  // ✅ Import HighlightPipe
import { FilterByPropertyPipe } from '../../pipes/filter-by-property.pipe';  // ✅ Import FilterByPropertyPipe
import { Router } from '@angular/router'; 
@Component({
  selector: 'app-destinations',
  templateUrl: './destinations.component.html',
  styleUrls: ['./destinations.component.css'],
  standalone: true,
  imports: [CommonModule, FormsModule, HighlightPipe, FilterByPropertyPipe] // ✅ Include FormsModule
})
export class DestinationsComponent implements OnInit {
  destinations: any[] = [];
  searchKeyword: string = '';  // Store the search keyword for filtering

  constructor(private destinationService: DestinationService, private router: Router) {}
  ngOnInit() {
    this.destinationService.getDestinations().subscribe(
      (data) => {
        console.log('✅ Destinations Fetched:', data);
        this.destinations = data;
      },
      (error) => {
        console.error('❌ Error fetching destinations:', error);
      }
    );
  }
  viewDestination(destination: any) {
    if (destination.name === 'Bali Paradise') {
      this.router.navigate(['/destinations/bali']);
    } else if (destination.name === 'Grand Canyon') {
      this.router.navigate(['/destinations/grand-canyon']);
    } else if (destination.name === 'Dubai Burj Khalifa') {
      this.router.navigate(['/destinations/dubai']);
    } else {
      alert('Detailed page is only available for Bali, Grand Canyon, and Dubai.');
    }
  }
  
}
