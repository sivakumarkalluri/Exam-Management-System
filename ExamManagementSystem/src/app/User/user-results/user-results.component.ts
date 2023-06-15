import { Component, OnInit } from '@angular/core';
import { UserService } from 'src/app/Services/User/user.service';

@Component({
  selector: 'app-user-results',
  templateUrl: './user-results.component.html',
  styleUrls: ['./user-results.component.css']
})
export class UserResultsComponent implements OnInit{

  constructor(private userService:UserService){}
  userId:any;
  userResults:any;
  ngOnInit(): void {
    this.userId=this.userService.getUserId();
      console.log("User Id :"+this.userId);
      if(this.userId){
        this.getAllResults();
      }
      
  }

  getAllResults(){
    this.userService.getUserResultsAll(this.userId).subscribe((data:any)=>{
      this.userResults=data.body;
      console.log("user Results all : "+this.userResults);
    })
  }
}
