import { Component, EventEmitter, HostListener, OnInit, Output } from '@angular/core';
import { navbarData } from './NavData';
import { AdminService } from 'src/app/Services/admin/admin.service';

interface SideNavToggle {
  screenWidth: number;
  collapsed: boolean;
}

@Component({
  selector: 'app-admin-nav-bar',
  templateUrl: './admin-nav-bar.component.html',
  styleUrls: ['./admin-nav-bar.component.css']
})
export class AdminNavBarComponent implements OnInit{

  constructor(private adminService:AdminService){}
  @Output() onToggleSideNav: EventEmitter<SideNavToggle> = new EventEmitter();
  collapsed = false;
  screenWidth = 0;
  navData = navbarData;
  
  ngOnInit(): void {
    this.screenWidth = window.innerWidth;
    console.log("screen : "+this.screenWidth);
    
  }

  @HostListener('window:resize', ['$event'])
  onResize(event:any) {
    this.screenWidth= window.innerWidth;
    if(this.screenWidth <= 768) {
      this.collapsed=false;
      this.onToggleSideNav.emit({collapsed: this.collapsed, screenWidth:this.screenWidth});
    }
  }


  toggleCollapse(): void {
    this.adminService.toggleClicked=true;
    this.collapsed = !this.collapsed;
     this.onToggleSideNav.emit({collapsed: this.collapsed, screenWidth:this.screenWidth});
  }

  closeSidenav(): void{
    this.adminService.toggleClicked=false;
    this.collapsed = false;
    this.onToggleSideNav.emit({collapsed: this.collapsed, screenWidth:this.screenWidth});
  }
}
