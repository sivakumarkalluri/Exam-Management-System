import { Component, EventEmitter, HostListener, Input, OnInit, Output } from '@angular/core';
import { AdminService } from 'src/app/Services/admin/admin.service';



@Component({
  selector: 'app-admin-dashboard',
  templateUrl: './admin-dashboard.component.html',
  styleUrls: ['./admin-dashboard.component.css']
})
export class AdminDashboardComponent implements OnInit{
  constructor(private adminService:AdminService){}
  examsData:any;
  ngOnInit(): void {
   this.adminService.getExamData().subscribe((data:any)=>{
    this.examsData=data;
   })
  }
   
}



