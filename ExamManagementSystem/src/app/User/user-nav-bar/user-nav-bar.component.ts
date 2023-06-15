import { Component, EventEmitter, HostListener, OnInit, Output } from '@angular/core';
import { AdminService } from 'src/app/Services/admin/admin.service';
import { navUserData } from './NavData';

interface SideNavToggle {
  screenWidth: number;
  collapsed: boolean;
}
@Component({
  selector: 'app-user-nav-bar',
  templateUrl: './user-nav-bar.component.html',
  styleUrls: ['./user-nav-bar.component.css']
})
export class UserNavBarComponent implements OnInit{

  constructor(private adminService:AdminService){}
  ngOnInit(): void {
    this.screenWidth = window.innerWidth;

  }
  @Output() onToggleSideNav: EventEmitter<SideNavToggle> = new EventEmitter();
  collapsed = false;
  screenWidth = 0;
  navData = navUserData;

  
  @HostListener('window:resize', ['$event'])
  onResize(event:any) {
    this.screenWidth= window.innerWidth;
    if(this.screenWidth <= 768) {
      this.collapsed=false;
      this.onToggleSideNav.emit({collapsed: this.collapsed, screenWidth:this.screenWidth});
    }
  }


  toggleCollapse(): void {
    this.adminService.toggleClicked=!this.adminService.toggleClicked;
    this.collapsed = !this.collapsed;
     this.onToggleSideNav.emit({collapsed: this.collapsed, screenWidth:this.screenWidth});
  }

  closeSidenav(): void{
    this.adminService.toggleClicked=!this.adminService.toggleClicked;
    this.collapsed = false;
    this.onToggleSideNav.emit({collapsed: this.collapsed, screenWidth:this.screenWidth});
  }

}
