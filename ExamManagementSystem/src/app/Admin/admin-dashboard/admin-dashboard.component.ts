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
  passStatistics:any;
  examAttemptStatistics:any;
  categoryAttemptStatistics:any;
  ngOnInit(): void {
   this.getAdminStatistics();
   this.getExamPassStatistics();
   this.getCategoryAttemptStatistics();
   this.getExamAttemptsStatistics();
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

    getExamPassStatistics(){
      this.adminService.getExamPassStatistics().subscribe((data:any)=>{
        this.passStatistics=data.body;
        console.log("pass statistics : ",data);
        
      })

    }
    getExamAttemptsStatistics(){
      this.adminService.getExamAttemptsStatistics().subscribe((data:any)=>{
        this.examAttemptStatistics=data.body;
        console.log("Exam attempt statistics : ",data.body);
      })

    }
    getCategoryAttemptStatistics(){
      this.adminService.getCategoryAttemptsStatistics().subscribe((data:any)=>{
        this.categoryAttemptStatistics=data.body;
        console.log("Category attempt statistics : ",data.body);

      })
    }
   
}



