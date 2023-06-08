import { AuthenticationService } from './../Services/authentication/authentication.service';
import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login-page',
  templateUrl: './login-page.component.html',
  styleUrls: ['./login-page.component.css']
})
export class LoginPageComponent implements OnInit{

  constructor(private authService:AuthenticationService,private router:Router){}
   ngOnInit(): void {
  
      
  }

  isUserValid:boolean=false;
  loginForm=new FormGroup({
    email:new FormControl("",[Validators.required,Validators.email]),
    pwd:new FormControl("",[Validators.required])
  })

  
  loginSubmit(){
    this.authService.loginUser([this.loginForm.value.email as String,this.loginForm.value.pwd as String]).subscribe(res=>{
      if(res=="failure"){
        this.isUserValid=false;
        alert("Login UnSuccessfull");
      }
      else{
        this.isUserValid=true;
        this.authService.setToken(res);
        if(this.authService.roleCheck=="User"){
          this.router.navigate(['/userDashboard']);
        }
        else{
          this.router.navigate(['adminHome/adminDashboard']);
        }
      }

    })
  }

  
  get Email():FormControl{
    return this.loginForm.get("email") as FormControl;
  }
  get Pwd():FormControl{
    return this.loginForm.get("pwd") as FormControl;
  }


}
