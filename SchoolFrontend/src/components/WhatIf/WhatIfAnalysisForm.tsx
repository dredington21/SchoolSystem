import { ChangeEvent, FormEvent, useEffect, useState } from "react";
import { Button, Col, Form, Row } from "react-bootstrap";
import { Enrollment, emptyEnrollment } from "../../types";

interface Props {
  studentID: string;
}

/**
 * Converts letter grade to point value
 * @param grade Letter grade
 * @returns Corresponding point value
 */
const letterToPoints = (grade: string): number => {
  switch (grade) {
    case "A":
    case "S":
      return 4;
    case "B":
      return 3;
    case "C":
      return 2;
    case "D":
      return 1;
    case "F":
    case "U":
    case "I":
      return 0;
    default:
      return 0;
  }
};

/**
 * Calculates student's GPA for what-if analysis
 * @param pastEnrollments Array of already taken courses
 * @param proposedEnrollments Array of proposed courses
 * @returns New numerical GPA if proposed courses are taken
 */
const calculateGPA = (
  pastEnrollments: Enrollment[],
  proposedEnrollments: Enrollment[]
): number => {
  let totalPoints = 0;
  let totalCredits = 0;
  let totalCreditsForGPA = 0; // Separate variable to store total credits for GPA calculation
  const allEnrollments = [...pastEnrollments, ...proposedEnrollments];
  
  allEnrollments.forEach((enrollment) => {
    if (enrollment.course) {
      const credits = Number(enrollment.course.credits) || 0; // Ensure credits are treated as numbers
      const points = letterToPoints(enrollment.grade);
      totalPoints += points * credits;
      totalCredits += credits;
      totalCreditsForGPA += credits; // Add credits to the separate variable
      console.log(`Letter: ${enrollment.grade}, Points: ${points}, Credits: ${credits}`);
    } else {
      console.warn(`Enrollment with course_id ${enrollment.course_id} has no course details.`);
    }
  });
  console.log(`Total points: ${totalPoints}, Total credits: ${totalCredits}, Total credits for GPA: ${totalCreditsForGPA}`);
  return totalCreditsForGPA > 0 ? totalPoints / totalCreditsForGPA : 0; // Prevent division by zero
};

const WhatIfAnalysisForm = ({ studentID }: Props) => {
  const [pastEnrollments, setPastEnrollments] = useState<Enrollment[]>([]);
  const [proposedEnrollments, setProposedEnrollments] = useState<Enrollment[]>([]);
  const [newEnrollment, setNewEnrollment] = useState<Enrollment>(emptyEnrollment);
  const [proposedGPA, setProposedGPA] = useState<number>(0);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchData = async (url: string) => {
    const response = await fetch(url);
    if (!response.ok) throw new Error(`Failed to fetch data: ${response.statusText}`);
    return response.json();
  };

  const fetchCourseDetails = async (courseId: number) => {
    const response = await fetch(`http://localhost:3000/api/courses/${courseId}`);
    if (!response.ok) throw new Error(`Failed to fetch course details: ${response.statusText}`);
    return response.json();
  };

  const enrichEnrollmentsWithCourseDetails = async (enrollments: Enrollment[]) => {
    for (let enrollment of enrollments) {
      const courseDetails = await fetchCourseDetails(enrollment.course_id);
        enrollment.course = {
        course_id: courseDetails[0].course_id,
        course_prefix: courseDetails[0].course_prefix,
        course_number: courseDetails[0].course_number,
        credits: courseDetails[0].credits,
        semesters: courseDetails[0].semesters
      };
    }
    return enrollments;
  };

  useEffect(() => {
    const fetchPastEnrollments = async () => {
      try {
        setLoading(true);
        const pastEnrollmentsData = await fetchData(`http://localhost:3000/api/enrollments/past/${studentID}`);
        const enrichedPastEnrollments = await enrichEnrollmentsWithCourseDetails(pastEnrollmentsData);
        setPastEnrollments(enrichedPastEnrollments);
        setProposedGPA(calculateGPA(enrichedPastEnrollments, []));
      } catch (err: any) {
        console.error("Error fetching data:", err);
        setError(err.message || "An unexpected error occurred.");
      } finally {
        setLoading(false);
      }
    };

    fetchPastEnrollments();
  }, [studentID]);

  const handleSubmit = (event: FormEvent) => {
    event.preventDefault();
    const updatedEnrollments = [...proposedEnrollments, newEnrollment];
    setProposedEnrollments(updatedEnrollments);
    setNewEnrollment(emptyEnrollment);
    setProposedGPA(calculateGPA(pastEnrollments, updatedEnrollments));
  };

  const handleInputChange = (e: ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;

    // Update the correct part of the state (newEnrollment)
    if (name === "grade") {
      // For the grade field, update it directly on newEnrollment
      setNewEnrollment((prevEnrollment) => ({
        ...prevEnrollment,
        [name]: value,
      }));
    } else {
      // For course-related fields, update the course object
      setNewEnrollment((prevEnrollment) => ({
        ...prevEnrollment,
        course: {
          ...prevEnrollment.course,
          [name]: value,
        },
      }));
    }
  };

  if (loading) return <div className="spinner-border" role="status">Loading...</div>;
  if (error) return <div className="alert alert-danger">Error: {error}</div>;

  return (
    <>
      
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
                <td>{enrollment.course.course_prefix}</td>
                <td>{enrollment.course.course_number}</td>
                <td>{enrollment.semester} {enrollment.year_taken}</td>
                <td>{enrollment.course.credits}</td>
                <td>{enrollment.grade}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
      <div className="p-3">
        <div className="h5 text-body-secondary">Proposed Enrollments</div>
        <Form onSubmit={handleSubmit}>
          <Row>
            <Col>
              <Form.Group className="mb-3" controlId="prefix">
                <Form.Control
                  required
                  type="text"
                  placeholder="Course Prefix"
                  name="course_prefix"
                  value={newEnrollment.course.course_prefix}
                  onChange={handleInputChange}
                />
              </Form.Group>
            </Col>
            <Col>
              <Form.Group className="mb-3" controlId="number">
                <Form.Control
                  required
                  type="text"
                  placeholder="Course Number"
                  name="course_number"
                  value={newEnrollment.course.course_number}
                  onChange={handleInputChange}
                />
              </Form.Group>
            </Col>
            <Col>
              <Form.Group className="mb-3" controlId="credits">
                <Form.Control
                  required
                  type="number"
                  placeholder="Credits"
                  name="credits"
                  value={newEnrollment.course.credits}
                  onChange={handleInputChange}
                />
              </Form.Group>
            </Col>
            <Col>
              <Form.Group className="mb-3" controlId="grade">
                <Form.Control
                  required
                  type="text"
                  placeholder="Grade"
                  name="grade"
                  value={newEnrollment.grade}
                  onChange={handleInputChange}
                />
              </Form.Group>
            </Col>
          </Row>
          <Button type="submit">Add Course</Button>
        </Form>
        <div className="mt-3">
          <div className="h5 text-body-secondary">Proposed GPA: {proposedGPA.toFixed(2)}</div>
        </div>
      </div>
    </>
  );
};

export default WhatIfAnalysisForm;