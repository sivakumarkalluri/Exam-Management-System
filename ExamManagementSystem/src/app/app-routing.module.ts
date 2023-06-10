import { AdminDashboardComponent } from './admin/admin-dashboard/admin-dashboard.component';
import { UserDashboardComponent } from './User/user-dashboard/user-dashboard.component';

import { NgModule } from '@angular/core';

import { RouterModule, Routes } from '@angular/router';
import { HomePageComponent } from './home-page/home-page.component';
import { LoginPageComponent } from './login-page/login-page.component';
import { SignUpPageComponent } from './sign-up-page/sign-up-page.component';
import { AdminHomeComponent } from './admin/admin-home/admin-home.component';
import { AdminProfileComponent } from './admin/admin-profile/admin-profile.component';
import { AdminExamsComponent } from './admin/admin-exams/admin-exams.component';
import { AdminStudentsComponent } from './admin/admin-students/admin-students.component';
import { AdminResultsComponent } from './admin/admin-results/admin-results.component';
import { AdminEditExamsComponent } from './admin/admin-edit-exams/admin-edit-exams.component';
import { AdminCategoryComponent } from './admin/admin-category/admin-category.component';
import { AddCategoryComponent } from './admin/add-category/add-category.component';


const routes: Routes = [
 {path:'',redirectTo:'homePage',pathMatch:'full'},
 {path:'homePage',component:HomePageComponent},
 {path:'loginPage',component:LoginPageComponent},
 {path:'signUpPage',component:SignUpPageComponent},
 {path:'userDashboard',component:UserDashboardComponent},

 { path: 'adminHome', component: AdminHomeComponent, children: [
  { path: 'adminDashboard', component: AdminDashboardComponent },
  { path: 'adminProfile', component: AdminProfileComponent },
  { path: 'adminExams', component: AdminExamsComponent },
  { path: 'adminStudents', component: AdminStudentsComponent },
  { path: 'adminResults', component: AdminResultsComponent },
  {path:'adminEditExams',component:AdminEditExamsComponent},
  {path:'adminCategories',component:AdminCategoryComponent},
  {path:'addCategory',component:AddCategoryComponent}
]}

 
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
