import { HttpClient } from '@angular/common/http';
import { Injectable, OnInit } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class AdminService implements OnInit{

  constructor(private http:HttpClient) { }
  toggleClicked=false;
  ngOnInit(): void {
   
  }
  
  baseUrl="https://localhost:7058/api/AdminDashboard/";

  getAdminStats():any{
    return this.http.get(this.baseUrl+'AdminStatistics');
  }

}
