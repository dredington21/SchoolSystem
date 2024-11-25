import { useState, useEffect } from "react";
import { Button, Col, Form, Row } from "react-bootstrap";
import { Course, Enrollment } from "../../types";

interface Props {
  studentID: string;
}

const AddDropForm = ({ studentID }: Props) => {
  const [currentCourses, setCurrentCourses] = useState<Enrollment[]>([]);
  const [newCourseIDs, setNewCourseIDs] = useState<string[]>(["", "", "", ""]);
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
    
    const courseDetails = await response.json();
    return courseDetails[0]; // Access the first element of the array
  };

  const enrichEnrollmentsWithCourseDetails = async (enrollments: Enrollment[]): Promise<Enrollment[]> => {
    for (let enrollment of enrollments) {
      const courseDetails = await fetchCourseDetails(enrollment.course_id);
      enrollment.course_prefix = courseDetails.course_prefix;
      enrollment.course_number = courseDetails.course_number;
      enrollment.credits = courseDetails.credits;
    }
    return enrollments;
  };

  useEffect(() => {
    const fetchCurrentCourses = async () => {
      try {
        setLoading(true);
        const currentEnrollments = await fetchData(`http://localhost:3000/api/enrollments/current/${studentID}`);
        const enrichedCurrentEnrollments = await enrichEnrollmentsWithCourseDetails(currentEnrollments);
        setCurrentCourses(enrichedCurrentEnrollments);
      } catch (err: any) {
        console.error("Error fetching data:", err);
        setError(err.message || "An unexpected error occurred.");
      } finally {
        setLoading(false);
      }
    };

    fetchCurrentCourses();
  }, [studentID]);

  const handleDrop = async (courseId: number) => {
    try {
      // Make the DELETE request to drop the course
      const response = await fetch(`http://localhost:3000/api/enrollments/drop/${studentID}/${courseId}`, {
        method: 'DELETE',
      });
  
      if (!response.ok) {
        throw new Error(`Failed to drop course ID: ${courseId}`);
      }
  
      // Remove the dropped course from the currentCourses state
      setCurrentCourses(currentCourses.filter(course => course.course_id !== courseId));
    } catch (error) {
      console.error('Error dropping course:', error);
      setError('Error dropping course. Please try again.');
    }
  };
  

  const handleRegister = async () => {
    try {
      // Filter out empty course IDs from the newCourseIDs array
      const courseIDsToRegister = newCourseIDs.filter(id => id.trim() !== "");
  
      // If there are no valid course IDs, do nothing
      if (courseIDsToRegister.length === 0) {
        console.error('No valid course IDs provided.');
        return;
      }
  
      // Register each course for the student
      for (let courseID of courseIDsToRegister) {
        const response = await fetch(`http://localhost:3000/api/enrollments/add/${studentID}/${courseID}`, {
          method: 'POST',
        });
  
        if (!response.ok) {
          throw new Error(`Failed to register for course ID: ${courseID}`);
        }
      }
  
      // Fetch updated courses after registration
      const updatedCourses = await fetch(`http://localhost:3000/api/enrollments/current/${studentID}`).then(response => response.json());
  
      // Enrich the updated enrollments with course details
      const enrichedUpdatedCourses = await enrichEnrollmentsWithCourseDetails(updatedCourses);
  
      // Update the current courses state with the enriched data
      setCurrentCourses(enrichedUpdatedCourses);
  
      // Clear input fields after registration
      setNewCourseIDs(["", "", "", ""]);
  
    } catch (error) {
      console.error('Error registering courses:', error);
      setError('Error registering courses. Please try again.');
    }
  };

  const handleInputChange = (index: number, value: string) => {
    const updatedCourseIDs = [...newCourseIDs];
    updatedCourseIDs[index] = value;
    setNewCourseIDs(updatedCourseIDs);
  };

  if (loading) return <div className="spinner-border" role="status">Loading...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;

  return (
    <>
      {/* Current courses table */}
      <div className="p-3">
        <div className="h5 text-body-secondary">Current enrollments</div>
        <table className="table">
          <thead>
            <tr>
              <th scope="col">Course Prefix</th>
              <th scope="col">Course Number</th>
              <th scope="col">Credits</th>
              <th scope="col">Instructor</th>
              <th scope="col">Drop Course</th>
            </tr>
          </thead>
          <tbody>
            {currentCourses?.map((course) => (
              <tr key={course.course_id}>
                <td>{course.course_prefix}</td>
                <td>{course.course_number}</td>
                <td>{course.credits}</td>
                <td>{"TBA"}</td>
                <td>
                  <button
                    type="button"
                    className="btn btn-outline-primary"
                    onClick={() => handleDrop(course.course_id)}
                  >
                    Drop Course
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Add courses form */}
      <div className="p-3">
        <div className="h5 text-body-secondary">Register for courses</div>
        <Form>
          <Row>
            {newCourseIDs.map((courseID, index) => (
              <Col key={index}>
                <Form.Group className="mb-3" controlId={`courseID-${index + 1}`}>
                  <Form.Control
                    required
                    type="text"
                    placeholder="Enter course ID"
                    value={courseID}
                    onChange={(e) => handleInputChange(index, e.target.value)}
                  />
                </Form.Group>
              </Col>
            ))}
          </Row>
          <Button onClick={handleRegister}>Register</Button>
        </Form>
      </div>
    </>
  );
};

export default AddDropForm;