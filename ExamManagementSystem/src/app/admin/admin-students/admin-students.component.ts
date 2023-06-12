import { Component, OnInit } from '@angular/core';
import { AdminService } from 'src/app/Services/admin/admin.service';

@Component({
  selector: 'app-admin-students',
  templateUrl: './admin-students.component.html',
  styleUrls: ['./admin-students.component.css']
})
export class AdminStudentsComponent implements OnInit{
  
  constructor(private adminService:AdminService){

  }
  usersData:any;

  ngOnInit(): void {
      this.getUsersData();
  }

  getUsersData(){
    this.adminService.getUsersData().subscribe((data:any)=>{
      this.usersData=data.body;
      console.log(this.usersData);
    })
  }
  

}
