import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { JwtHelperService } from '@auth0/angular-jwt';
import { BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AuthenticationService {

  constructor(private http:HttpClient) { }
  ngOnInit(): void {
      
  }
  currentUser:BehaviorSubject<any>=new BehaviorSubject(null);
  jwtHelperService=new JwtHelperService();
  
  roleCheck="";
  baseUrl="https://localhost:7058/api/UserData";
  registerUser(data:Array<String>){
    return this.http.post(this.baseUrl,{
     FirstName:data[0],
     LastName:data[1],
     Email:data[2],
     Mobile:data[3],
     Password:data[4],
     Gender:data[5],
     Role:data[6]
    },{
      responseType:'text'
    });
  }

  loginUser(loginData:Array<String>){
    return this.http.post(this.baseUrl+"/LoginUser",{
      Email:loginData[0],
      Password:loginData[1],
      Role:""
    },{
      responseType:'text'
    }
    )
  }
  setToken(token:string){
    localStorage.setItem("access_token",token);
    this.loadCurrentUser();
  }

  loadCurrentUser(){
    const token=localStorage.getItem("access_token");
    const userInfo=token !=null ? this.jwtHelperService.decodeToken(token):null;
    console.log(userInfo);
    this.roleCheck=userInfo.role;
    const data=userInfo ?{
      id:userInfo.id,
      firstName:userInfo.firstName,
      lastName:userInfo.lastName,
      email:userInfo.email,
      mobile:userInfo.mobile,
      role:userInfo.role
    }:null;
    this.currentUser.next(data);
  }
}