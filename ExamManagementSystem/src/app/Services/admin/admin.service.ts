import { HttpClient } from '@angular/common/http';
import { Injectable, OnInit } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class AdminService implements OnInit{

  constructor(private http:HttpClient) { }
  toggleClicked=false;
  ngOnInit(): void {
   
  }
  
  baseUrl="https://localhost:7058/api";

  getAdminStats():any{
    return this.http.get(this.baseUrl+"/AdminDashboard/AdminStatistics", { observe: 'response' });
  }

  getCategories():any{
    return this.http.get(this.baseUrl+'/Categories', { observe: 'response' })
  }

  postCategoryExamsQuestions(data:any):any{
    return this.http.post(this.baseUrl+'/CreateCategoryExamQuestions',data, { observe: 'response' })
  }

  deleteCategory(id:any):any{
    return this.http.delete(this.baseUrl+'/DeleteCategory/'+id,{ observe: 'response' })
  }

  postNewExam(data:any){
    return this.http.post(this.baseUrl+'/AddExam',data, { observe: 'response' })
  }

  getExamPassStatistics():any{
    return this.http.get(this.baseUrl+'/AdminDashboard/ExamPassStats', { observe: 'response' });
  }
  getCategoryAttemptsStatistics():any{
    return this.http.get(this.baseUrl+'/AdminDashboard/CategoryAttemptStats', { observe: 'response' });
  }
  getExamAttemptsStatistics():any{
    return this.http.get(this.baseUrl+'/AdminDashboard/ExamAttemptsStats', { observe: 'response' })
  }

  getUsersData():any{
    return this.http.get(this.baseUrl+'/AdminDashboard/GetUsersData', { observe: 'response' })

  }

  getUserResults():any{
    return this.http.get(this.baseUrl+'/AdminDashboard/GetAdminUserResults', { observe: 'response' })

  }

  editCategory(data:any,id:any){
    return this.http.put(this.baseUrl+'/EditCategory/'+id,data, { observe: 'response' });
  }

  getCRUDExamData(){
    return this.http.get(this.baseUrl+'/GetExamCrudData',{ observe: 'response' })
  }
}
