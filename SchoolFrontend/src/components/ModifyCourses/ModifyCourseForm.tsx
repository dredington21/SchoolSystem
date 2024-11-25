import { ChangeEvent, useEffect, useState } from "react";
import { Button, Col, Form, Modal, Row } from "react-bootstrap";
import { Course, emptyCourse } from "../../types";

interface Props {
  show: boolean; // Whether to show modal form
  course: Course | null; // Course being modified
  onClose: () => void; // Function to handle closing modal
  onSave: (updatedCourse: Course) => void; // Function to handle submitting changes
}

const ModifyCourseForm = ({ show, course, onClose, onSave }: Props) => {
  const [updatedCourse, setUpdatedCourse] = useState<Course>(emptyCourse); // Course to modify

  // Sets updatedCourse value to the course being edited
  useEffect(() => {
    setUpdatedCourse(course ? course : emptyCourse);
  }, [course]);

  // Updates the value being modified in updatedCourse
  const handleInputChange = (e: ChangeEvent<HTMLInputElement>) => {
    setUpdatedCourse((prevCourse) => ({
      ...prevCourse,
      [e.target.name]: e.target.value,
    }));
  };

  return (
    <Modal show={show} onHide={onClose}>
      <Modal.Header closeButton>
        <Modal.Title>Edit Course Details</Modal.Title>
      </Modal.Header>

      <Modal.Body>
        <Form>
          <Row>
            <Col>
              <Form.Group className="mb-3" controlId="course_prefix">
                <Form.Label>Course Prefix</Form.Label>
                <Form.Control
                  required
                  type="text"
                  placeholder="Enter course prefix"
                  name="course_prefix"
                  value={updatedCourse.course_prefix || ""}
                  onChange={handleInputChange}
                />
              </Form.Group>
            </Col>
            <Col>
              <Form.Group className="mb-3" controlId="course_number">
                <Form.Label>Course Number</Form.Label>
                <Form.Control
                  required
                  type="number"
                  min={0}
                  placeholder="Enter course number"
                  name="course_number"
                  value={updatedCourse.course_number || ""}
                  onChange={handleInputChange}
                />
              </Form.Group>
            </Col>
          </Row>
          <Row>
            <Col>
              <Form.Group className="mb-3" controlId="semesters">
                <Form.Label>Semester</Form.Label>
                <Form.Control
                  required
                  type="text"
                  placeholder="Enter course semester"
                  name="semesters"
                  value={updatedCourse.semesters || ""}
                  onChange={handleInputChange}
                />
              </Form.Group>
            </Col>
            <Col>
              <Form.Group className="mb-3" controlId="year_taken">
                <Form.Label>Year</Form.Label>
                <Form.Control
                  required
                  type="number"
                  min={0}
                  placeholder="Enter course year"
                  name="year_taken"
                  value={updatedCourse.year_taken || ""}
                  onChange={handleInputChange}
                />
              </Form.Group>
            </Col>
          </Row>
          <Form.Group className="mb-3" controlId="credits">
            <Form.Label>Credits</Form.Label>
            <Form.Control
              required
              type="number"
              min={0}
              placeholder="Enter course credits"
              name="credits"
              value={updatedCourse.credits || ""}
              onChange={handleInputChange}
            />
          </Form.Group>
          <Form.Group className="mb-3" controlId="instructor_id">
            <Form.Label>Instructor</Form.Label>
            <Form.Control
              required
              type="text"
              placeholder="Enter course instructor"
              name="instructor_id"
              value={updatedCourse.instructor_id || ""}
              onChange={handleInputChange}
            />
          </Form.Group>
        </Form>
      </Modal.Body>

      <Modal.Footer>
        <Button variant="secondary" onClick={onClose}>
          Close
        </Button>
        <Button variant="primary" onClick={() => onSave(updatedCourse)}>
          Save Changes
        </Button>
      </Modal.Footer>
    </Modal>
  );
};

export default ModifyCourseForm;
