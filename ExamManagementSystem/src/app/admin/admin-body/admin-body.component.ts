import { Component, Input, OnInit } from '@angular/core';
import { AdminService } from 'src/app/Services/admin/admin.service';

@Component({
  selector: 'app-admin-body',
  templateUrl: './admin-body.component.html',
  styleUrls: ['./admin-body.component.css']
})
export class AdminBodyComponent implements OnInit{
  ngOnInit(): void {
    
  }
  constructor(private adminService:AdminService){}
 
  @Input() collapsed = false;
  @Input() screenWidth = 0;

  
  getBodyClass():string{
    let styleClass ='body';

    if(this.adminService.toggleClicked==true){
      styleClass = 'body-trimmed';

    }
   
    if(this.collapsed && this.screenWidth >768 ) {
      styleClass = 'body-trimmed';
    }else if(this.collapsed && this.screenWidth <= 768 && this.screenWidth > 0) {
      styleClass = 'body-md-screen'
    }
    return styleClass;
  }
}
