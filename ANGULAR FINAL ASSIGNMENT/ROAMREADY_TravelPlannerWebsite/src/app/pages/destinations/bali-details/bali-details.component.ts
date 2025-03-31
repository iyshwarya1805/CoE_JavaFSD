import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-bali-details',
  templateUrl: './bali-details.component.html',
  styleUrls: ['./bali-details.component.css']
})
export class BaliDetailsComponent {
  constructor(private router: Router) {}

  goBack() {
    this.router.navigate(['/destinations']);
  }
}
