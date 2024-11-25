import { useState, useEffect } from "react";
import { Enrollment, Student, Course } from "../types";

const StudentInfo = ({ studentId }: { studentId: string }) => {
  const [student, setStudent] = useState<Student | null>(null);
  const [currentEnrollments, setCurrentEnrollments] = useState<Enrollment[]>([]);
  const [pastEnrollments, setPastEnrollments] = useState<Enrollment[]>([]);
  const [departmentName, setDepartmentName] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);



  const fetchData = async (url: string) => {
    const response = await fetch(url);
    if (!response.ok) throw new Error(`Failed to fetch data: ${response.statusText}`);
    return response.json();
  };

  const fetchCourseDetails = async (courseId: number): Promise<Course> => {
    const response = await fetch(`http://localhost:3000/api/courses/${courseId}`);
    if (!response.ok) throw new Error(`Failed to fetch course details: ${response.statusText}`);
    return response.json();
  };

  const fetchDepartmentName = async (departmentId: string): Promise<string> => {
    const response = await fetch(`http://localhost:3000/api/departments/${departmentId}`);
    if (!response.ok) throw new Error(`Failed to fetch department name: ${response.statusText}`);
    const departmentData = await response.json();
    return departmentData.department_name;
  };

  const enrichEnrollmentsWithCourseDetails = async (enrollments: Enrollment[]): Promise<Enrollment[]> => {
    for (let enrollment of enrollments) {
      const courseDetails = await fetchCourseDetails(enrollment.course_id);
      enrollment.course_prefix = courseDetails[0].course_prefix;
      enrollment.course_number = courseDetails[0].course_number;
      enrollment.credits = courseDetails[0].credits;
    }
    return enrollments;
  };

  useEffect(() => {
    const fetchAllData = async () => {
      try {
        setLoading(true);
        const [studentData, currentEnrollments, pastEnrollments] = await Promise.all([
          fetchData(`http://localhost:3000/api/students/${studentId}`),
          fetchData(`http://localhost:3000/api/enrollments/current/${studentId}`),
          fetchData(`http://localhost:3000/api/enrollments/past/${studentId}`),
        ]);

        const enrichedCurrentEnrollments = await enrichEnrollmentsWithCourseDetails(currentEnrollments);
        const enrichedPastEnrollments = await enrichEnrollmentsWithCourseDetails(pastEnrollments);

        setStudent(studentData);
        setCurrentEnrollments(enrichedCurrentEnrollments);
        setPastEnrollments(enrichedPastEnrollments);

        // Fetch department name
        const departmentName = await fetchDepartmentName(studentData.department_id);
        setDepartmentName(departmentName);
      } catch (err: any) {
        console.error("Error fetching data:", err);
        setError(err.message || "An unexpected error occurred.");
      } finally {
        setLoading(false);
      }
    };

    fetchAllData();
  }, [studentId]);

  if (loading) return <div className="spinner-border" role="status">Loading...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;

  return (
    <>
      <div className="display-6">Student Summary</div>
      <hr />
      <div className="p-3 text-dark">
        <div>
          <b>Name: </b>
          {student?.first_name} {student?.last_name}
        </div>
        <div>
          <b>Student ID: </b>
          {student?.student_id}
        </div>
        <div>
          <b>Major: </b>
          {departmentName || "N/A"}
        </div>
        <div>
          <b>GPA: </b>
          {student?.gpa}
        </div>
      </div>
      <div className="p-3">
        <div className="h5 text-body-secondary">Current Enrollments</div>
        <table className="table">
          <thead>
            <tr>
              <th scope="col">Course Prefix</th>
              <th scope="col">Course Number</th>
              <th scope="col">Semester</th>
              <th scope="col">Credits</th>
              <th scope="col">Grade</th>
            </tr>
          </thead>
          <tbody>
            {currentEnrollments.map((enrollment, index) => (
              <tr key={index}>
                <td>{enrollment.course_prefix}</td>
                <td>{enrollment.course_number}</td>
                <td>
                  {enrollment.semester} {enrollment.year_taken}
                </td>
                <td>{enrollment.credits}</td>
                <td>{enrollment.grade}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <div className="p-3">
        <div className="h5 text-body-secondary">Past Enrollments</div>
        <table className="table">
          <thead>
            <tr>
              <th scope="col">Course Prefix</th>
              <th scope="col">Course Number</th>
              <th scope="col">Semester</th>
              <th scope="col">Credits</th>
              <th scope="col">Grade</th>
            </tr>
          </thead>
          <tbody>
            {pastEnrollments.map((enrollment, index) => (
              <tr key={index}>
                <td>{enrollment.course_prefix}</td>
                <td>{enrollment.course_number}</td>
                <td>
                  {enrollment.semester} {enrollment.year_taken}
                </td>
                <td>{enrollment.credits}</td>
                <td>{enrollment.grade}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
};

export default StudentInfo;
