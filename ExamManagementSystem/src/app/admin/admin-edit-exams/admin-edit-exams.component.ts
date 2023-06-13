import { Component, OnInit } from '@angular/core';
import { AdminService } from 'src/app/Services/admin/admin.service';

@Component({
  selector: 'app-admin-edit-exams',
  templateUrl: './admin-edit-exams.component.html',
  styleUrls: ['./admin-edit-exams.component.css']
})
export class AdminEditExamsComponent implements OnInit{
  constructor(private adminService:AdminService){}
  examData:any;
  ngOnInit(): void {
      this.getCRUDExamData();
  }
  getCRUDExamData(){
    this.adminService.getCRUDExamData().subscribe((data:any)=>{
      this.examData=data.body;
      console.log(this.examData);
      this.processData(this.examData);
    })
  }
  
    transformedData!: any[];
  
    // Assuming you have the response data stored in a variable called 'responseData'
    processData(responseData: any[]) {
      const transformedData: any[] = [];
  
      const categoryMap: { [key: string]: any } = {};
  
      responseData.forEach((item: any) => {
        const categoryName = item.category_Name;
        const exam = {
          exam_Id: item.exam_Id,
          exam_Name: item.exam_Name,
          exam_totalquestion: item.exam_totalquestion,
          total_Exams: item.total_Exams,
        };
  
        if (categoryMap.hasOwnProperty(categoryName)) {
          categoryMap[categoryName].exams.push(exam);
        } else {
          categoryMap[categoryName] = {
            category_Name: categoryName,
            exams: [exam],
          };
        }
      });
  
      for (const key in categoryMap) {
        if (categoryMap.hasOwnProperty(key)) {
          transformedData.push(categoryMap[key]);
        }
      }
  
      this.transformedData = transformedData;
      console.log(this.transformedData);
    }
  
  
  


}
