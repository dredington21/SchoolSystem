import { useState, useEffect } from "react";
import { Button } from "react-bootstrap";
import ModifyCourseForm from "./ModifyCourseForm";
import { Course } from "../../types";

const ModifyCourses = () => {
  const [deptCourses, setDeptCourses] = useState<Course[]>([]);
  const [showForm, setShowForm] = useState(false);
  const [editCourse, setEditCourse] = useState<Course | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  /**
   * Fetches the department courses data (mocked here)
   */
  const fetchDeptCourses = async () => {
    try {
      setLoading(true);
      // Simulate API call (replace with your actual API endpoint)
      const response = await fetch("http://localhost:3000/api/courses");
      if (!response.ok) throw new Error("Failed to fetch courses");
      const coursesData = await response.json();
      setDeptCourses(coursesData);
    } catch (err: any) {
      setError(err.message || "An unexpected error occurred.");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchDeptCourses();
  }, []);

  /**
   * Handles clicking on edit button
   * @param course Course being edited (so the form can be prefilled with its info)
   */
  const handleEditClick = (course: Course | null) => {
    setEditCourse(course);
    setShowForm(true); // Display edit form
  };

  /**
   * Handles saving course modifications
   * TODO: update course edits in database (call API to save the course data)
   * @param updatedCourse New data for edited course
   */
  const handleSave = async (updatedCourse: Course) => {
    if (updatedCourse) {
      try {
        setLoading(true);
        let updatedCourses;
        
        if (updatedCourse.course_id) {
          // Edit existing course using URL parameters (excluding department_id)
          const { course_id, course_prefix, course_number, credits, semesters } = updatedCourse;
  
          const response = await fetch(
            `http://localhost:3000/api/courses/${course_id}/${course_prefix}/${course_number}/${credits}/${semesters}`,
            {
              method: "PUT",
              headers: { "Content-Type": "application/json" },
              body: JSON.stringify({}) // You don't need to send any body since all data is in the URL
            }
          );
  
          if (!response.ok) throw new Error("Failed to update course");
  
          // Update local courses state after successful edit
          updatedCourses = deptCourses.map((course) =>
            course.course_id === updatedCourse.course_id ? updatedCourse : course
          );
        } else {
          // Add new course (department_id can be included in the body if needed)
          const response = await fetch("http://localhost:3000/api/courses", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify(updatedCourse),
          });
          if (!response.ok) throw new Error("Failed to add new course");
  
          const newCourse = await response.json();
          updatedCourses = [...deptCourses, newCourse];
        }
        setDeptCourses(updatedCourses); // Update local state with the new course data
      } catch (err: any) {
        setError(err.message || "An unexpected error occurred.");
      } finally {
        setLoading(false);
      }
    }
    handleClose(); // Close form after saving
  };
  
  

  /**
   * Closes editing form
   */
  const handleClose = () => {
    setShowForm(false);
  };

  if (loading) return <div className="spinner-border" role="status">Loading...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;

  return (
    <>
      <div className="display-6">Modify Courses</div>
      <hr />
      {/* Department courses table */}
      <div className="p-3">
        <table className="table">
          <thead>
            <tr>
              <th scope="col">Course ID</th>
              <th scope="col">Course Prefix</th>
              <th scope="col">Course Number</th>
              <th scope="col">Credits</th>
              <th scope="col">Instructor</th>
              <th scope="col">Edit Course Details</th>
            </tr>
          </thead>
          <tbody>
            {deptCourses.map((course) => (
              <tr key={course.course_id}>
                <td>{course.course_id}</td>
                <td>{course.course_prefix}</td>
                <td>{course.course_number}</td>
                <td>{course.credits}</td>
                <td>{"TBD"}</td>
                <td>
                  <button
                    type="button"
                    className="btn btn-outline-primary"
                    onClick={() => {
                      handleEditClick(course); // Open form with selected course
                    }}
                  >
                    Edit
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Button for adding new course */}
      <div className="p-3">
        <Button onClick={() => handleEditClick(null)}>Add New Course</Button>
      </div>

      {/* Modify course form shows if showForm is true */}
      <ModifyCourseForm
        show={showForm}
        course={editCourse}
        onClose={handleClose}
        onSave={handleSave}
      />
    </>
  );
};

export default ModifyCourses;
