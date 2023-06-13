import { Router } from '@angular/router';
import { AuthenticationService } from './../Services/authentication/authentication.service';
import { Component, OnInit } from '@angular/core';
import { ToasterService } from '../Services/Toaster/toaster.service';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {
  constructor(private authService:AuthenticationService,private router:Router,private toastr: ToastrService){}
  access="";
  ngOnInit(): void {
    const access_token = localStorage.getItem('access_token');
    this.access = access_token !== null ? access_token : ''; 
  }
  logOut() {
    this.authService.removeToken();
    this.router.navigate(['/']).then(() => {
      window.location.reload();
    });
  
    function waitOneSecond(callback: () => void): void {
      setTimeout(callback, 1000);
    }
  
    // Example usage
    console.log("Start");
    waitOneSecond(() => {
      console.log("One second has passed");
    });
  
    window.addEventListener("load", () => {
      this.toastr.success("Logged Out Successfully...");
    });
  }
  
  
  
  dashboard(){
    this.authService.loadCurrentUser();
    console.log(this.authService.roleCheck);
    if(this.authService.roleCheck=="Admin"){
     
      this.router.navigate(['adminHome/adminDashboard']);
    }
    else{
      this.router.navigate(['/userDashboard']);
    }
  }

}
