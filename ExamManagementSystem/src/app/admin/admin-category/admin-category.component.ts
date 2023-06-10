import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { AdminService } from 'src/app/Services/admin/admin.service';

@Component({
  selector: 'app-admin-category',
  templateUrl: './admin-category.component.html',
  styleUrls: ['./admin-category.component.css']
})
export class AdminCategoryComponent implements OnInit{

  constructor(private router:Router,private adminService:AdminService){}

  categoryData:any;
  loadingError:any;
  ngOnInit(): void {
      this.getCategoriesData();
  }
  getCategoriesData(){
    this.adminService.getCategories().subscribe(
      (response: any) => {
        this.categoryData = response.body;
        console.log(this.categoryData);
      },
      (error: any) => {
        this.loadingError = true;
        console.log('Unable to fetch the data. Please try again.');
      }
    );
  }
  addCategory(){
    this.router.navigate(['/adminHome/addCategory'])
  }
}


