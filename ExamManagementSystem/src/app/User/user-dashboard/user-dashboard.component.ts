import { Component, OnInit } from '@angular/core';
import { UserService } from 'src/app/Services/User/user.service';

@Component({
  selector: 'app-user-dashboard',
  templateUrl: './user-dashboard.component.html',
  styleUrls: ['./user-dashboard.component.css']
})
export class UserDashboardComponent implements OnInit{
  constructor(private userService:UserService){}
  userId:any;
  dashBoardStats:any;
  passStats:any;
  ngOnInit(): void {
      this.userId=this.userService.getUserId();
      console.log("User Id :"+this.userId);
      if(this.userId){
        console.log("yes");
        this.getDashboardStats();
        this.getPassStats();

      }
  }
  getDashboardStats(){
    this.userService.getUserDashboardStats(this.userId).subscribe((data:any)=>{
      this.dashBoardStats=data.body;
      console.log("dash stats : "+this.dashBoardStats);

    })
  }

  getPassStats(){
    this.userService.getPassStats(this.userId).subscribe((data:any)=>{
      this.passStats=data.body;
      console.log("dash stats : "+this.passStats);

    })
  }
  

}
