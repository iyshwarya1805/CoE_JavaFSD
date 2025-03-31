import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';  
import { ReactiveFormsModule } from '@angular/forms'; 

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'],
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule]
})
export class HomeComponent {
  loginForm: FormGroup;
  errorMessage: string = '';
  isLoggedIn: boolean = false;

  constructor(private fb: FormBuilder, private router: Router) {
    this.loginForm = this.fb.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    });

    // Check if user is already logged in
    this.isLoggedIn = !!localStorage.getItem('user');
  }
  navigateTo(path: string) {
    this.router.navigate([path]);
  }
  login() {
    const { username, password } = this.loginForm.value;

    if (username === 'iysh' && password === '123') {
      localStorage.setItem('user', JSON.stringify({ username }));
      this.isLoggedIn = true;
      this.router.navigate(['/']); // Stay on home page, but show dashboard
    } else {
      this.errorMessage = 'Invalid username or password!';
    }
  }

  logout() {
    localStorage.removeItem('user');
    this.isLoggedIn = false;
    this.router.navigate(['/']);  // Redirect back to home after logout
  }
}
