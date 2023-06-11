import { Component, OnInit, ViewChild } from '@angular/core';
import { FormArray, FormBuilder, FormControl, FormGroup, Validators } from '@angular/forms';
import { MatStepper } from '@angular/material/stepper';

@Component({
  selector: 'app-add-category',
  templateUrl: './add-category.component.html',
  styleUrls: ['./add-category.component.css']
})
export class AddCategoryComponent implements OnInit {
  questions: any[] = []; // Array to store the questions
  currentQuestionIndex = 0; // Index of the currently displayed question
  formValues: any[] = []; // Array to store the form values
  currentForm!: FormGroup;
  submitted = false;
  totalQuestion:any;

  @ViewChild(MatStepper) stepper!: MatStepper;

  constructor(private formBuilder: FormBuilder) {
    this.addCategoryForm.controls['categoryName'].valueChanges.subscribe(value => {
      this.addExamForm.patchValue({ categoryName: value });
    });
  }

  ngOnInit(): void {
   
    this.addExamForm.controls["examTotalQuestion"].valueChanges.subscribe(value => {
      this.totalQuestion = value;
      this.createQuestions(this.totalQuestion);
      this.createForm();
      console.log(this.totalQuestion);
    });
  
  }
  createQuestions(totalQuestions: number) {
    this.questions = [];
    for (let i = 0; i < totalQuestions; i++) {
      const question = {
        questionDescription: '',
        option1: '',
        option2: '',
        option3: '',
        option4: '',
        answer: ''
      };
      this.questions.push(question);
    }
  }

  get formControls() {
    return this.currentForm.controls;
  }

  createForm() {
    const currentQuestion = this.questions[this.currentQuestionIndex];
    this.currentForm = this.formBuilder.group({
      questionDescription: [currentQuestion.questionDescription, Validators.required],
      option1: [currentQuestion.option1, Validators.required],
      option2: [currentQuestion.option2, Validators.required],
      option3: [currentQuestion.option3, Validators.required],
      option4: [currentQuestion.option4, Validators.required],
      answer: [currentQuestion.answer, Validators.required]
    });

    // Set the form values from the stored array if they exist
    if (this.formValues[this.currentQuestionIndex]) {
      this.currentForm.patchValue(this.formValues[this.currentQuestionIndex]);
    }
  }

  goToPreviousQuestion() {
    if (this.currentQuestionIndex > 0) {
      // Store the form values before moving to the previous question
      this.formValues[this.currentQuestionIndex] = this.currentForm.value;

      this.currentQuestionIndex--;
      this.createForm();
    }
  }

  goToNextQuestion() {
    if (this.currentForm.valid) {
      // Store the form values before moving to the next question
      this.formValues[this.currentQuestionIndex] = this.currentForm.value;

      this.currentQuestionIndex++;
      if (this.currentQuestionIndex === this.questions.length) {
        // All questions have been answered
        console.log('All questions answered!');
        console.log(this.formValues);
        return;
      }
      this.createForm();
    } else {
      this.submitted = true;
    }
  }

  onSubmit() {
    this.submitted = true;
    if (this.currentForm.valid) {
      // Store the form values before submitting
      this.formValues[this.currentQuestionIndex] = this.currentForm.value;

      console.log('Form submitted successfully!');
      console.log(this.formValues);
    }
  }

  addCategoryForm = new FormGroup({
    categoryName: new FormControl("", [Validators.required]),
    categoryDesc: new FormControl("", [Validators.required])
  });

  addExamForm = new FormGroup(
    {
      categoryName: new FormControl({ value: this.addCategoryForm.value.categoryName, disabled: true }),
      examName: new FormControl("", [Validators.required]),
      examDesc: new FormControl("", [Validators.required]),
      examDuration: new FormControl("", [Validators.required]),
      questionMark: new FormControl("", [Validators.required]),
      examTotalQuestion: new FormControl("", [Validators.required]),
      examPassPercent: new FormControl("", [Validators.required])
    }
  );

  get Name(): FormControl {
    return this.addCategoryForm.get("categoryName") as FormControl;
  }

  get Desc(): FormControl {
    return this.addCategoryForm.get("categoryDesc") as FormControl;
  }

  get ExamName(): FormControl {
    return this.addExamForm.get("examName") as FormControl;
  }

  get ExamDesc(): FormControl {
    return this.addExamForm.get("examDesc") as FormControl;
  }

  get ExamDur(): FormControl {
    return this.addExamForm.get("examDuration") as FormControl;
  }

  get QueMark(): FormControl {
    return this.addExamForm.get("questionMark") as FormControl;
  }

  get TotalQue(): FormControl {
    return this.addExamForm.get("examTotalQuestion") as FormControl;
  }

  get PassPercent(): FormControl {
    return this.addExamForm.get("examPassPercent") as FormControl;
  }
}
