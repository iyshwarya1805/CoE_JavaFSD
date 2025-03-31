import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-grand-canyon-details',
  templateUrl: './grand-canyon-details.component.html',
  styleUrls: ['./grand-canyon-details.component.css']
})
export class GrandCanyonDetailsComponent {
  constructor(private router: Router) {}

  goBack() {
    this.router.navigate(['/destinations']);
  }
}
