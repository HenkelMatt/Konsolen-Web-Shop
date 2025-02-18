import { Component } from '@angular/core';

@Component({
  selector: 'app-login-signup',
  templateUrl: './login-signup.component.html',
  styleUrls: ['./login-signup.component.css']
})
export class LoginSignupComponent {
  isSignup = false; // Default to login form

  loginData = {
    email: '',
    password: ''
  };

  signupData = {
    username: '',
    email: '',
    phone: '',
    password: ''
  };

  // Toggle between Login and Signup
  toggleForm() {
    this.isSignup = !this.isSignup;
  }

  // Handle Login form submission
  onSubmitLogin() {
    if (this.loginData.email && this.loginData.password) {
      console.log('Login Data:', this.loginData);
      // Handle your login logic here
    } else {
      console.log('Please fill out the form correctly.');
    }
  }

  // Handle Signup form submission
  onSubmitSignup() {
    if (this.signupData.username && this.signupData.email && this.signupData.phone && this.signupData.password) {
      console.log('Signup Data:', this.signupData);
      // Handle your signup logic here
    } else {
      console.log('Please fill out the form correctly.');
    }
  }
}
