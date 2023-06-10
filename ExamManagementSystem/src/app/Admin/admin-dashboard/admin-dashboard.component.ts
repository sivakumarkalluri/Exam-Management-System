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
  loadingError:any;
  ngOnInit(): void {
   this.getAdminStatistics();
  }
  getAdminStatistics() {
    this.adminService.getAdminStats().subscribe(
      (response: any) => {
        this.adminStats = response.body;
        console.log(this.adminStats);
      },
      (error: any) => {
        this.loadingError = true;
        console.log('Unable to fetch the data. Please try again.');
      }
    );

 
    }
   
}



