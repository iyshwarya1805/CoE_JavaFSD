import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';  
import { ReactiveFormsModule } from '@angular/forms'; 

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css'],
  standalone: true,  // ✅ Standalone component
  imports: [CommonModule, ReactiveFormsModule] 
})
export class LoginComponent {
  loginForm: FormGroup;
  errorMessage: string = '';

  constructor(private fb: FormBuilder, private router: Router) {
    this.loginForm = this.fb.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    });
  }

  login() {
    const { username, password } = this.loginForm.value;
  
    if (username === 'iysh' && password === '123') {
      localStorage.setItem('user', JSON.stringify({ username }));
      this.router.navigate(['/dashboard']); // ✅ Redirect to Dashboard after login
    } else {
      this.errorMessage = 'Invalid username or password!';
    }
  }
  
}
