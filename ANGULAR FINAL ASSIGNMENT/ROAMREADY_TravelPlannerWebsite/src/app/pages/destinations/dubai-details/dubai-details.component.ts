import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-dubai-details',
  templateUrl: './dubai-details.component.html',
  styleUrls: ['./dubai-details.component.css']
})
export class DubaiDetailsComponent {
  constructor(private router: Router) {}

  goBack() {
    this.router.navigate(['/destinations']);
  }
}
