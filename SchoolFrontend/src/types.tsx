export interface Course {
  course_id: number;
  course_prefix: string;
  course_number: number;
  semesters: string;
  //year: number;
  credits: number;
  //instructorId: string;
  year?: number;
  semester?: string;
}

export interface Enrollment {
  student_id: string; // Matches the 'student_id' field
  course_id: number;  // Matches the 'course_id' field
  semester: string;  // Matches the 'semester' field (e.g., 'F' for Fall, 'S' for Spring)
  year_taken: number; // Matches the 'year_taken' field
  grade: string;     // Matches the 'grade' field (e.g., 'A', 'B', etc.)
  course_prefix?: string; // New property for course prefix
  course_number?: number; // New property for course number
  credits?: number;       // New property for course credits
  course: Course  // New property for course name
}

export interface Student {
  student_id: string;
  first_name: string;
  last_name: string;
  department_id: string;
  major: string;
  gpa: number;
  totalCredits: number;
}

export type Role = "staff" | "advisor" | "student" | "instructor";

export const emptyCourse: Course = {
  course_id: 0,
  course_prefix: "",
  course_number: 0,
  semesters: "",
  //year: 2000,
  credits: 0,
  //instructorId: "",
};

export const emptyEnrollment: Enrollment = {
  course: emptyCourse,
  course_id: 0,
  grade: "A",
  semester: "F", // Example default semester (e.g., "F" for Fall)
  year_taken: 2024, // Example default year
  student_id: "", // Empty string as a placeholder
};

