import { NgModule,CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { HttpClientModule } from '@angular/common/http';

import { HomePageComponent } from './home-page/home-page.component';
import { LoginPageComponent } from './login-page/login-page.component';
import { SignUpPageComponent } from './sign-up-page/sign-up-page.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { UserDashboardComponent } from './User/user-dashboard/user-dashboard.component';
import { NavBarComponent } from './nav-bar/nav-bar.component';
import { AdminDashboardComponent } from './admin/admin-dashboard/admin-dashboard.component';
import { AdminNavBarComponent } from './admin/admin-nav-bar/admin-nav-bar.component';
import { AdminBodyComponent } from './admin/admin-body/admin-body.component';
import { AdminHomeComponent } from './admin/admin-home/admin-home.component';
import { AdminResultsComponent } from './admin/admin-results/admin-results.component';
import { AdminStudentsComponent } from './admin/admin-students/admin-students.component';
import { AdminExamsComponent } from './admin/admin-exams/admin-exams.component';
import { AdminProfileComponent } from './admin/admin-profile/admin-profile.component';
import { AdminEditExamsComponent } from './admin/admin-edit-exams/admin-edit-exams.component';


@NgModule({
  declarations: [
    AppComponent,
    HomePageComponent,
    LoginPageComponent,
    SignUpPageComponent,
    UserDashboardComponent,
    NavBarComponent,
    AdminDashboardComponent,
    AdminNavBarComponent,
    AdminBodyComponent,
    AdminHomeComponent,
    AdminResultsComponent,
    AdminStudentsComponent,
    AdminExamsComponent,
    AdminExamsComponent,
    AdminProfileComponent,
    AdminEditExamsComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
