import { Component, OnInit } from '@angular/core';
import { AdminService } from 'src/app/Services/admin/admin.service';

@Component({
  selector: 'app-admin-results',
  templateUrl: './admin-results.component.html',
  styleUrls: ['./admin-results.component.css']
})
export class AdminResultsComponent implements OnInit{

  constructor(private adminService:AdminService){}

  userResults:any;

  ngOnInit(): void {
      this.getUserResults();
  }
  getUserResults(){
    this.adminService.getUserResults().subscribe((data:any)=>{
      this.userResults=data.body;
      console.log(this.userResults);
    })
  }

}
