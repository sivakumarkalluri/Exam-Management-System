import { UserDashboardComponent } from './User/user-dashboard/user-dashboard.component';
import { AdminDashboardComponent } from './Admin/admin-dashboard/admin-dashboard.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { HomePageComponent } from './home-page/home-page.component';
import { LoginPageComponent } from './login-page/login-page.component';
import { SignUpPageComponent } from './sign-up-page/sign-up-page.component';

const routes: Routes = [
 {path:'',redirectTo:'homePage',pathMatch:'full'},
 {path:'homePage',component:HomePageComponent},
 {path:'loginPage',component:LoginPageComponent},
 {path:'signUpPage',component:SignUpPageComponent},
 {path:'adminDashboard',component:AdminDashboardComponent},
 {path:'userDashboard',component:UserDashboardComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
