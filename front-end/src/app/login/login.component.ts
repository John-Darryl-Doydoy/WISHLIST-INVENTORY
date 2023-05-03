import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit{
  username: string = "";
  password: string = "";
  errorMessage: string ="";



  constructor(private http: HttpClient, private router: Router) { }

  ngOnInit() {
  }

  login() {
 
    const userLogin = { UserName: this.username, Password: this.password };

    this.http.post('https://localhost:44340/api/login', userLogin).subscribe(
      (response: any) => {
       
        console.log('Login successful');
        this.router.navigate(['/home']);
      },

      (error: any) => {
       
        console.error('Login failed:', error);
        this.errorMessage = error.error;
      }
    );
  }
}
