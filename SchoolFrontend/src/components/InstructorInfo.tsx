import { useEffect, useState } from "react";
import { Course } from "../types";

interface StudentCount {
  major: string;
  count: number;
}

const InstructorInfo = () => {
  const [currentCourses, setCurrentCourses] = useState<Course[]>([]);
  const [pastCourses, setPastCourses] = useState<Course[]>([]);
  const [totalStudents, setTotalStudents] = useState<StudentCount[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchData = async (url: string) => {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Failed to fetch data: ${response.statusText}`);
    }
    return response.json();
  };

  useEffect(() => {
    const fetchInstructorData = async () => {
      try {
        setLoading(true);

        // Replace `instructorId` with the actual ID
        const instructorId = sessionStorage.getItem("username");

        const [currentCoursesData, pastCoursesData, studentCountsData] = await Promise.all([
          fetchData(`http://localhost:3000/api/instructors/${instructorId}/current-courses`),
          fetchData(`http://localhost:3000/api/instructors/${instructorId}/past-courses`),
          fetchData(`http://localhost:3000/api/instructors/${instructorId}/student-counts`),
        ]);

        setCurrentCourses(currentCoursesData);
        setPastCourses(pastCoursesData);
        setTotalStudents(studentCountsData);
      } catch (err: any) {
        console.error("Error fetching instructor data:", err);
        setError(err.message || "An unexpected error occurred.");
      } finally {
        setLoading(false);
      }
    };

    fetchInstructorData();
  }, []);

  if (loading) return <div className="spinner-border" role="status">Loading...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;

  return (
    <>
      <div className="display-6">Instructor Summary</div>
      <hr />

      {/* Current Courses Table */}
      <div className="p-3">
        <div className="h5 text-body-secondary">Current Courses</div>
        <table className="table">
          <thead>
            <tr>
              <th scope="col">Course Prefix</th>
              <th scope="col">Course Number</th>
              <th scope="col">Semester</th>
            </tr>
          </thead>
          <tbody>
            {currentCourses.map((course, index) => (
              <tr key={index}>
                <td>{course.course_prefix}</td>
                <td>{course.course_number}</td>
                <td>
                  {course.semester} {course.year}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Past Courses Table */}
      <div className="p-3">
        <div className="h5 text-body-secondary">Past Courses</div>
        <table className="table">
          <thead>
            <tr>
              <th scope="col">Course Prefix</th>
              <th scope="col">Course Number</th>
              <th scope="col">Semester</th>
            </tr>
          </thead>
          <tbody>
            {pastCourses.map((course, index) => (
              <tr key={index}>
                <td>{course.course_prefix}</td>
                <td>{course.course_number}</td>
                <td>
                  {course.semester} {course.year}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Student Breakdown Table */}
      <div className="p-3">
        <div className="h5 text-body-secondary">Total Students</div>
        <table className="table">
          <thead>
            <tr>
              <th scope="col">Major</th>
              <th scope="col">Count</th>
            </tr>
          </thead>
          <tbody>
            {totalStudents.map((count, index) => (
              <tr key={index}>
                <td>{count.major}</td>
                <td>{count.count}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </>
  );
};

export default InstructorInfo;
