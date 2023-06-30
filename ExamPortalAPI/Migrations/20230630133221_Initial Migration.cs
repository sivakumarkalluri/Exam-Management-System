using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ExamPortalAPI.Migrations
{
    /// <inheritdoc />
    public partial class InitialMigration : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "categories",
                columns: table => new
                {
                    CategoryId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CategoryName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    CategoryDesc = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_categories", x => x.CategoryId);
                });

            migrationBuilder.CreateTable(
                name: "examImages",
                columns: table => new
                {
                    exam_Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    imagePath = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                });

            migrationBuilder.CreateTable(
                name: "exams",
                columns: table => new
                {
                    ExamId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Category_Id = table.Column<int>(type: "int", nullable: false),
                    ExamName = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ExamDescription = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    ExamDuration = table.Column<int>(type: "int", nullable: false),
                    QuestionMark = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    ExamTotalQuestion = table.Column<int>(type: "int", nullable: false),
                    ExamPassPercent = table.Column<decimal>(type: "decimal(18,2)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_exams", x => x.ExamId);
                });

            migrationBuilder.CreateTable(
                name: "questions",
                columns: table => new
                {
                    question_id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    exam_id = table.Column<int>(type: "int", nullable: false),
                    category_id = table.Column<int>(type: "int", nullable: false),
                    question_desc = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    option_1 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    option_2 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    option_3 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    option_4 = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    correctAnswer = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_questions", x => x.question_id);
                });

            migrationBuilder.CreateTable(
                name: "userExamDatas",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    testId = table.Column<int>(type: "int", nullable: false),
                    userId = table.Column<int>(type: "int", nullable: false),
                    exam_id = table.Column<int>(type: "int", nullable: false),
                    category_id = table.Column<int>(type: "int", nullable: false),
                    question_id = table.Column<int>(type: "int", nullable: false),
                    answer = table.Column<int>(type: "int", nullable: true),
                    attemptedAt = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_userExamDatas", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "userResults",
                columns: table => new
                {
                    ResultId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TestId = table.Column<int>(type: "int", nullable: false),
                    UserId = table.Column<int>(type: "int", nullable: false),
                    Exam_Id = table.Column<int>(type: "int", nullable: false),
                    Category_Id = table.Column<int>(type: "int", nullable: false),
                    Attempted_Questions = table.Column<int>(type: "int", nullable: false),
                    NotAttempted_Questions = table.Column<int>(type: "int", nullable: false),
                    Correct_Answers = table.Column<int>(type: "int", nullable: false),
                    Wrong_Answers = table.Column<int>(type: "int", nullable: false),
                    Total_MarksObtained = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Exam_Total = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Percentage = table.Column<decimal>(type: "decimal(18,2)", nullable: false),
                    Pass_Flag = table.Column<bool>(type: "bit", nullable: false),
                    AttemptedAt = table.Column<DateTime>(type: "datetime2", nullable: false),
                    passPercentageRequired = table.Column<decimal>(type: "decimal(18,2)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_userResults", x => x.ResultId);
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "categories");

            migrationBuilder.DropTable(
                name: "examImages");

            migrationBuilder.DropTable(
                name: "exams");

            migrationBuilder.DropTable(
                name: "questions");

            migrationBuilder.DropTable(
                name: "userExamDatas");

            migrationBuilder.DropTable(
                name: "userResults");
        }
    }
}
