import { Component } from '@angular/core';
import { MenuBarComponent } from './components/menu-bar/menu-bar.component';
import { RouterModule } from '@angular/router';
import { Router } from '@angular/router';

@Component({
  selector: 'app-root',
  template: `
    <app-menu-bar></app-menu-bar>
    <router-outlet></router-outlet>
  `,
  standalone: true,
  imports: [MenuBarComponent, RouterModule]
})
export class AppComponent {


  constructor(private router: Router) {}

  logout() {
    localStorage.removeItem('user'); // Remove user session
    this.router.navigate(['/login']); // Redirect to login page
  }

  isLoggedIn() {
    return localStorage.getItem('user') !== null; // Check if user is logged in
  }
}
