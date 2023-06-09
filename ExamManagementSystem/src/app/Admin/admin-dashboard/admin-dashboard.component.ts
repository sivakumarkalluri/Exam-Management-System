import { Component, EventEmitter, HostListener, Input, OnInit, Output } from '@angular/core';
import { AdminService } from 'src/app/Services/admin/admin.service';



@Component({
  selector: 'app-admin-dashboard',
  templateUrl: './admin-dashboard.component.html',
  styleUrls: ['./admin-dashboard.component.css']
})
export class AdminDashboardComponent implements OnInit{
  constructor(private adminService:AdminService){}
  adminStats:any;
  ngOnInit(): void {
   this.getAdminStatistics();
  }
  getAdminStatistics(){
    this.adminService.getAdminStats().subscribe((data:any)=>{
      this.adminStats=data;
      console.log(this.adminStats);
    })
  }
 

   
}



