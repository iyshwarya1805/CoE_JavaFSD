import { Component } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent {
  username: string = '';

  constructor(private router: Router) {
    const user = localStorage.getItem('user');
    this.username = user ? JSON.parse(user).username : '';
  }

  logout() {
    localStorage.removeItem('user');
    this.router.navigate(['/login']);
  }
}
