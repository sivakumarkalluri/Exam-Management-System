import { Component, OnInit } from '@angular/core';
import { FormControl, FormGroup, Validators } from '@angular/forms';

@Component({
  selector: 'app-add-category',
  templateUrl: './add-category.component.html',
  styleUrls: ['./add-category.component.css']
})
export class AddCategoryComponent implements OnInit{

  ngOnInit(): void {
      
  }
  addCategoryForm=new FormGroup({
    categoryName:new FormControl("",[Validators.required]),
    categoryDesc:new FormControl("",[Validators.required])
  })

  get Name():FormControl{
    return this.addCategoryForm.get("categoryName") as FormControl;
  }
  get Desc():FormControl{
    return this.addCategoryForm.get("categoryDesc") as FormControl;
  }
}
