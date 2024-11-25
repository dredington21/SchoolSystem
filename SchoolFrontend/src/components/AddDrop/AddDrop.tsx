import { useState, useEffect } from "react";
import StudentIDSearch from "../StudentIDSearch";
import AddDropForm from "./AddDropForm";

const AddDrop = () => {
  const [studentID, setStudentID] = useState<string>("");

  useEffect(() => {
    // Fetch user role and student ID from session storage
    const userRole = sessionStorage.getItem("userRole");
    const storedStudentID = sessionStorage.getItem("studentId");

    console.log("UserRole:", userRole); // Debug statement
    console.log("StoredStudentID:", storedStudentID); // Debug statement

    if (userRole === "Student" && storedStudentID) {
      console.log("Setting studentID to storedStudentID:", storedStudentID); // Debug statement
      setStudentID(storedStudentID);
    }
  }, []);

  /**
   * Searches database for student associated with id value
   * TODO: Implement actual search logic
   * @param id ID to search
   */
  const handleIDSearch = (id: string) => {
    console.log("handleIDSearch called with ID:", id); // Debug statement
    setStudentID(id);
  };

  console.log("Current studentID:", studentID); // Debug statement

  return (
    <>
      <div className="display-6">Add/Drop</div>
      <hr />
      {studentID ? (
        // If the studentID is set, show that student's add/drop form
        <AddDropForm studentID={studentID} />
      ) : (
        // Otherwise (if user is an advisor), show a studentID entry form first
        <StudentIDSearch onSearch={handleIDSearch} />
      )}
    </>
  );
};

export default AddDrop;