import { Component, Input, OnInit } from '@angular/core';

@Component({
  selector: 'app-admin-body',
  templateUrl: './admin-body.component.html',
  styleUrls: ['./admin-body.component.css']
})
export class AdminBodyComponent implements OnInit{
  ngOnInit(): void {
    
  }
 
  @Input() collapsed = false;
  @Input() screenWidth = 0;

  
  getBodyClass():string{
    let styleClass ='';
    if(this.collapsed && this.screenWidth >768 ) {
      styleClass = 'body-trimmed';
    }else if(this.collapsed && this.screenWidth <= 768 && this.screenWidth > 0) {
      styleClass = 'body-md-screen'
    }
    return styleClass;
  }
}
